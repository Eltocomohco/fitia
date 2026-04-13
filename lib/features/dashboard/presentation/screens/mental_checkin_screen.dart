import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../data/models/checkin_animo.dart';
import '../providers/today_hub_provider.dart';

final recentMoodEntriesProvider = FutureProvider<List<CheckinAnimo>>((ref) async {
  final isar = ref.read(inventoryIsarProvider);
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, now.day)
      .subtract(const Duration(days: 6));
  final entries = await isar.checkinsAnimo.where().findAll();
  entries.removeWhere((entry) => entry.fecha.isBefore(start));
  entries.sort((a, b) => b.fecha.compareTo(a.fecha));
  return entries;
});

class MentalCheckinScreen extends ConsumerWidget {
  const MentalCheckinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayHubAsync = ref.watch(todayHubProvider);
    final recentAsync = ref.watch(recentMoodEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mente y energia')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          todayHubAsync.when(
            loading: () => const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Cargando check-in de hoy...'),
              ),
            ),
            error: (_, _) => const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No se pudo cargar el check-in de hoy.'),
              ),
            ),
            data: (snapshot) {
              final latest = snapshot.latestCheckIn;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Estado de hoy',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () => _showMoodCheckInDialog(
                              context,
                              ref,
                              latest,
                            ),
                            icon: const Icon(Icons.psychology_alt_outlined),
                            label: Text(
                              latest == null ? 'Registrar' : 'Actualizar',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (latest == null)
                        const Text('Sin registro hoy.')
                      else ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(
                              avatar: Icon(_moodIcon(latest.estado), size: 18),
                              label: Text(_moodLabel(latest.estado)),
                            ),
                            Chip(
                              avatar: const Icon(Icons.bolt_outlined, size: 18),
                              label: Text('Energia ${latest.energia}/5'),
                            ),
                          ],
                        ),
                        if ((latest.nota ?? '').isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(latest.nota!),
                        ],
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ultimos 7 dias',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  recentAsync.when(
                    loading: () => const Text('Cargando historial...'),
                    error: (_, _) => const Text('No se pudo cargar historial.'),
                    data: (entries) {
                      if (entries.isEmpty) {
                        return const Text('Aun no hay check-ins registrados.');
                      }
                      return Column(
                        children: entries
                            .map(
                              (entry) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(_moodIcon(entry.estado)),
                                title: Text(_moodLabel(entry.estado)),
                                subtitle: Text(
                                  '${_formatDate(entry.fecha)} · Energia ${entry.energia}/5',
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showMoodCheckInDialog(
  BuildContext context,
  WidgetRef ref,
  CheckinAnimo? current,
) async {
  var selectedMood = current?.estado ?? EstadoAnimo.estable;
  var energy = (current?.energia ?? 3).toDouble();
  final noteController = TextEditingController(text: current?.nota ?? '');

  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Check-in de hoy'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<EstadoAnimo>(
                    initialValue: selectedMood,
                    decoration: const InputDecoration(labelText: 'Como llegas'),
                    items: EstadoAnimo.values
                        .map(
                          (mood) => DropdownMenuItem<EstadoAnimo>(
                            value: mood,
                            child: Text(_moodLabel(mood)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedMood = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Energia ${energy.round()}/5'),
                  Slider(
                    value: energy,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '${energy.round()}',
                    onChanged: (value) {
                      setState(() {
                        energy = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Nota rapida',
                      hintText: 'Que te esta drenando o que te mantiene fino',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );

  if (shouldSave == true) {
    await ref.read(todayHubProvider.notifier).saveMood(
      estado: selectedMood,
      energia: energy.round(),
      note: noteController.text,
    );
    ref.invalidate(recentMoodEntriesProvider);
  }
  noteController.dispose();
}

String _moodLabel(EstadoAnimo mood) {
  return switch (mood) {
    EstadoAnimo.hundido => 'Hundido',
    EstadoAnimo.bajo => 'Bajo',
    EstadoAnimo.estable => 'Estable',
    EstadoAnimo.bien => 'Bien',
    EstadoAnimo.fuerte => 'Fuerte',
  };
}

IconData _moodIcon(EstadoAnimo mood) {
  return switch (mood) {
    EstadoAnimo.hundido => Icons.sentiment_very_dissatisfied_outlined,
    EstadoAnimo.bajo => Icons.sentiment_dissatisfied_outlined,
    EstadoAnimo.estable => Icons.sentiment_neutral_outlined,
    EstadoAnimo.bien => Icons.sentiment_satisfied_alt_outlined,
    EstadoAnimo.fuerte => Icons.sentiment_very_satisfied_outlined,
  };
}

String _formatDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final year = value.year;
  return '$day/$month/$year';
}
