import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/isar_config.dart';
import '../../../../core/services/gemini_action_executor.dart';
import '../../../../core/services/gemini_companion_service.dart';
import '../../../../core/theme/app_theme_provider.dart';
import '../../data/models/ai_chat_agent.dart';
import '../../data/models/ai_chat_message.dart' as chat_models;
import '../../data/services/ai_chat_local_store.dart';
import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../recipes/presentation/providers/recipe_provider.dart';
import '../../../shopping/presentation/providers/shopping_provider.dart';
import '../../../workouts/presentation/providers/workout_catalog_provider.dart';
import '../../../dashboard/presentation/providers/daily_macros_provider.dart';
import '../../../dashboard/presentation/providers/today_hub_provider.dart';
import '../../../tracking/presentation/providers/water_intake_provider.dart';

/// Pantalla de conversación con Fiti enriquecida con contexto local de la app.
class GeminiChatScreen extends ConsumerStatefulWidget {
  /// Crea una [GeminiChatScreen].
  const GeminiChatScreen({super.key, this.initialAgent = AiChatAgent.boss});

  final AiChatAgent initialAgent;

  @override
  ConsumerState<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends ConsumerState<GeminiChatScreen> {
  final FitiCoachService _service = FitiCoachService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = <_ChatMessage>[];
  AiChatAgent _selectedAgent = AiChatAgent.boss;
  bool _isBootstrapping = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedAgent = widget.initialAgent;
    _loadPersistedConversation();
  }

