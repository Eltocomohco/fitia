import 'package:isar_community/isar.dart';

part 'shopping_manual_item.g.dart';

@Collection(accessor: 'shoppingManualItems')
class ShoppingManualItem {
  ShoppingManualItem({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.grams,
    required this.startDate,
    required this.endDate,
  });

  Id id;

  @Index(caseSensitive: false)
  late String name;

  late double grams;

  @Index()
  late DateTime startDate;

  @Index()
  late DateTime endDate;
}