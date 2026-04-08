import 'package:isar_community/isar.dart';

part 'registro_diario.g.dart';

/// Tipos de comida soportados por el registro diario.
enum TipoComida { desayuno, comida, cena, snack }

/// Registro de consumo de alimento o receta en una fecha concreta.
@Collection(accessor: 'registrosDiarios')
class RegistroDiario {
  /// Crea un [RegistroDiario].
  RegistroDiario({
    this.id = Isar.autoIncrement,
    required this.fecha,
    required this.tipoComida,
    required this.esReceta,
    required this.itemId,
    required this.cantidadConsumidaGramos,
  });

  /// Identificador autoincremental.
  Id id;

  /// Fecha/hora exacta del consumo.
  @Index()
  DateTime fecha;

  /// Índice derivado para consultas por día calendario.
  @Index()
  int get fechaDiaKey => _toDayKey(fecha);

  /// Tipo de comida en la que se registró el consumo.
  @enumerated
  late TipoComida tipoComida;

  /// Si `true`, [itemId] apunta a una receta; si `false`, a un alimento.
  late bool esReceta;

  /// ID del item consumido (receta o alimento según [esReceta]).
  @Index()
  late int itemId;

  /// Cantidad consumida en gramos.
  late double cantidadConsumidaGramos;

  static int _toDayKey(DateTime date) =>
      date.year * 10000 + date.month * 100 + date.day;
}