  @override
  void dispose() {
    _service.resetChat();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(appThemeProvider);
    final t = _agentTheme(_selectedAgent, theme: appTheme);

    return Scaffold(
      backgroundColor: t.bg,
      // ── AppBar completamente personalizado ──────────────────────────────
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _ChatAppBar(
          agent: _selectedAgent,
          theme: t,
          isBusy: _isLoading || _isBootstrapping,
          onSelectAgent: _selectAgent,
          onNewChat: _startNewConversation,
        ),
      ),
      body: Column(
        children: [
          // ── Subheader de contexto ───────────────────────────────────────
          _ContextStrip(agent: _selectedAgent, theme: t),

          // ── Mensajes ────────────────────────────────────────────────────
          Expanded(
            child: _isBootstrapping
                ? Center(
                    child: CircularProgressIndicator(
                        color: t.accent, strokeWidth: 2))
                : _messages.isEmpty
                    ? _EmptyState(agent: _selectedAgent, theme: t)
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                        itemCount:
                            _messages.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (_isLoading && index == _messages.length) {
                            return _ThinkingBubble(theme: t);
                          }
                          final msg = _messages[index];
                          final isUser = msg.role == _ChatRole.user;
                          return _MessageBubble(
                            message: msg,
                            isUser: isUser,
                            theme: t,
                            onApproveAction: msg.actionStatus ==
                                    _ChatActionStatus.pending
                                ? (i) => _setActionDecision(index, i,
                                    _ChatActionDecision.approved)
                                : null,
                            onRejectAction: msg.actionStatus ==
                                    _ChatActionStatus.pending
                                ? (i) => _setActionDecision(index, i,
                                    _ChatActionDecision.rejected)
                                : null,
                            onApply: msg.actionStatus ==
                                        _ChatActionStatus.pending &&
                                    msg.isReadyToApply
                                ? () => _applyActions(index)
                                : null,
                            onDismiss: msg.actionStatus ==
                                    _ChatActionStatus.pending
                                ? () => _dismissActions(index)
                                : null,
                          );
                        },
                      ),
          ),

          // ── Input area ──────────────────────────────────────────────────
          SafeArea(
            top: false,
            child: _InputArea(
              controller: _messageController,
              agent: _selectedAgent,
              theme: t,
              isLoading: _isLoading,
              showSuggestions: !_isBootstrapping && _messages.isEmpty,
              onSend: _handleSend,
              onSuggestion: (text) {
                _messageController.text = text;
                _handleSend();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSend() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _isLoading || _isBootstrapping) {
      return;
    }

    final targetAgent = _resolveTargetAgent(message);
    if (targetAgent != _selectedAgent) {
      await _rerouteConversation(targetAgent);
      if (!mounted) {
        return;
      }
    }

    final historyForPrompt = _messages
        .map(
          (entry) => GeminiConversationContextTurn(
            role: entry.role == _ChatRole.user
                ? GeminiConversationRole.user
                : GeminiConversationRole.assistant,
            text: entry.text,
          ),
        )
        .toList(growable: false);

    final isar = await IsarConfig.ensureInitialized();
    final conversation = await AiChatLocalStore.loadOrCreateConversation(
      isar,
      _selectedAgent,
    );
    final persistedUserMessage = await AiChatLocalStore.appendMessage(
      isar: isar,
      conversationId: conversation.id,
      role: chat_models.AiChatMessageRole.user,
      text: message,
    );

    setState(() {
      _messages.add(
        _ChatMessage(
          id: persistedUserMessage.id,
          role: _ChatRole.user,
          text: message,
          actionStatus: _ChatActionStatus.none,
        ),
      );
      _isLoading = true;
    });
    _messageController.clear();
    _scrollToBottom();

    final response = await _service.askGemini(
      message,
      isar,
      agent: _selectedAgent,
      conversationHistory: historyForPrompt,
    );
    final actionsJson = response.actions.isEmpty
        ? null
        : AiChatLocalStore.encodeActionsJson(
            response.actions.map((action) => action.raw).toList(growable: false),
          );
    final persistedAssistantMessage = await AiChatLocalStore.appendMessage(
      isar: isar,
      conversationId: conversation.id,
      role: chat_models.AiChatMessageRole.assistant,
      text: response.reply,
      actionsJson: actionsJson,
      actionStatus: response.actions.isEmpty
          ? chat_models.AiChatMessageActionStatus.none
          : chat_models.AiChatMessageActionStatus.pending,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _messages.add(
        _ChatMessage(
          id: persistedAssistantMessage.id,
          role: _ChatRole.assistant,
          text: response.reply,
          actions: response.actions,
          actionDecisions: List<_ChatActionDecision>.filled(
            response.actions.length,
            _ChatActionDecision.undecided,
          ),
          actionStatus: response.actions.isEmpty
              ? _ChatActionStatus.none
              : _ChatActionStatus.pending,
        ),
      );
      _isLoading = false;
    });
    _scrollToBottom();
  }

  Future<void> _applyActions(int index) async {
    final message = _messages[index];
    if (message.actions.isEmpty ||
        message.actionStatus != _ChatActionStatus.pending) {
      return;
    }

    if (message.hasUndecidedActions) {
      return;
    }

    final approvedActions = message.approvedActions;
    if (approvedActions.isEmpty) {
      await _dismissActions(index, summary: 'No se aprobó ningún cambio.');
      return;
    }

    setState(() {
      _messages[index] = message.copyWith(
        actionStatus: _ChatActionStatus.applying,
        actionResult: 'Aplicando cambios aprobados...',
      );
    });

    final isar = await IsarConfig.ensureInitialized();
    if (message.id != null) {
      await AiChatLocalStore.updateMessageActionState(
        isar: isar,
        messageId: message.id!,
        status: chat_models.AiChatMessageActionStatus.applying,
        actionResult: 'Aplicando cambios aprobados...',
      );
    }

    final databaseActions = approvedActions
        .where((action) => action.type != GeminiActionType.openShoppingList)
        .toList(growable: false);
    final navigationActions = approvedActions
        .where((action) => action.type == GeminiActionType.openShoppingList)
        .toList(growable: false);
    final weeklyMenuAction = approvedActions.where(
      (action) => action.type == GeminiActionType.planWeeklyMenu,
    ).firstOrNull;

    var appliedCount = 0;
    final summaries = <String>[];

    if (databaseActions.isNotEmpty) {
      final result = await GeminiActionExecutor.apply(
        actions: databaseActions,
        isar: isar,
      );
      appliedCount += result.applied;
      if (result.summary.trim().isNotEmpty) {
        summaries.add(result.summary.trim());
      }
    }

    if (navigationActions.isNotEmpty) {
      appliedCount += 1;
      summaries.add('OK: lista de la compra abierta.');
    }

    if (!mounted) {
      return;
    }

    if (databaseActions.isNotEmpty) {
      ref.invalidate(inventoryProvider);
      ref.invalidate(recipeListProvider);
      ref.invalidate(workoutCatalogProvider);
    }

    final executionSummary = summaries.isEmpty
        ? 'No se pudo aplicar ningún cambio.'
        : summaries.join('\n');

    setState(() {
      _messages[index] = _messages[index].copyWith(
        actionStatus: appliedCount > 0
            ? _ChatActionStatus.applied
            : _ChatActionStatus.failed,
        actionResult: _buildActionSummary(message, executionSummary),
      );
    });
    if (message.id != null) {
      await AiChatLocalStore.updateMessageActionState(
        isar: isar,
        messageId: message.id!,
        status: appliedCount > 0
            ? chat_models.AiChatMessageActionStatus.applied
            : chat_models.AiChatMessageActionStatus.failed,
        actionResult: _buildActionSummary(message, executionSummary),
      );
    }

    if (weeklyMenuAction != null) {
      final previousRange = ref.read(shoppingRangeProvider);
      final startDate = DateTime.tryParse(
        weeklyMenuAction.payload['startDate']?.toString() ?? '',
      );
      final normalizedStart = startDate == null
          ? DateTime.now()
          : DateTime(startDate.year, startDate.month, startDate.day);
      final normalizedEnd = DateTime(
        normalizedStart.year,
        normalizedStart.month,
        normalizedStart.day,
      ).add(const Duration(days: 6));
      ref.invalidate(
        shoppingListProvider(previousRange.start, previousRange.end),
      );
      ref.invalidate(
        shoppingManualItemsProvider(previousRange.start, previousRange.end),
      );
      ref.invalidate(
        shoppingListProvider(normalizedStart, normalizedEnd),
      );
      ref.invalidate(
        shoppingManualItemsProvider(normalizedStart, normalizedEnd),
      );
      ref
          .read(shoppingRangeProvider.notifier)
          .setRange(DateTimeRange(start: normalizedStart, end: normalizedEnd));
    }

    if ((navigationActions.isNotEmpty || weeklyMenuAction != null) && mounted) {
      context.push('/shopping-list');
    }
    _scrollToBottom();
  }

  Future<void> _dismissActions(int index, {String? summary}) async {
    final message = _messages[index];
    if (message.actions.isEmpty ||
        message.actionStatus != _ChatActionStatus.pending) {
      return;
    }

    setState(() {
      _messages[index] = message.copyWith(
        actionStatus: _ChatActionStatus.dismissed,
        actionResult: summary ?? 'Cambios ignorados por el usuario.',
      );
    });

    if (message.id == null) {
      return;
    }

    final isar = await IsarConfig.ensureInitialized();
    await AiChatLocalStore.updateMessageActionState(
      isar: isar,
      messageId: message.id!,
      status: chat_models.AiChatMessageActionStatus.dismissed,
      actionResult: summary ?? 'Cambios ignorados por el usuario.',
    );
  }

  void _setActionDecision(
    int messageIndex,
    int actionIndex,
    _ChatActionDecision decision,
  ) {
    final message = _messages[messageIndex];
    if (message.actionStatus != _ChatActionStatus.pending ||
        actionIndex < 0 ||
        actionIndex >= message.actionDecisions.length) {
      return;
    }

    final updatedDecisions = [...message.actionDecisions];
    updatedDecisions[actionIndex] = decision;
    setState(() {
      _messages[messageIndex] = message.copyWith(
        actionDecisions: updatedDecisions,
      );
    });
  }

  String _buildActionSummary(_ChatMessage message, String executionSummary) {
    final rejectedCount = message.rejectedCount;
    if (rejectedCount <= 0) {
      return executionSummary;
    }
    return '$executionSummary\nOmitidos por el usuario: $rejectedCount.';
  }

  Future<void> _loadPersistedConversation() async {
    final isar = await IsarConfig.ensureInitialized();
    final conversation = await AiChatLocalStore.loadOrCreateConversation(
      isar,
      _selectedAgent,
    );
    final storedMessages = await AiChatLocalStore.loadConversationMessages(
      isar,
      conversation.id,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _messages
        ..clear()
        ..addAll(storedMessages.map(_ChatMessage.fromRecord));
      _isBootstrapping = false;
    });
    _scrollToBottom();
  }

