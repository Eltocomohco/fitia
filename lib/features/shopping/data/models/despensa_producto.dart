import 'package:isar_community/isar.dart';

part 'despensa_producto.g.dart';

/// Producto comprado para la despensa asociado a un alimento nutricional base.
@Collection(accessor: 'despensaProductos')
class DespensaProducto {
  /// Crea un [DespensaProducto].
  DespensaProducto({
    this.id = Isar.autoIncrement,
    required this.alimentoId,
    required this.nombreAlimento,
    required this.nombreProducto,
    required this.gramosPorUnidad,
    this.cantidad = 1,
  });

  /// Identificador autoincremental.
  Id id;

  /// Alimento nutricional al que representa el producto.
  @Index()
  late int alimentoId;

  /// Nombre del alimento para UI rápida.
  @Index(caseSensitive: false)
  late String nombreAlimento;

  /// Nombre comercial o formato del producto comprado.
  late String nombreProducto;

  /// Gramos disponibles por unidad de este producto.
  late double gramosPorUnidad;

  /// Número de unidades/paquetes que hay en despensa.
  late int cantidad;
}