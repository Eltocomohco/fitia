import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/inventory_provider.dart';
import '../widgets/add_food_modal.dart';

/// Pantalla principal del inventario de alimentos base.
class InventoryScreen extends ConsumerWidget {
  /// Crea un [InventoryScreen].
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => const AddFoodModal(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir alimento'),
      ),
      body: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Error al cargar inventario')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('Aún no hay alimentos registrados'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final alimento = items[index];
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
                        if (!context.mounted) {
                          return;
                        }
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
                            'Se eliminará "${alimento.nombre}" y sus referencias en registros/recetas. ¿Continuar?',
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
                          .read(inventoryProvider.notifier)
                          .deleteAlimento(alimento.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Alimento eliminado correctamente'),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Editar')),
                      PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
