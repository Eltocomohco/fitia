import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../providers/shopping_provider.dart';

/// Pantalla de consolidación de la lista de compra por rango temporal.
class ShoppingListScreen extends ConsumerWidget {
  /// Crea un [ShoppingListScreen].
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(shoppingRangeProvider);
    final pantryAsync = ref.watch(pantryInventoryProvider);
    final shoppingAsync = ref.watch(
      shoppingListProvider(range.start, range.end),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de la compra'),
        actions: [
          IconButton(
            tooltip: 'Añadir manualmente',
            onPressed: () => _showAddManualItemDialog(context, ref, range),
            icon: const Icon(Icons.add_shopping_cart_outlined),
          ),
          IconButton(
            tooltip: 'Revisar qué falta',
            onPressed: () => _showReview(context, ref, range),
            icon: const Icon(Icons.fact_check_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cómo funciona',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Esta lista se genera sola con tus comidas y recetas del rango elegido.',
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Manual: usa el botón + del encabezado para añadir un item a esta lista o pulsa un formato de compra para meterlo en despensa cuando lo compres.',
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Si te sobra o te falta stock, ajusta la despensa desde los chips de arriba con el botón de quitar.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.date_range_outlined),
                    title: const Text('Rango de fechas'),
                    subtitle: Text('${_f(range.start)} - ${_f(range.end)}'),
                    trailing: TextButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final selected = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(now.year - 2),
                          lastDate: DateTime(now.year + 2),
                          initialDateRange: range,
                        );
                        if (selected != null) {
                          ref
                              .read(shoppingRangeProvider.notifier)
                              .setRange(selected);
                        }
                      },
                      child: const Text('Cambiar'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                pantryAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (pantryItems) {
                    return _PantryCard(
                      items: pantryItems,
                      onClear: pantryItems.isEmpty
                          ? null
                          : () async {
                              await ref
                                  .read(pantryInventoryProvider.notifier)
                                  .clearPantry();
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Despensa limpiada'),
                                ),
                              );
                            },
                      onRemoveOne: (item) async {
                        await ref
                            .read(pantryInventoryProvider.notifier)
                            .removeOne(item);
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                shoppingAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (items) {
                    final totalGrams = items.fold<double>(
                      0,
                      (sum, entry) => sum + entry.missingGrams,
                    );
                    final coveredGrams = items.fold<double>(
                      0,
                      (sum, entry) => sum + entry.availableGrams,
                    );
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${items.length} alimentos por revisar',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${totalGrams.toStringAsFixed(0)} g equivalentes por comprar',
                                  ),
                                  if (coveredGrams > 0)
                                    Text(
                                      '${coveredGrams.toStringAsFixed(0)} g cubiertos por productos en despensa',
                                    ),
                                ],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => _showReview(context, ref, range),
                              icon: const Icon(Icons.fact_check_outlined),
                              label: const Text('Revisar'),
                            ),
                            IconButton(
                              tooltip: 'Copiar lista',
                              onPressed: items.isEmpty
                                  ? null
                                  : () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: _buildClipboardText(
                                            range: range,
                                            items: items,
                                          ),
                                        ),
                                      );
                                      if (!context.mounted) {
                                        return;
                                      }
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Lista copiada al portapapeles'),
                                        ),
                                      );
                                    },
                              icon: const Icon(Icons.content_copy_outlined),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: shoppingAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Error al consolidar lista')),
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text('Con lo que tienes en despensa no falta comprar nada en este rango'),
                  );
                }
                return _ShoppingChecklist(items: items, range: range);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddManualItemDialog(
    BuildContext context,
    WidgetRef ref,
    DateTimeRange range,
  ) async {
    final nameController = TextEditingController();
    final gramsController = TextEditingController(text: '500');

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Añadir a la lista'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ej. aguacate, yogur, papel de horno',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: gramsController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Cantidad orientativa en gramos',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Añadir'),
          ),
        ],
      ),
    );

    if (saved != true) {
      return;
    }

    final name = nameController.text.trim();
    final grams = double.tryParse(gramsController.text.trim().replaceAll(',', '.'));
    if (name.isEmpty || grams == null || grams <= 0) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Indica un nombre y una cantidad válida')),
        );
      }
      return;
    }

    await ref
        .read(shoppingManualItemsProvider(range.start, range.end).notifier)
        .addItem(name: name, grams: grams, start: range.start, end: range.end);
    ref.invalidate(shoppingListProvider(range.start, range.end));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name añadido a la lista')),
    );
  }

  Future<void> _showReview(
    BuildContext context,
    WidgetRef ref,
    DateTimeRange range,
  ) async {
    final items = await ref.read(
      shoppingListProvider(range.start, range.end).future,
    );
    if (!context.mounted) {
      return;
    }

    final review = buildShoppingReviewMessage(items);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qué te falta por comprar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(review),
            ],
          ),
        ),
      ),
    );
  }
}

