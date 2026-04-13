import 'package:isar_community/isar.dart';

part 'tarea_hoy.g.dart';

@Collection(accessor: 'tareasHoy')
class TareaHoy {
  TareaHoy({
    this.id = Isar.autoIncrement,
    required this.fecha,
    required this.titulo,
    DateTime? initialCreadaEn,
    this.completada = false,
    this.completadaEn,
  }) : creadaEn = initialCreadaEn ?? DateTime.now();

  Id id;

  @Index()
  DateTime fecha;

  @Index(caseSensitive: false)
  late String titulo;

  late DateTime creadaEn;

  bool completada;

  DateTime? completadaEn;
}