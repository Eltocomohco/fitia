import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/isar_config.dart';
import '../../../../core/services/gemini_action_executor.dart';
import '../../../../core/services/gemini_companion_service.dart';
import '../../data/models/ai_chat_agent.dart';
import '../../data/models/ai_chat_message.dart' as chat_models;
import '../../data/services/ai_chat_local_store.dart';
import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../recipes/presentation/providers/recipe_provider.dart';
import '../../../shopping/presentation/providers/shopping_provider.dart';
import '../../../workouts/presentation/providers/workout_catalog_provider.dart';

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
    final agentTheme = _agentTheme(_selectedAgent);
    return Scaffold(
      backgroundColor: agentTheme.pageBackgroundColor,
      appBar: AppBar(
        backgroundColor: agentTheme.chromeColor,
        foregroundColor: agentTheme.foregroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(_selectedAgent.displayName),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Perfil y ajustes',
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
          IconButton(
            tooltip: 'Nueva conversación',
            onPressed: _isLoading || _isBootstrapping
                ? null
                : _startNewConversation,
            icon: const Icon(Icons.add_comment_outlined),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        color: agentTheme.pageBackgroundColor,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: agentTheme.primaryTextColor,
          ),
          child: IconTheme(
            data: IconThemeData(color: agentTheme.primaryTextColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: _AgentSelector(
                    selectedAgent: _selectedAgent,
                    isBusy: _isLoading || _isBootstrapping,
                    onSelected: _selectAgent,
                  ),
                ),
                Expanded(
                  child: _isBootstrapping
                      ? Center(
                          child: CircularProgressIndicator(
                            color: agentTheme.accentColor,
                          ),
                        )
                      : _messages.isEmpty
                      ? _ChatEmptyState(selectedAgent: _selectedAgent)
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          itemCount: _messages.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_isLoading && index == _messages.length) {
                              return _TypingBubble(theme: agentTheme);
                            }

                            final message = _messages[index];
                            final isUser = message.role == _ChatRole.user;
                            return Align(
                              alignment: isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 560),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? agentTheme.userBubbleColor
                                        : agentTheme.bubbleColor,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: isUser
                                          ? agentTheme.userBubbleBorderColor
                                          : agentTheme.borderColor,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      isUser
                                          ? Text(
                                              message.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: agentTheme
                                                        .userBubbleTextColor,
                                                  ),
                                            )
                                          : MarkdownBody(
                                              data: message.text,
                                              selectable: true,
                                              styleSheet:
                                                  MarkdownStyleSheet.fromTheme(
                                                Theme.of(context),
                                              ).copyWith(
                                                p: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                    ),
                                                h1: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                    ),
                                                h2: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                    ),
                                                h3: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                    ),
                                                listBullet: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                    ),
                                                strong: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: agentTheme
                                                          .primaryTextColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                      if (message.actions.isNotEmpty) ...[
                                        const SizedBox(height: 12),
                                        _ActionPreviewCard(
                                          theme: agentTheme,
                                          actions: message.actions,
                                          actionDecisions:
                                            message.actionDecisions,
                                          status: message.actionStatus,
                                          resultMessage: message.actionResult,
                                          onApproveAction: message.actionStatus ==
                                              _ChatActionStatus.pending
                                            ? (actionIndex) =>
                                              _setActionDecision(
                                              index,
                                              actionIndex,
                                              _ChatActionDecision.approved,
                                              )
                                            : null,
                                          onRejectAction: message.actionStatus ==
                                              _ChatActionStatus.pending
                                            ? (actionIndex) =>
                                              _setActionDecision(
                                              index,
                                              actionIndex,
                                              _ChatActionDecision.rejected,
                                              )
                                            : null,
                                          onApply: message.actionStatus ==
                                                _ChatActionStatus.pending &&
                                              message.isReadyToApply
                                              ? () => _applyActions(index)
                                              : null,
                                          onDismiss: message.actionStatus ==
                                                  _ChatActionStatus.pending
                                              ? () => _dismissActions(index)
                                              : null,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            style: TextStyle(color: agentTheme.primaryTextColor),
                            cursorColor: agentTheme.accentColor,
                            minLines: 1,
                            maxLines: 4,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _handleSend(),
                            decoration: InputDecoration(
                              hintText: _selectedAgent.composerHint,
                              hintStyle: TextStyle(color: agentTheme.mutedColor),
                              filled: true,
                              fillColor: agentTheme.inputBackgroundColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: agentTheme.borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: agentTheme.accentColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          onPressed: _isLoading ? null : _handleSend,
                          style: FilledButton.styleFrom(
                            backgroundColor: agentTheme.accentColor,
                            foregroundColor: agentTheme.onAccentColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                          ),
                          icon: _isLoading
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: agentTheme.onAccentColor,
                                  ),
                                )
                              : const Icon(Icons.send_outlined),
                          label: const Text('Enviar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

class _TypingBubble extends StatelessWidget {
  const _TypingBubble({required this.theme});

  final _AgentThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.bubbleColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.borderColor),
        ),
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.accentColor,
          ),
        ),
      ),
    );
  }
}

