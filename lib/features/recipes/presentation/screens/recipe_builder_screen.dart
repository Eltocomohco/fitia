import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/ingrediente_receta.dart';
import '../providers/recipe_provider.dart';

/// Pantalla de construcción interactiva de recetas.
class RecipeBuilderScreen extends ConsumerStatefulWidget {
  /// Crea un [RecipeBuilderScreen].
  const RecipeBuilderScreen({super.key});

  @override
  ConsumerState<RecipeBuilderScreen> createState() =>
      _RecipeBuilderScreenState();
}

class _RecipeBuilderScreenState extends ConsumerState<RecipeBuilderScreen> {
  late final TextEditingController _nombreController;
  late final TextEditingController _racionesController;
  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
    final initial = ref.read(recipeBuilderProvider);
    _nombreController = TextEditingController(text: initial.nombre);
    _racionesController = TextEditingController(text: '${initial.raciones}');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _racionesController.dispose();
    super.dispose();
  }

  Future<void> _openAddIngredientSheet(GrupoComponenteReceta group) async {
    final selected = await showModalBottomSheet<_SelectedIngredientResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AddIngredientSheet(group: group),
    );

    if (selected == null) {
      return;
    }

    ref
        .read(recipeBuilderProvider.notifier)
        .addIngrediente(
          alimento: selected.alimento,
          gramos: selected.gramos,
          grupo: group,
        );
  }

  GrupoComponenteReceta get _currentStepGroup {
    return switch (_stepIndex) {
      0 => GrupoComponenteReceta.principal,
      1 => GrupoComponenteReceta.vegetal,
      _ => GrupoComponenteReceta.anadido,
    };
  }

  void _nextStep() {
    if (_stepIndex >= 2) {
      return;
    }
    setState(() => _stepIndex++);
  }

  void _prevStep() {
    if (_stepIndex <= 0) {
      return;
    }
    setState(() => _stepIndex--);
  }

  Future<void> _saveRecipe() async {
    try {
      await ref.read(recipeBuilderProvider.notifier).saveRecipe();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receta guardada correctamente')),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No fue posible guardar la receta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeBuilderProvider);
    final totals = _calculateRecipeTotals(state);
    final isEditing = state.editingRecipeId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar receta' : 'Constructor de Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la receta',
              ),
              onChanged: ref.read(recipeBuilderProvider.notifier).updateNombre,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _racionesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Raciones'),
              onChanged: (value) {
                final parsed = int.tryParse(value) ?? 1;
                ref.read(recipeBuilderProvider.notifier).updateRaciones(parsed);
              },
            ),
            const SizedBox(height: 14),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sumatorio de la receta',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kcal ${totals.kcal.toStringAsFixed(0)} · '
                      'P ${totals.proteinas.toStringAsFixed(1)}g · '
                      'C ${totals.carbohidratos.toStringAsFixed(1)}g · '
                      'G ${totals.grasas.toStringAsFixed(1)}g',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Peso total ${totals.gramos.toStringAsFixed(0)} g · '
                      'Por ración (${state.raciones}): '
                      '${(totals.kcal / (state.raciones <= 0 ? 1 : state.raciones)).toStringAsFixed(0)} kcal',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ingredientes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: state.ingredientes.isEmpty
                  ? const Center(
                      child: Text('Añade ingredientes para comenzar'),
                    )
                  : _GroupedIngredientsList(state: state),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Paso ${_stepIndex + 1}/3 · ${_currentStepGroup.label}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () =>
                          _openAddIngredientSheet(_currentStepGroup),
                      icon: const Icon(Icons.add),
                      label: Text('Añadir ${_currentStepGroup.label}'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _stepIndex == 0 ? null : _prevStep,
                            child: const Text('Anterior'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: _stepIndex == 2 ? null : _nextStep,
                            child: const Text('Siguiente'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _saveRecipe,
            icon: const Icon(Icons.save_outlined),
            label: Text(isEditing ? 'Guardar cambios' : 'Guardar Receta'),
          ),
        ),
      ),
    );
  }
}

class _GroupedIngredientsList extends ConsumerWidget {
  const _GroupedIngredientsList({required this.state});

  final RecipeBuilderState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final byGroup =
        <GrupoComponenteReceta, List<(int, RecipeBuilderIngredient)>>{
          for (final group in GrupoComponenteReceta.values) group: [],
        };

    for (var index = 0; index < state.ingredientes.length; index++) {
      final item = state.ingredientes[index];
      byGroup[item.grupo]!.add((index, item));
    }

    return ListView(
      children: [
        for (final group in GrupoComponenteReceta.values)
          if (byGroup[group]!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 2, 6),
              child: Text(
                group.label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            for (final entry in byGroup[group]!)
              Card(
                child: ListTile(
                  title: Text(entry.$2.alimento.nombre),
                  subtitle: Text(
                    '${entry.$2.cantidadGramos.toStringAsFixed(1)} g',
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      ref
                          .read(recipeBuilderProvider.notifier)
                          .removeIngredienteAt(entry.$1);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                  onTap: () async {
                    final grams = await _askIngredientGrams(
                      context,
                      initial: entry.$2.cantidadGramos,
                    );
                    if (grams == null) {
                      return;
                    }
                    ref
                        .read(recipeBuilderProvider.notifier)
                        .updateIngredienteGramosAt(entry.$1, grams);
                  },
                ),
              ),
          ],
      ],
    );
  }
}

class _AddIngredientSheet extends ConsumerStatefulWidget {
  const _AddIngredientSheet({required this.group});

