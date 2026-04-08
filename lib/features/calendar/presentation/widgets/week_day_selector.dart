import 'package:flutter/material.dart';

/// Selector horizontal de días para planificación semanal.
class WeekDaySelector extends StatelessWidget {
  /// Crea un [WeekDaySelector].
  const WeekDaySelector({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  /// Índice del día seleccionado (0-6).
  final int selectedIndex;

  /// Callback de selección.
  final ValueChanged<int> onSelected;

  static const _days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ChoiceChip(
            label: Text(_days[index]),
            selected: selectedIndex == index,
            onSelected: (_) => onSelected(index),
          );
        },
      ),
    );
  }
}