class _AgentThemeData {
  const _AgentThemeData({
    required this.accentColor,
    required this.foregroundColor,
    required this.onAccentColor,
    required this.chromeColor,
    required this.pageBackgroundColor,
    required this.primaryTextColor,
    required this.mutedColor,
    required this.inputBackgroundColor,
    required this.bubbleColor,
    required this.borderColor,
    required this.userBubbleColor,
    required this.userBubbleBorderColor,
    required this.userBubbleTextColor,
  });

  final Color accentColor;
  final Color foregroundColor;
  final Color onAccentColor;
  final Color chromeColor;
  final Color pageBackgroundColor;
  final Color primaryTextColor;
  final Color mutedColor;
  final Color inputBackgroundColor;
  final Color bubbleColor;
  final Color borderColor;
  final Color userBubbleColor;
  final Color userBubbleBorderColor;
  final Color userBubbleTextColor;
}

_AgentThemeData _agentTheme(AiChatAgent agent) {
  return switch (agent) {
    AiChatAgent.nutrition => const _AgentThemeData(
      accentColor: Color(0xFF7C4DFF),
      foregroundColor: Colors.white,
      onAccentColor: Colors.white,
      chromeColor: Color(0xFF6D3EF0),
      pageBackgroundColor: Color(0xFFF6F1FF),
      primaryTextColor: Color(0xFF22143D),
      mutedColor: Color(0xFF6A5B88),
      inputBackgroundColor: Colors.white,
      bubbleColor: Color(0xFFEFE6FF),
      borderColor: Color(0xFFD5C4FF),
      userBubbleColor: Color(0xFF7C4DFF),
      userBubbleBorderColor: Color(0xFF7C4DFF),
      userBubbleTextColor: Colors.white,
    ),
    AiChatAgent.workout => const _AgentThemeData(
      accentColor: Color(0xFFFFFFFF),
      foregroundColor: Colors.white,
      onAccentColor: Color(0xFF090909),
      chromeColor: Color(0xFF050505),
      pageBackgroundColor: Color(0xFF050505),
      primaryTextColor: Color(0xFFF5F7FA),
      mutedColor: Color(0xFF9BA3AE),
      inputBackgroundColor: Color(0xFF101114),
      bubbleColor: Color(0xFF121317),
      borderColor: Color(0xFF2C3036),
      userBubbleColor: Color(0xFFF5F7FA),
      userBubbleBorderColor: Color(0xFFDCE1E8),
      userBubbleTextColor: Color(0xFF090909),
    ),
    AiChatAgent.boss => const _AgentThemeData(
      accentColor: Color(0xFFC79400),
      foregroundColor: Color(0xFF211A00),
      onAccentColor: Color(0xFF211A00),
      chromeColor: Color(0xFFE0B33A),
      pageBackgroundColor: Color(0xFFFFF7E3),
      primaryTextColor: Color(0xFF2B2105),
      mutedColor: Color(0xFF7D6A31),
      inputBackgroundColor: Color(0xFFFFFDF7),
      bubbleColor: Color(0xFFFFF0C3),
      borderColor: Color(0xFFE8CF7A),
      userBubbleColor: Color(0xFFC79400),
      userBubbleBorderColor: Color(0xFFC79400),
      userBubbleTextColor: Color(0xFF211A00),
    ),
  };
}

