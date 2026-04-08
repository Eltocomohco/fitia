import 'package:flutter/material.dart';

/// Bloque de ingesta diaria con acción para agregar ítems.
class IntakeBlockCard extends StatelessWidget {
  /// Crea un [IntakeBlockCard].
  const IntakeBlockCard({required this.title, required this.onAdd, super.key});

  /// Nombre del bloque de ingesta.
  final String title;

  /// Acción principal para añadir ítems.
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: const Text('Sin elementos programados'),
        trailing: FilledButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Añadir'),
        ),
      ),
    );
  }
}