  final GrupoComponenteReceta group;

  @override
  ConsumerState<_AddIngredientSheet> createState() =>
      _AddIngredientSheetState();
}

class _AddIngredientSheetState extends ConsumerState<_AddIngredientSheet> {
  final _searchController = TextEditingController();
  final _gramsController = TextEditingController();
  int? _selectedFoodId;

  @override
  void dispose() {
    _searchController.dispose();
    _gramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(inventoryProvider);
    final query = _searchController.text.trim().toLowerCase();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(context).size.height * 0.75 -
                MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar alimento',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _gramsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Gramos'),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Seleccionando: ${widget.group.label}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: inventoryAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) =>
                      const Center(child: Text('Error al cargar alimentos')),
                  data: (foods) {
                    final expected = switch (widget.group) {
                      GrupoComponenteReceta.principal => 'principal',
                      GrupoComponenteReceta.vegetal => 'vegetal',
                      GrupoComponenteReceta.anadido => 'anadido',
                    };

                    final filtered = foods
                        .where(
                          (food) => food.nombre.toLowerCase().contains(query),
                        )
                        .toList();

                    filtered.sort((a, b) {
                      final aScore = _foodMatchesStep(a.grupos, expected)
                          ? 0
                          : 1;
                      final bScore = _foodMatchesStep(b.grupos, expected)
                          ? 0
                          : 1;
                      if (aScore != bScore) {
                        return aScore.compareTo(bScore);
                      }
                      return a.nombre.toLowerCase().compareTo(
                        b.nombre.toLowerCase(),
                      );
                    });

                    if (filtered.isEmpty) {
                      return const Center(child: Text('Sin resultados'));
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final food = filtered[index];
                        final isSelected = _selectedFoodId == food.id;
                        final isRecommended = _foodMatchesStep(
                          food.grupos,
                          expected,
                        );
                        return Card(
                          child: ListTile(
                            title: Text(food.nombre),
                            subtitle: Text(
                              'Base ${food.porcionBaseGramos.toStringAsFixed(0)} g · '
                              'Kcal ${food.kcal.toStringAsFixed(0)} · '
                              'P ${food.proteinas.toStringAsFixed(1)}g · '
                              'C ${food.carbohidratos.toStringAsFixed(1)}g · '
                              'G ${food.grasas.toStringAsFixed(1)}g'
                              '${isRecommended ? ' · Recomendado' : ''}',
                            ),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle)
                                : const Icon(Icons.circle_outlined),
                            onTap: () => setState(() {
                              _selectedFoodId = food.id;
                              _gramsController.text = food.porcionBaseGramos
                                  .toStringAsFixed(0);
                            }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final grams = double.tryParse(
                      _gramsController.text.trim().replaceAll(',', '.'),
                    );

                    if (_selectedFoodId == null ||
                        grams == null ||
                        grams <= 0) {
                      return;
                    }

                    final items = ref.read(inventoryProvider).value ?? [];
                    Alimento? selected;
                    for (final food in items) {
                      if (food.id == _selectedFoodId) {
                        selected = food;
                        break;
                      }
                    }
                    if (selected == null) {
                      return;
                    }

                    Navigator.of(context).pop(
                      _SelectedIngredientResult(
                        alimento: selected,
                        gramos: grams,
                      ),
                    );
                  },
                  child: const Text('Añadir ingrediente'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedIngredientResult {
  const _SelectedIngredientResult({
    required this.alimento,
    required this.gramos,
  });

  final Alimento alimento;
  final double gramos;
}

_RecipeDraftTotals _calculateRecipeTotals(RecipeBuilderState state) {
  var kcal = 0.0;
  var proteinas = 0.0;
  var carbohidratos = 0.0;
  var grasas = 0.0;
  var gramos = 0.0;

  for (final item in state.ingredientes) {
    final base = item.alimento.porcionBaseGramos;
    if (base <= 0) {
      continue;
    }
    final factor = item.cantidadGramos / base;
    kcal += item.alimento.kcal * factor;
    proteinas += item.alimento.proteinas * factor;
    carbohidratos += item.alimento.carbohidratos * factor;
    grasas += item.alimento.grasas * factor;
    gramos += item.cantidadGramos;
  }

  return _RecipeDraftTotals(
    kcal: kcal,
    proteinas: proteinas,
    carbohidratos: carbohidratos,
    grasas: grasas,
    gramos: gramos,
  );
}

class _RecipeDraftTotals {
  const _RecipeDraftTotals({
    required this.kcal,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    required this.gramos,
  });

  final double kcal;
  final double proteinas;
  final double carbohidratos;
  final double grasas;
  final double gramos;
}

bool _foodMatchesStep(List<String> groups, String expected) {
  if (groups.isEmpty) {
    return true;
  }
  final normalized = groups
      .map((e) => e.trim().toLowerCase().replaceAll('ñ', 'n'))
      .toSet();
  return normalized.contains(expected);
}

Future<double?> _askIngredientGrams(
  BuildContext context, {
  required double initial,
}) async {
  final ctrl = TextEditingController(text: initial.toStringAsFixed(1));
  final result = await showDialog<double>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Editar cantidad (g)'),
      content: TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(hintText: 'Ej. 15.5'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final parsed = double.tryParse(
              ctrl.text.trim().replaceAll(',', '.'),
            );
            if (parsed == null || parsed <= 0) {
              return;
            }
            Navigator.of(dialogContext).pop(parsed);
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
  return result;
}