class _AgentSelector extends StatelessWidget {
  const _AgentSelector({
    required this.selectedAgent,
    required this.isBusy,
    required this.onSelected,
  });

  final AiChatAgent selectedAgent;
  final bool isBusy;
  final ValueChanged<AiChatAgent> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final agent in AiChatAgent.values) ...[
                  _AgentQuickSwitch(
                    agent: agent,
                    selected: agent == selectedAgent,
                    enabled: !isBusy,
                    onTap: () => onSelected(agent),
                  ),
                  if (agent != AiChatAgent.values.last) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatEmptyState extends StatelessWidget {
  const _ChatEmptyState({required this.selectedAgent});

  final AiChatAgent selectedAgent;

  @override
  Widget build(BuildContext context) {
    final theme = _agentTheme(selectedAgent);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          selectedAgent.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: theme.primaryTextColor,
          ),
        ),
      ),
    );
  }
}

IconData _selectorIconForAgent(AiChatAgent agent) {
  return switch (agent) {
    AiChatAgent.nutrition => Icons.restaurant_menu_outlined,
    AiChatAgent.workout => Icons.fitness_center_outlined,
    AiChatAgent.boss => Icons.visibility_outlined,
  };
}

String _agentInitial(AiChatAgent agent) {
  return switch (agent) {
    AiChatAgent.nutrition => 'Nutricion',
    AiChatAgent.workout => 'Gym',
    AiChatAgent.boss => 'Boss',
  };
}

class _AgentQuickSwitch extends StatelessWidget {
  const _AgentQuickSwitch({
    required this.agent,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final AiChatAgent agent;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = _agentTheme(agent);
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? theme.accentColor : theme.bubbleColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? theme.accentColor : theme.borderColor,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _selectorIconForAgent(agent),
              size: 16,
              color: selected ? theme.foregroundColor : theme.accentColor,
            ),
            const SizedBox(width: 6),
            Text(
              _agentInitial(agent),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: selected
                    ? theme.onAccentColor
                    : theme.primaryTextColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    this.id,
    required this.role,
    required this.text,
    this.actions = const <GeminiActionProposal>[],
    this.actionDecisions = const <_ChatActionDecision>[],
    this.actionStatus = _ChatActionStatus.none,
    this.actionResult,
  });

  factory _ChatMessage.fromRecord(chat_models.AiChatMessage record) {
    final decodedActions = AiChatLocalStore.decodeActionsJson(record.actionsJson);
    return _ChatMessage(
      id: record.id,
      role: record.role == chat_models.AiChatMessageRole.user
          ? _ChatRole.user
          : _ChatRole.assistant,
      text: record.text,
      actions: decodedActions
          .map(GeminiActionProposal.fromJson)
          .whereType<GeminiActionProposal>()
          .toList(growable: false),
      actionDecisions: List<_ChatActionDecision>.filled(
        decodedActions.length,
        _ChatActionDecision.undecided,
      ),
      actionStatus: _chatActionStatusFromPersistence(record.actionStatus),
      actionResult: record.actionResult,
    );
  }

  final int? id;

  final _ChatRole role;
  final String text;
  final List<GeminiActionProposal> actions;
  final List<_ChatActionDecision> actionDecisions;
  final _ChatActionStatus actionStatus;
  final String? actionResult;

  bool get hasUndecidedActions =>
      actionDecisions.any((decision) => decision == _ChatActionDecision.undecided);

  bool get isReadyToApply =>
      actions.isNotEmpty && !hasUndecidedActions && approvedActions.isNotEmpty;