  Future<void> resetChat() async {
    _service.resetChat(_selectedAgent);
  }

  Future<void> _startNewConversation() async {
    final isar = await IsarConfig.ensureInitialized();
    await AiChatLocalStore.clearConversation(isar, _selectedAgent);
    await resetChat();

    if (!mounted) {
      return;
    }

    setState(() {
      _messages.clear();
    });
  }

  Future<void> _selectAgent(AiChatAgent agent) async {
    if (agent == _selectedAgent || _isLoading || _isBootstrapping) {
      return;
    }

    setState(() {
      _selectedAgent = agent;
      _isBootstrapping = true;
      _messages.clear();
    });

    await _loadPersistedConversation();
  }

  AiChatAgent _resolveTargetAgent(String message) {
    if (_selectedAgent != AiChatAgent.boss || _messages.isNotEmpty) {
      return _selectedAgent;
    }
    return inferAiChatAgentForMessage(message);
  }

  Future<void> _rerouteConversation(AiChatAgent agent) async {
    final isar = await IsarConfig.ensureInitialized();
    final conversation = await AiChatLocalStore.loadOrCreateConversation(
      isar,
      agent,
    );
    final storedMessages = await AiChatLocalStore.loadConversationMessages(
      isar,
      conversation.id,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _selectedAgent = agent;
      _messages
        ..clear()
        ..addAll(storedMessages.map(_ChatMessage.fromRecord));
    });
    _scrollToBottom();

    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Consulta reenrutada a ${agent.displayName}.')),
      );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Tema por agente — rediseñado
