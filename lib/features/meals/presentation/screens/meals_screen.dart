import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../inventory/presentation/widgets/add_food_modal.dart';
import '../../../recipes/domain/services/nutrition_calculator_service.dart';
import '../../../recipes/presentation/providers/recipe_provider.dart';

/// Pantalla unificada de comidas (alimentos + recetas).
class MealsScreen extends ConsumerStatefulWidget {
  /// Crea un [MealsScreen].
  const MealsScreen({super.key});

  @override
  ConsumerState<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends ConsumerState<MealsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(inventoryProvider);
    final recipesAsync = ref.watch(recipeListProvider);
    const calculator = RecipeNutritionCalculatorService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comidas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Alimentos'),
            Tab(text: 'Recetas'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_tabController.index == 0) {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) => const AddFoodModal(),
            );
          } else {
            ref.read(recipeBuilderProvider.notifier).resetBuilder();
            if (context.mounted) {
              context.push('/recipes/new');
            }
          }
        },
        icon: const Icon(Icons.add),
        label: Text(
          _tabController.index == 0 ? 'Añadir alimento' : 'Nueva receta',
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          inventoryAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) =>
                const Center(child: Text('Error al cargar alimentos')),
            data: (foods) {
              if (foods.isEmpty) {
                return const Center(
                  child: Text('Aún no hay alimentos registrados'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final alimento = foods[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.restaurant_menu_outlined),
                      title: Text(alimento.nombre),
                      subtitle: Text(
                        'Por ${alimento.porcionBaseGramos.toStringAsFixed(0)}g · '
                        'Kcal ${alimento.kcal.toStringAsFixed(0)} · '
                        'P ${alimento.proteinas.toStringAsFixed(1)}g · '
                        'C ${alimento.carbohidratos.toStringAsFixed(1)}g · '
                        'G ${alimento.grasas.toStringAsFixed(1)}g',
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            await showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              builder: (_) => AddFoodModal(initial: alimento),
                            );
                            return;
                          }

                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: const Text('Eliminar alimento'),
                              content: Text(
                                'Se eliminará "${alimento.nombre}" y sus referencias. ¿Continuar?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(false),
                                  child: const Text('Cancelar'),
                                ),
                                FilledButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(true),
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await ref
                                .read(inventoryProvider.notifier)
                                .deleteAlimento(alimento.id);
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'edit', child: Text('Editar')),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          recipesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) =>
                const Center(child: Text('Error al cargar recetas')),
            data: (recipes) {
              if (recipes.isEmpty) {
                return const Center(child: Text('No hay recetas guardadas'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final receta = recipes[index];
                  return FutureBuilder(
                    future: calculator.calcularMacrosReceta(receta),
                    builder: (context, snapshot) {
                      final macros = snapshot.data;
                      final subtitle = macros == null
                          ? 'Calculando macros por ración...'
                          : 'Kcal ${macros.kcal.toStringAsFixed(0)} · '
                                'P ${macros.proteinas.toStringAsFixed(1)}g · '
                                'C ${macros.carbohidratos.toStringAsFixed(1)}g · '
                                'G ${macros.grasas.toStringAsFixed(1)}g';

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.menu_book_outlined),
                          title: Text(receta.nombre),
                          subtitle: Text(subtitle),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                await ref
                                    .read(recipeBuilderProvider.notifier)
                                    .loadRecipeForEdit(receta.id);
                                if (context.mounted) {
                                  context.push('/recipes/new');
                                }
                                return;
                              }
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Eliminar receta'),
                                  content: Text(
                                    '¿Eliminar "${receta.nombre}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(
                                        dialogContext,
                                      ).pop(false),
                                      child: const Text('Cancelar'),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.of(dialogContext).pop(true),
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await ref
                                    .read(recipeListProvider.notifier)
                                    .deleteRecipe(receta.id);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'info',
                                enabled: false,
                                child: Text(
                                  'Raciones: ${receta.numeroRaciones}',
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Editar'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Eliminar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