  List<GeminiActionProposal> get approvedActions {
    final approved = <GeminiActionProposal>[];
    for (var index = 0; index < actions.length; index++) {
      final decision = index < actionDecisions.length
          ? actionDecisions[index]
          : _ChatActionDecision.undecided;
      if (decision == _ChatActionDecision.approved) {
        approved.add(actions[index]);
      }
    }
    return approved;
  }

  int get rejectedCount => actionDecisions
      .where((decision) => decision == _ChatActionDecision.rejected)
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
}

enum _ChatRole { user, assistant }

enum _ChatActionDecision { undecided, approved, rejected }

enum _ChatActionStatus { none, pending, applying, applied, dismissed, failed }

_ChatActionStatus _chatActionStatusFromPersistence(
  chat_models.AiChatMessageActionStatus status,
) {
  return switch (status) {
    chat_models.AiChatMessageActionStatus.pending => _ChatActionStatus.pending,
    chat_models.AiChatMessageActionStatus.applying => _ChatActionStatus.applying,
    chat_models.AiChatMessageActionStatus.applied => _ChatActionStatus.applied,
    chat_models.AiChatMessageActionStatus.dismissed => _ChatActionStatus.dismissed,
    chat_models.AiChatMessageActionStatus.failed => _ChatActionStatus.failed,
    chat_models.AiChatMessageActionStatus.none => _ChatActionStatus.none,
  };
}

class _ActionPreviewCard extends StatelessWidget {
  const _ActionPreviewCard({
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

  final _AgentThemeData theme;
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.inputBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cambios propuestos',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: theme.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            for (final entry in actions.asMap().entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _ActionDecisionRow(
                  theme: theme,
                  label: entry.value.previewLabel,
                  decision: entry.key < actionDecisions.length
                      ? actionDecisions[entry.key]
                      : _ChatActionDecision.undecided,
                  enabled: status == _ChatActionStatus.pending,
                  onApprove: onApproveAction == null
                      ? null
                      : () => onApproveAction!(entry.key),
                  onReject: onRejectAction == null
                      ? null
                      : () => onRejectAction!(entry.key),
                ),
              ),
            if (resultMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                resultMessage!,
                style: TextStyle(color: theme.primaryTextColor),
              ),
            ],
            if (status == _ChatActionStatus.pending ||
                status == _ChatActionStatus.applying) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  FilledButton(
                    onPressed: status == _ChatActionStatus.pending
                        ? onApply
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.accentColor,
                      foregroundColor: theme.onAccentColor,
                    ),
                    child: Text(
                      status == _ChatActionStatus.applying
                          ? 'Aplicando...'
                          : 'Aplicar aprobados',
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: status == _ChatActionStatus.pending
                        ? onDismiss
                        : null,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryTextColor,
                    ),
                    child: const Text('Ignorar'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionDecisionRow extends StatelessWidget {
  const _ActionDecisionRow({
    required this.theme,
    required this.label,
    required this.decision,
    required this.enabled,
    this.onApprove,
    this.onReject,
  });

  final _AgentThemeData theme;
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
        color: theme.pageBackgroundColor.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: theme.primaryTextColor),
          ),
          if (enabled) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton.tonal(
                  onPressed: onApprove,
                  style: FilledButton.styleFrom(
                    backgroundColor: decision == _ChatActionDecision.approved
                        ? theme.accentColor
                        : theme.inputBackgroundColor,
                    foregroundColor: decision == _ChatActionDecision.approved
                        ? theme.onAccentColor
                        : theme.primaryTextColor,
                  ),
                  child: const Text('Aceptar'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: decision == _ChatActionDecision.rejected
                          ? theme.accentColor
                          : theme.borderColor,
                    ),
                    foregroundColor: theme.primaryTextColor,
                  ),
                  child: const Text('Omitir'),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 6),
            Text(
              switch (decision) {
                _ChatActionDecision.approved => 'Aprobado',
                _ChatActionDecision.rejected => 'Omitido',
                _ChatActionDecision.undecided => 'Sin decidir',
              },
              style: TextStyle(color: theme.mutedColor),
            ),
          ],
        ],
      ),
    );
  }
}