// ─────────────────────────────────────────────────────────────────────────────

class _AgentTheme {
  const _AgentTheme({
    required this.bg,
    required this.headerBg,
    required this.accent,
    required this.accentFg,
    required this.text,
    required this.muted,
    required this.userBubble,
    required this.userBubbleFg,
    required this.aiBubble,
    required this.aiBubbleFg,
    required this.inputBg,
    required this.inputBorder,
    required this.divider,
    required this.icon,
    required this.label,
  });

  final Color bg;
  final Color headerBg;
  final Color accent;
  final Color accentFg;
  final Color text;
  final Color muted;
  final Color userBubble;
  final Color userBubbleFg;
  final Color aiBubble;
  final Color aiBubbleFg;
  final Color inputBg;
  final Color inputBorder;
  final Color divider;
  final IconData icon;
  final String label;
}

// Alias de compatibilidad con el código viejo de _ActionPreviewCard
typedef _AgentThemeData = _AgentTheme;

_AgentTheme _agentTheme(AiChatAgent agent, {AppTheme theme = AppTheme.original}) {
  final colors = getThemeColors(theme);
  return _AgentTheme(
    bg: colors.bg,
    headerBg: colors.headerBg,
    accent: colors.accent,
    accentFg: colors.accentFg,
    text: colors.text,
    muted: colors.muted,
    userBubble: colors.userBubble,
    userBubbleFg: colors.userBubbleFg,
    aiBubble: colors.aiBubble,
    aiBubbleFg: colors.aiBubbleFg,
    inputBg: colors.inputBg,
    inputBorder: colors.inputBorder,
    divider: colors.divider,
    icon: colors.icon,
    label: colors.label,
  );
}


// ─────────────────────────────────────────────────────────────────────────────
// AppBar personalizado con selector de agente integrado
// ─────────────────────────────────────────────────────────────────────────────

class _ChatAppBar extends StatelessWidget {
  const _ChatAppBar({
    required this.agent,
    required this.theme,
    required this.isBusy,
    required this.onSelectAgent,
    required this.onNewChat,
  });

