import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hub principal del área de entrenamiento.
class TrainingHubScreen extends StatefulWidget {
  /// Crea una [TrainingHubScreen].
  const TrainingHubScreen({super.key});

  @override
  State<TrainingHubScreen> createState() => _TrainingHubScreenState();
}

class _TrainingHubScreenState extends State<TrainingHubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entreno'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Resumen'),
            Tab(text: 'Rutinas'),
            Tab(text: 'Historial'),
            Tab(text: 'Audio'),
          ],
        ),
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
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _TrainingSummaryTab(),
          _TrainingRoutinesTab(),
          _TrainingHistoryTab(),
          _TrainingAudioTab(),
        ],
      ),
    );
  }
}

class _TrainingSummaryTab extends StatelessWidget {
  const _TrainingSummaryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HubIntroCard(
          title: 'Rutinas, ejercicios y herramientas de entrenamiento',
          subtitle:
              'Desde aquí accedes al catálogo, el historial y el audio sin repartirlos en pestañas separadas.',
          icon: Icons.sports_gymnastics_outlined,
        ),
        SizedBox(height: 12),
        _SectionTitle(title: 'Operativa rápida'),
        SizedBox(height: 8),
        _PrimaryTrainingActions(),
        SizedBox(height: 16),
        _SectionTitle(title: 'Asistencia y revisión'),
        SizedBox(height: 8),
        _HubLinkCard(
          title: 'Hablar con Fiti sobre entreno',
          subtitle: 'Pregúntale por progresión, sesiones o dudas de ejercicios',
          icon: Icons.smart_toy_outlined,
          route: '/ai-chat?agent=workout',
        ),
        _HubLinkCard(
          title: 'Calendario',
          subtitle: 'Revisa qué entrenos tocan y dónde se te cae la adherencia',
          icon: Icons.calendar_month_outlined,
          route: '/calendar',
        ),
      ],
    );
  }
}

class _TrainingRoutinesTab extends StatelessWidget {
  const _TrainingRoutinesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SectionTitle(title: 'Rutinas y sesiones'),
        SizedBox(height: 8),
        _HubLinkCard(
          title: 'Rutinas',
          subtitle: 'Catálogo principal y acceso a sesiones',
          icon: Icons.fitness_center_outlined,
          route: '/workouts',
        ),
        _HubLinkCard(
          title: 'Nueva rutina',
          subtitle: 'Crea o edita una rutina personalizada',
          icon: Icons.add_task_outlined,
          route: '/workouts/new',
        ),
        _HubLinkCard(
          title: 'Entrenamiento activo',
          subtitle: 'Si ya tienes una sesión en marcha, retómala aquí',
          icon: Icons.play_circle_outline,
          route: '/workouts/active',
        ),
      ],
    );
  }
}

class _TrainingHistoryTab extends StatelessWidget {
  const _TrainingHistoryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SectionTitle(title: 'Revisión de progreso'),
        SizedBox(height: 8),
        _HubLinkCard(
          title: 'Historial',
          subtitle: 'Sesiones completadas y seguimiento del entreno',
          icon: Icons.history_outlined,
          route: '/workouts/history',
        ),
        _HubLinkCard(
          title: 'Tracking corporal',
          subtitle: 'Peso, métricas y progreso físico relacionado con el entreno',
          icon: Icons.monitor_weight_outlined,
          route: '/body-tracking',
        ),
        _HubLinkCard(
          title: 'Informes',
          subtitle: 'Resumen diario, semanal y mensual del uso de la app',
          icon: Icons.insights_outlined,
          route: '/reports',
        ),
      ],
    );
  }
}

class _TrainingAudioTab extends StatelessWidget {
  const _TrainingAudioTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SectionTitle(title: 'Audio y ambiente'),
        SizedBox(height: 8),
        _HubLinkCard(
          title: 'Audio',
          subtitle: 'Playlists y soporte para entrenar con música',
          icon: Icons.library_music_outlined,
          route: '/player',
        ),
        _HubLinkCard(
          title: 'Notificaciones',
          subtitle: 'Configura recordatorios para entrenar y mantener consistencia',
          icon: Icons.notifications_active_outlined,
          route: '/notification-settings',
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _PrimaryTrainingActions extends StatelessWidget {
  const _PrimaryTrainingActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TrainingActionPanel(
            title: 'Entrenar',
            subtitle: 'Abrir rutinas',
            icon: Icons.play_arrow_rounded,
            onTap: () => context.push('/workouts'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TrainingActionPanel(
            title: 'Historial',
            subtitle: 'Últimas sesiones',
            icon: Icons.history_outlined,
            onTap: () => context.push('/workouts/history'),
          ),
        ),
      ],
    );
  }
}

class _TrainingActionPanel extends StatelessWidget {
  const _TrainingActionPanel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _HubIntroCard extends StatelessWidget {
  const _HubIntroCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HubLinkCard extends StatelessWidget {
  const _HubLinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }
}