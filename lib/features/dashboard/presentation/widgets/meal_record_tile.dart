import 'package:flutter/material.dart';

import '../../../nutrition/data/models/registro_diario.dart';

/// Item visual para una comida registrada del día.
class MealRecordTile extends StatelessWidget {
  /// Crea un [MealRecordTile].
  const MealRecordTile({required this.record, super.key});

  /// Registro diario representado.
  final RegistroDiario record;

  @override
  Widget build(BuildContext context) {
    final typeLabel = switch (record.tipoComida) {
      TipoComida.desayuno => 'Desayuno',
      TipoComida.comida => 'Comida',
      TipoComida.cena => 'Cena',
      TipoComida.snack => 'Snack',
    };

    final icon = switch (record.tipoComida) {
      TipoComida.desayuno => Icons.wb_sunny_outlined,
      TipoComida.comida => Icons.lunch_dining_outlined,
      TipoComida.cena => Icons.nights_stay_outlined,
      TipoComida.snack => Icons.cookie_outlined,
    };

    final itemLabel = record.esReceta
        ? 'Receta #${record.itemId}'
        : 'Alimento #${record.itemId}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(typeLabel),
        subtitle: Text(
          '$itemLabel • ${record.cantidadConsumidaGramos.toStringAsFixed(0)} g',
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
