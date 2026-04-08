import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../nutrition/data/models/alimento.dart';
import '../providers/shopping_provider.dart';

/// Pantalla de consolidación de la lista de compra por rango temporal.
class ShoppingListScreen extends ConsumerWidget {
  /// Crea un [ShoppingListScreen].
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(shoppingRangeProvider);
    final shoppingAsync = ref.watch(
      shoppingListProvider(range.start, range.end),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de la compra')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
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
          ),
          Expanded(
            child: shoppingAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Error al consolidar lista')),
              data: (map) {
                if (map.isEmpty) {
                  return const Center(
                    child: Text('No hay ingredientes para este rango'),
                  );
                }
                return _ShoppingChecklist(items: map.entries.toList());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingChecklist extends StatefulWidget {
  const _ShoppingChecklist({required this.items});

  final List<MapEntry<Alimento, double>> items;

  @override
  State<_ShoppingChecklist> createState() => _ShoppingChecklistState();
}

class _ShoppingChecklistState extends State<_ShoppingChecklist> {
  final Set<int> _checkedIds = <int>{};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final entry = widget.items[index];
        final food = entry.key;
        final grams = entry.value;
        final checked = _checkedIds.contains(food.id);

        return CheckboxListTile(
          value: checked,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _checkedIds.add(food.id);
              } else {
                _checkedIds.remove(food.id);
              }
            });
          },
          title: Text(food.nombre),
          subtitle: Text('${grams.toStringAsFixed(0)} g'),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}

String _f(DateTime d) {
  return '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';
}