  final AiChatAgent agent;
  final _AgentTheme theme;
  final bool isBusy;
  final ValueChanged<AiChatAgent> onSelectAgent;
  final VoidCallback onNewChat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.headerBg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 8,
        bottom: 0,
      ),
      child: Row(
        children: [
          // Icono del agente activo
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: theme.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(theme.icon, color: theme.accent, size: 18),
          ),
          const SizedBox(width: 10),
          // Nombre
          Expanded(
            child: Text(
              agent.displayName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.text,
              ),
            ),
          ),
          // Selector de agentes en pills
          Row(
            children: AiChatAgent.values.map((a) {
              final selected = a == agent;
              final t = _agentTheme(a);
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: isBusy ? null : () => onSelectAgent(a),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected
                          ? t.accent
                          : t.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(t.icon,
                            size: 12,
                            color: selected ? t.accentFg : t.accent),
                        const SizedBox(width: 4),
                        Text(
                          t.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: selected ? t.accentFg : t.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Nueva conversación
          IconButton(
            icon: Icon(Icons.add_comment_outlined,
                size: 20, color: theme.muted),
            onPressed: isBusy ? null : onNewChat,
            tooltip: 'Nueva conversación',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Strip de contexto (kcal, agua, tareas)
// ─────────────────────────────────────────────────────────────────────────────

class _ContextStrip extends ConsumerWidget {
  const _ContextStrip({required this.agent, required this.theme});
  final AiChatAgent agent;
  final _AgentTheme theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final macros = ref.watch(dailyMacrosProvider).asData?.value;
    final hub = ref.watch(todayHubProvider).asData?.value;
    final waterMl = ref.watch(waterIntakeProvider).asData?.value
            ?.fold<int>(0, (s, e) => s + (e.mililitros as int))
            .toDouble() ??
        0;

    final kcal = macros?.kcalConsumidas ?? 0;
    final goal = macros?.kcalObjetivo ?? 0;
    final pending = hub?.pendingTaskCount ?? 0;
    final hasWorkout = hub?.hasActiveWorkout ?? false;

    if (kcal == 0 && pending == 0 && !hasWorkout) {
      return Container(height: 1, color: theme.divider);
    }

    final items = <_CtxItem>[];
    if (kcal > 0 && goal > 0) {
      items.add(_CtxItem(
          icon: Icons.local_fire_department_outlined,
          text: '${kcal.toStringAsFixed(0)} kcal'));
    }
    if (waterMl > 0) {
      items.add(_CtxItem(
          icon: Icons.water_drop_outlined,
          text: '${(waterMl / 1000).toStringAsFixed(1)} L'));
    }
    if (pending > 0) {
      items.add(
          _CtxItem(icon: Icons.checklist_outlined, text: '$pending tareas'));
    }
    if (hasWorkout) {
      items.add(_CtxItem(
          icon: Icons.fitness_center_outlined, text: 'Sesión activa'));
    }

    return Container(
      color: theme.headerBg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              Container(
                width: 1,
                height: 12,
                color: theme.muted.withValues(alpha: 0.3),
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
            Icon(items[i].icon, size: 12, color: theme.accent),
            const SizedBox(width: 4),
            Text(items[i].text,
                style: TextStyle(fontSize: 11, color: theme.muted)),
          ],
        ],
      ),
    );
  }
}

class _CtxItem {
  const _CtxItem({required this.icon, required this.text});
  final IconData icon;
  final String text;
}

// ─────────────────────────────────────────────────────────────────────────────
// Estado vacío
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.agent, required this.theme});
  final AiChatAgent agent;
  final _AgentTheme theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(theme.icon, color: theme.accent, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              agent.displayName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              agent.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: theme.muted, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Burbuja de mensaje
// ─────────────────────────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isUser,
    required this.theme,
    this.onApproveAction,
    this.onRejectAction,
    this.onApply,
    this.onDismiss,
  });

  final _ChatMessage message;
  final bool isUser;
  final _AgentTheme theme;
  final ValueChanged<int>? onApproveAction;
  final ValueChanged<int>? onRejectAction;
  final VoidCallback? onApply;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Avatar del agente (izquierda)
          if (!isUser) ...[
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 8, bottom: 2),
              decoration: BoxDecoration(
                color: theme.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(theme.icon, size: 14, color: theme.accent),
            ),
          ],

          // Burbuja
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.78,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isUser ? theme.userBubble : theme.aiBubble,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isUser
                        ? Text(
                            message.text,
                            style: TextStyle(
                              fontSize: 15,
                              color: theme.userBubbleFg,
                              height: 1.45,
                            ),
                          )
                        : MarkdownBody(
                            data: message.text,
                            selectable: true,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(
                                  fontSize: 15,
                                  color: theme.aiBubbleFg,
                                  height: 1.5),
                              h1: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: theme.aiBubbleFg),
                              h2: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.aiBubbleFg),
                              h3: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: theme.aiBubbleFg),
                              listBullet: TextStyle(
                                  fontSize: 15, color: theme.aiBubbleFg),
                              strong: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: theme.accent),
                              code: TextStyle(
                                fontSize: 13,
                                color: theme.accent,
                                backgroundColor:
                                    theme.accent.withValues(alpha: 0.1),
                              ),
                            ),
                          ),
                    if (message.actions.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _ActionCard(
                        theme: theme,
                        actions: message.actions,
                        actionDecisions: message.actionDecisions,
                        status: message.actionStatus,
                        resultMessage: message.actionResult,
                        onApproveAction: onApproveAction,
                        onRejectAction: onRejectAction,
                        onApply: onApply,
                        onDismiss: onDismiss,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Espacio donde iría el avatar en mensajes de usuario
          if (isUser) const SizedBox(width: 36),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Burbuja "pensando"
// ─────────────────────────────────────────────────────────────────────────────

class _ThinkingBubble extends StatelessWidget {
  const _ThinkingBubble({required this.theme});
  final _AgentTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(right: 8, bottom: 2),
            decoration: BoxDecoration(
              color: theme.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(theme.icon, size: 14, color: theme.accent),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.aiBubble,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Dot(color: theme.accent, delay: 0),
                const SizedBox(width: 4),
                _Dot(color: theme.accent, delay: 150),
                const SizedBox(width: 4),
                _Dot(color: theme.accent, delay: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({required this.color, required this.delay});
  final Color color;
  final int delay;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _anim = Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Opacity(
        opacity: _anim.value,
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
              color: widget.color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Input area con sugerencias
// ─────────────────────────────────────────────────────────────────────────────

class _InputArea extends StatelessWidget {
  const _InputArea({
    required this.controller,
    required this.agent,
    required this.theme,
    required this.isLoading,
    required this.showSuggestions,
    required this.onSend,
    required this.onSuggestion,
  });

  final TextEditingController controller;
  final AiChatAgent agent;
  final _AgentTheme theme;
  final bool isLoading;
  final bool showSuggestions;
  final VoidCallback onSend;
  final ValueChanged<String> onSuggestion;

  static const _suggestions = <AiChatAgent, List<String>>{
    AiChatAgent.boss: [
      '¿Qué toca hoy?',
      'Resumen del día',
      '¿Cardio o pesas?',
      'Ajustar calorías',
    ],
    AiChatAgent.nutrition: [
      '¿Qué como mañana?',
      'Cena rápida hoy',
      'Estoy corto de proteína',
      'Lista de la compra',
    ],
    AiChatAgent.workout: [
      '¿Qué entreno toca?',
      'Sesión de 30 min',
      '¿Descanso hoy?',
      'Mi progresión esta semana',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final chips = _suggestions[agent] ?? [];

    return Container(
      color: theme.headerBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: theme.divider),

          // Chips de sugerencias
          if (showSuggestions && chips.isNotEmpty)
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                itemCount: chips.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => onSuggestion(chips[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: theme.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                          color: theme.accent.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      chips[i],
                      style: TextStyle(
                          fontSize: 12,
                          color: theme.accent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),

          // Input + botón
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.inputBg,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: theme.inputBorder),
                    ),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: theme.text, fontSize: 15),
                      cursorColor: theme.accent,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                      decoration: InputDecoration(
                        hintText: agent.composerHint,
                        hintStyle:
                            TextStyle(color: theme.muted, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: isLoading ? null : onSend,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: isLoading
                          ? theme.accent.withValues(alpha: 0.4)
                          : theme.accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(13),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.accentFg,
                            ),
                          )
                        : Icon(Icons.arrow_upward_rounded,
                            color: theme.accentFg, size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de acciones propuestas — misma lógica, nuevo estilo
// ─────────────────────────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.theme,
    required this.actions,
    required this.actionDecisions,
    required this.status,
    required this.resultMessage,
    this.onApproveAction,
    this.onRejectAction,
    this.onApply,
    this.onDismiss,
  });

  final _AgentTheme theme;
  final List<GeminiActionProposal> actions;
  final List<_ChatActionDecision> actionDecisions;
  final _ChatActionStatus status;
  final String? resultMessage;
  final ValueChanged<int>? onApproveAction;
  final ValueChanged<int>? onRejectAction;
  final VoidCallback? onApply;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: theme.accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_fix_high_outlined,
                  size: 14, color: theme.accent),
              const SizedBox(width: 6),
              Text(
                'Cambios propuestos',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final e in actions.asMap().entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ActionRow(
                theme: theme,
                label: e.value.previewLabel,
                decision: e.key < actionDecisions.length
                    ? actionDecisions[e.key]
                    : _ChatActionDecision.undecided,
                enabled: status == _ChatActionStatus.pending,
                onApprove: onApproveAction == null
                    ? null
                    : () => onApproveAction!(e.key),
                onReject: onRejectAction == null
                    ? null
                    : () => onRejectAction!(e.key),
              ),
            ),
          if (resultMessage != null) ...[
            const SizedBox(height: 6),
            Text(resultMessage!,
                style: TextStyle(fontSize: 12, color: theme.muted)),
          ],
          if (status == _ChatActionStatus.pending ||
              status == _ChatActionStatus.applying) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: status == _ChatActionStatus.pending
                        ? onApply
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: theme.accent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        status == _ChatActionStatus.applying
                            ? 'Aplicando...'
                            : 'Aplicar',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.accentFg,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: status == _ChatActionStatus.pending
                      ? onDismiss
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 9, horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Ignorar',
                      style: TextStyle(
                          fontSize: 13, color: theme.muted),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.theme,
    required this.label,
    required this.decision,
    required this.enabled,
    this.onApprove,
    this.onReject,
  });

  final _AgentTheme theme;
  final String label;
  final _ChatActionDecision decision;
  final bool enabled;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.aiBubble,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 13, color: theme.text)),
          if (enabled) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                _DecisionBtn(
                  label: 'Aceptar',
                  selected: decision == _ChatActionDecision.approved,
                  accent: theme.accent,
                  accentFg: theme.accentFg,
                  muted: theme.muted,
                  onTap: onApprove,
                ),
                const SizedBox(width: 8),
                _DecisionBtn(
                  label: 'Omitir',
                  selected: decision == _ChatActionDecision.rejected,
                  accent: theme.muted,
                  accentFg: theme.bg,
                  muted: theme.muted,
                  onTap: onReject,
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 4),
            Text(
              switch (decision) {
                _ChatActionDecision.approved => 'Aprobado',
                _ChatActionDecision.rejected => 'Omitido',
                _ChatActionDecision.undecided => 'Sin decidir',
              },
              style: TextStyle(fontSize: 11, color: theme.muted),
            ),
          ],
        ],
      ),
    );
  }
}

