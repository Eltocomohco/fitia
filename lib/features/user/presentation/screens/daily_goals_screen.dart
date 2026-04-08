import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/presentation/providers/daily_macros_provider.dart';

/// Pantalla para editar y guardar objetivos diarios de macros.
class DailyGoalsScreen extends ConsumerStatefulWidget {
  /// Crea un [DailyGoalsScreen].
  const DailyGoalsScreen({super.key});

  @override
  ConsumerState<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends ConsumerState<DailyGoalsScreen> {
  final _kcalCtrl = TextEditingController();
  final _pCtrl = TextEditingController();
  final _cCtrl = TextEditingController();
  final _gCtrl = TextEditingController();
  final _waterCtrl = TextEditingController();

  bool _initialized = false;

  @override
  void dispose() {
    _kcalCtrl.dispose();
    _pCtrl.dispose();
    _cCtrl.dispose();
    _gCtrl.dispose();
    _waterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final macrosAsync = ref.watch(dailyMacrosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Objetivos diarios')),
      body: macrosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Error al cargar objetivos')),
        data: (macros) {
          if (!_initialized) {
            _kcalCtrl.text = macros.kcalObjetivo.toStringAsFixed(0);
            _pCtrl.text = macros.proteinasObjetivo.toStringAsFixed(0);
            _cCtrl.text = macros.carbohidratosObjetivo.toStringAsFixed(0);
            _gCtrl.text = macros.grasasObjetivo.toStringAsFixed(0);
            _waterCtrl.text = macros.aguaObjetivoMl.toStringAsFixed(0);
            _initialized = true;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _kcalCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Kcal objetivo'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _pCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Proteínas objetivo (g)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Carbohidratos objetivo (g)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _gCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Grasas objetivo (g)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _waterCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Agua objetivo (ml)',
                ),
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar objetivos'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    final kcal = double.tryParse(_kcalCtrl.text.trim().replaceAll(',', '.'));
    final p = double.tryParse(_pCtrl.text.trim().replaceAll(',', '.'));
    final c = double.tryParse(_cCtrl.text.trim().replaceAll(',', '.'));
    final g = double.tryParse(_gCtrl.text.trim().replaceAll(',', '.'));
    final water = double.tryParse(_waterCtrl.text.trim().replaceAll(',', '.'));

    if (kcal == null || p == null || c == null || g == null || water == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revisa los valores del plan diario')),
      );
      return;
    }
    if (kcal <= 0 || p < 0 || c < 0 || g < 0 || water <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Kcal/agua deben ser mayores que 0 y los macros no negativos',
          ),
        ),
      );
      return;
    }

    await ref
        .read(dailyMacrosProvider.notifier)
        .updateGoals(
          kcalObjetivo: kcal,
          proteinasObjetivo: p,
          carbohidratosObjetivo: c,
          grasasObjetivo: g,
          aguaObjetivoMl: water,
        );

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Objetivos guardados')));
  }
}