class _PantryCard extends StatelessWidget {
  const _PantryCard({
    required this.items,
    required this.onClear,
    required this.onRemoveOne,
  });

  final List<dynamic> items;
  final Future<void> Function()? onClear;
  final Future<void> Function(dynamic item) onRemoveOne;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Despensa',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: const Text('Limpiar'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              items.isEmpty
                  ? 'Todavía no has marcado productos comprados.'
                  : 'Pulsa el menos de cada producto para ajustar lo que te queda en casa.',
            ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in items)
                    InputChip(
                      label: Text('${item.cantidad}x ${item.nombreProducto}'),
                      onDeleted: () => onRemoveOne(item),
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

class _ShoppingChecklist extends ConsumerStatefulWidget {
  const _ShoppingChecklist({required this.items, required this.range});

  final List<ShoppingListItem> items;
  final DateTimeRange range;

  @override
  ConsumerState<_ShoppingChecklist> createState() => _ShoppingChecklistState();
}

class _ShoppingChecklistState extends ConsumerState<_ShoppingChecklist> {
  final Set<String> _checkedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final sortedItems = [...widget.items]
      ..sort((a, b) {
        final leftChecked = _checkedIds.contains(a.key);
        final rightChecked = _checkedIds.contains(b.key);
        if (leftChecked != rightChecked) {
          return leftChecked ? 1 : -1;
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: sortedItems.length,
      itemBuilder: (context, index) {
        final entry = sortedItems[index];
        final food = entry.food;
        final checked = _checkedIds.contains(entry.key);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: CheckboxListTile(
            value: checked,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _checkedIds.add(entry.key);
                } else {
                  _checkedIds.remove(entry.key);
                }
              });
            },
            title: Text(entry.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Faltan ${entry.missingGrams.toStringAsFixed(0)} g · '
                  'Necesitas ${entry.requiredGrams.toStringAsFixed(0)} g · '
                  'Despensa ${entry.availableGrams.toStringAsFixed(0)} g',
                ),
                if (entry.manualItemId != null) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () async {
                      await ref
                          .read(
                            shoppingManualItemsProvider(
                              widget.range.start,
                              widget.range.end,
                            ).notifier,
                          )
                          .removeItem(entry.manualItemId!);
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${entry.name} quitado de la lista')),
                      );
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Quitar de la lista'),
                  ),
                ],
                const SizedBox(height: 8),
                if (food != null && entry.productOptions.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final option in entry.productOptions)
                        ActionChip(
                          label: Text(option.label),
                          onPressed: () async {
                            await ref
                                .read(pantryInventoryProvider.notifier)
                                .addProduct(food, option);
                            if (!context.mounted) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${option.label} añadido a despensa'),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
              ],
            ),
            secondary: checked
                ? const Icon(Icons.check_circle_outline)
                : const Icon(Icons.shopping_cart_outlined),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      },
    );
  }
}

String _buildClipboardText({
  required DateTimeRange range,
  required List<ShoppingListItem> items,
}) {
  final buffer = StringBuffer()
    ..writeln('Lista de la compra')
    ..writeln('${_f(range.start)} - ${_f(range.end)}');
  for (final entry in items) {
    buffer.writeln(
      '- ${entry.name}: '
      '${entry.missingGrams.toStringAsFixed(0)} g '
      '(necesitas ${entry.requiredGrams.toStringAsFixed(0)} g, '
      'para mi ${entry.availableGrams.toStringAsFixed(0)} g)',
    );
  }
  return buffer.toString().trimRight();
}

String _f(DateTime d) {
  return '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';
}
