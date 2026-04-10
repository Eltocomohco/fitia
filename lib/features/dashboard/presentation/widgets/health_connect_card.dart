import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../tracking/domain/services/android_health_connect_models.dart';
import '../providers/health_connect_provider.dart';

class HealthConnectCard extends ConsumerWidget {
  const HealthConnectCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(healthConnectProvider);

    return Card(
      color: AppTheme.primary.withValues(alpha: 0.14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: healthAsync.when(
          loading: () => const _HealthConnectLoadingState(),
          error: (_, _) => _HealthConnectContent(
            status: HealthConnectCardStatus.error,
            message: 'No se pudo cargar el estado de Health Connect.',
            onPrimaryAction: () {
              ref.read(healthConnectProvider.notifier).refresh();
            },
            primaryLabel: 'Reintentar',
          ),
          data: (state) => _HealthConnectContent(
            status: state.status,
            message: state.message,
            metrics: _HealthMetricsAdapter(state.metrics),
            onPrimaryAction: switch (state.status) {
              HealthConnectCardStatus.installRequired => () {
                ref.read(healthConnectProvider.notifier).openInstallPage();
              },
              HealthConnectCardStatus.permissionsRequired => () {
                ref.read(healthConnectProvider.notifier).requestAccess();
              },
              HealthConnectCardStatus.ready => () {
                ref.read(healthConnectProvider.notifier).refresh();
              },
              HealthConnectCardStatus.error => () {
                ref.read(healthConnectProvider.notifier).refresh();
              },
              HealthConnectCardStatus.unsupported => null,
            },
            primaryLabel: switch (state.status) {
              HealthConnectCardStatus.installRequired => 'Instalar',
              HealthConnectCardStatus.permissionsRequired => 'Conectar',
              HealthConnectCardStatus.ready => 'Actualizar',
              HealthConnectCardStatus.error => 'Reintentar',
              HealthConnectCardStatus.unsupported => null,
            },
          ),
        ),
      ),
    );
  }
}

class _HealthConnectContent extends StatelessWidget {
  const _HealthConnectContent({
    required this.status,
    this.message,
    this.metrics = const _EmptyMetricsAdapter(),
    this.onPrimaryAction,
    this.primaryLabel,
  });

  final HealthConnectCardStatus status;
  final String? message;
  final _MetricsView metrics;
  final VoidCallback? onPrimaryAction;
  final String? primaryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isReady = status == HealthConnectCardStatus.ready;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.favorite_outline),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Health Connect',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _StatusBadge(status: status),
          ],
        ),
        const SizedBox(height: 14),
        if (isReady) ...[
          _MetricsGrid(metrics: metrics),
          const SizedBox(height: 14),
          Row(
            children: [
              if (onPrimaryAction != null && primaryLabel != null)
                FilledButton.tonalIcon(
                  onPressed: onPrimaryAction,
                  icon: Icon(_actionIcon(status)),
                  label: Text(primaryLabel!),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  metrics.syncedAtLabel == null
                      ? 'Sin actualización reciente'
                      : 'Última actualización ${metrics.syncedAtLabel}',
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ] else ...[
          Text(
            message ??
                'Importa pasos, calorías, sueño y frecuencia cardiaca desde tu ecosistema Android.',
            style: theme.textTheme.bodyMedium,
          ),
          if (onPrimaryAction != null && primaryLabel != null) ...[
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.tonalIcon(
                onPressed: onPrimaryAction,
                icon: Icon(_actionIcon(status)),
                label: Text(primaryLabel!),
              ),
            ),
          ],
        ],
      ],
    );
  }

  static IconData _actionIcon(HealthConnectCardStatus status) {
    return switch (status) {
      HealthConnectCardStatus.installRequired => Icons.download_outlined,
      HealthConnectCardStatus.permissionsRequired =>
        Icons.link_outlined,
      HealthConnectCardStatus.ready => Icons.sync,
      HealthConnectCardStatus.error => Icons.refresh,
      HealthConnectCardStatus.unsupported => Icons.block,
    };
  }
}

class _HealthConnectLoadingState extends StatelessWidget {
  const _HealthConnectLoadingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.4),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text('Comprobando Health Connect y permisos...'),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.metrics});

  final _MetricsView metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.55,
      children: [
        _MetricChip(
          label: 'Pasos',
          value: metrics.stepsLabel,
          icon: Icons.directions_walk_outlined,
        ),
        _MetricChip(
          label: 'Kcal',
          value: metrics.caloriesLabel,
          icon: Icons.local_fire_department_outlined,
        ),
        _MetricChip(
          label: 'Sueño',
          value: metrics.sleepLabel,
          icon: Icons.bedtime_outlined,
        ),
        _MetricChip(
          label: 'FC',
          value: metrics.heartRateLabel,
          icon: Icons.monitor_heart_outlined,
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 8),
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final HealthConnectCardStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      HealthConnectCardStatus.ready => ('Listo', Colors.green),
      HealthConnectCardStatus.permissionsRequired =>
        ('Permisos', AppTheme.primary),
      HealthConnectCardStatus.installRequired => ('Instalar', AppTheme.error),
      HealthConnectCardStatus.error => ('Error', AppTheme.error),
      HealthConnectCardStatus.unsupported => ('No disponible', Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

abstract class _MetricsView {
  int get steps;

  int get caloriesBurned;

  Duration get sleepDuration;

  int? get latestHeartRate;

  DateTime? get syncedAt;

  bool get hasAnyData;

  String get stepsLabel;

  String get caloriesLabel;

  String get sleepLabel;

  String get heartRateLabel;

  String? get syncedAtLabel;
}

class _EmptyMetricsAdapter implements _MetricsView {
  const _EmptyMetricsAdapter();

  @override
  int get caloriesBurned => 0;

  @override
  bool get hasAnyData => false;

  @override
  int? get latestHeartRate => null;

  @override
  Duration get sleepDuration => Duration.zero;

  @override
  int get steps => 0;

  @override
  DateTime? get syncedAt => null;

  @override
  String get caloriesLabel => '0';

  @override
  String get heartRateLabel => '--';

  @override
  String get sleepLabel => '0m';

  @override
  String get stepsLabel => '0';

  @override
  String? get syncedAtLabel => null;
}

class _HealthMetricsAdapter implements _MetricsView {
  const _HealthMetricsAdapter(this.metrics);

  final AndroidHealthMetrics metrics;

  @override
  int get caloriesBurned => metrics.caloriesBurned;

  @override
  bool get hasAnyData => metrics.hasAnyData;

  @override
  int? get latestHeartRate => metrics.latestHeartRate;

  @override
  Duration get sleepDuration => metrics.sleepDuration;

  @override
  int get steps => metrics.steps;

  @override
  DateTime? get syncedAt => metrics.syncedAt;

  @override
  String get caloriesLabel => metrics.caloriesBurned.toString();

  @override
  String get heartRateLabel =>
      metrics.latestHeartRate == null ? '--' : '${metrics.latestHeartRate} bpm';

  @override
  String get sleepLabel {
    final totalMinutes = metrics.sleepDuration.inMinutes;
    if (totalMinutes <= 0) {
      return '0m';
    }

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours <= 0) {
      return '${minutes}m';
    }

    return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  @override
  String get stepsLabel => metrics.steps.toString();

  @override
  String? get syncedAtLabel {
    final syncedAt = metrics.syncedAt;
    if (syncedAt == null) {
      return null;
    }

    final hours = syncedAt.hour.toString().padLeft(2, '0');
    final minutes = syncedAt.minute.toString().padLeft(2, '0');
    return 'a las $hours:$minutes';
  }
}