class _DecisionBtn extends StatelessWidget {
  const _DecisionBtn({
    required this.label,
    required this.selected,
    required this.accent,
    required this.accentFg,
    required this.muted,
    this.onTap,
  });
  final String label;
  final bool selected;
  final Color accent;
  final Color accentFg;
  final Color muted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? accent : accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: selected ? accentFg : muted,
          ),
        ),
      ),
    );
  }
}

// Tipos internos privados
enum _ChatRole { user, assistant }

enum _ChatActionStatus {
  none,
  pending,
  applying,
  applied,
  failed,
  dismissed,
}

enum _ChatActionDecision { approved, rejected, undecided }

class _ChatMessage {
  _ChatMessage({
    this.id,
    required this.role,
    required this.text,
    this.actions = const [],
    this.actionDecisions = const [],
    this.actionStatus = _ChatActionStatus.none,
    this.actionResult,
  });

  final int? id;
  final _ChatRole role;
  final String text;
  final List<GeminiActionProposal> actions;
  final List<_ChatActionDecision> actionDecisions;
  final _ChatActionStatus actionStatus;
  final String? actionResult;

  bool get isReadyToApply =>
      actions.isNotEmpty && actionDecisions.length == actions.length;

  bool get hasUndecidedActions =>
      actionDecisions.any((d) => d == _ChatActionDecision.undecided);

  List<GeminiActionProposal> get approvedActions => [
        for (var i = 0; i < actions.length; i++)
          if (actionDecisions[i] == _ChatActionDecision.approved) actions[i],
      ];

  int get rejectedCount => actionDecisions
      .where((d) => d == _ChatActionDecision.rejected)
      .length;

  _ChatMessage copyWith({
    int? id,
    _ChatRole? role,
    String? text,
    List<GeminiActionProposal>? actions,
    List<_ChatActionDecision>? actionDecisions,
    _ChatActionStatus? actionStatus,
    String? actionResult,
  }) {
    return _ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      text: text ?? this.text,
      actions: actions ?? this.actions,
      actionDecisions: actionDecisions ?? this.actionDecisions,
      actionStatus: actionStatus ?? this.actionStatus,
      actionResult: actionResult ?? this.actionResult,
    );
  }

  static _ChatMessage fromRecord(chat_models.AiChatMessage record) {
    return _ChatMessage(
      id: record.id,
      role: record.role == chat_models.AiChatMessageRole.user
          ? _ChatRole.user
          : _ChatRole.assistant,
      text: record.text,
    );
  }
}
