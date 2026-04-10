import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/fasting_provider.dart';

/// Widget visual del estado del ayuno intermitente para la cabecera del dashboard.
class FastingWidget extends ConsumerWidget {
  /// Crea un [FastingWidget].
  const FastingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fastingAsync = ref.watch(fastingProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: fastingAsync.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const Text('No se pudo cargar el ayuno'),
          data: (fasting) {
            final theme = Theme.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ayuno intermitente', style: theme.textTheme.titleMedium),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 92,
                      height: 92,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: fasting.progress,
                            strokeWidth: 10,
                          ),
                          Center(
                            child: Text(
                              '${(fasting.progress * 100).round()}%',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fasting.sesion.activa
                                ? fasting.isCompleted
                                      ? 'Objetivo alcanzado'
                                      : 'Tiempo restante: ${_formatDuration(fasting.remaining)}'
                                : 'No hay ayuno activo',
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            fasting.sesion.activa
                                ? 'Iniciado: ${_formatDateTime(fasting.sesion.fechaInicio)} · Meta ${fasting.sesion.horasObjetivo}h'
                                : 'Selecciona una duración y empieza tu sesión.',
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: fasting.sesion.activa
                                ? [
                                    FilledButton.tonalIcon(
                                      onPressed: () => ref
                                          .read(fastingProvider.notifier)
                                          .stopFasting(),
                                      icon: const Icon(Icons.stop_circle_outlined),
                                      label: const Text('Finalizar'),
                                    ),
                                  ]
                                : [12, 16, 18].map((hours) {
                                    return OutlinedButton(
                                      onPressed: () => ref
                                          .read(fastingProvider.notifier)
                                          .startFasting(hours),
                                      child: Text('${hours}h'),
                                    );
                                  }).toList(growable: false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  return '$hours:$minutes';
}

String _formatDateTime(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$day/$month · $hour:$minute';
}