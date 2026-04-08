import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../nutrition/data/models/receta.dart';
import '../../domain/services/nutrition_calculator_service.dart';
import '../providers/recipe_provider.dart';

/// Pantalla de listado de recetas persistidas.
class RecipeScreen extends ConsumerWidget {
  /// Crea un [RecipeScreen].
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipeListProvider);
    const calculator = RecipeNutritionCalculatorService();

    return Scaffold(
      appBar: AppBar(title: const Text('Recetas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/recipes/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva receta'),
      ),
      body: recipesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Error al cargar recetas')),
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
                            await _openEditRecipeDialog(context, ref, receta);
                            return;
                          }

                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: const Text('Eliminar receta'),
                              content: Text(
                                '¿Eliminar "${receta.nombre}" y sus registros relacionados?',
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

                          if (confirm != true) {
                            return;
                          }

                          await ref
                              .read(recipeListProvider.notifier)
                              .deleteRecipe(receta.id);
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'info',
                            enabled: false,
                            child: Text('Raciones: ${receta.numeroRaciones}'),
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
    );
  }

  Future<void> _openEditRecipeDialog(
    BuildContext context,
    WidgetRef ref,
    Receta receta,
  ) async {
    final nameCtrl = TextEditingController(text: receta.nombre);
    final portionsCtrl = TextEditingController(
      text: receta.numeroRaciones.toString(),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar receta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: portionsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Raciones'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final portions = int.tryParse(portionsCtrl.text.trim());
              if (name.isEmpty || portions == null || portions < 1) {
                return;
              }
              await ref
                  .read(recipeListProvider.notifier)
                  .updateRecipeMeta(
                    recipeId: receta.id,
                    nombre: name,
                    raciones: portions,
                  );
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
