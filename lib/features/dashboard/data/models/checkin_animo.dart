import 'package:isar_community/isar.dart';

part 'checkin_animo.g.dart';

enum EstadoAnimo {
  hundido,
  bajo,
  estable,
  bien,
  fuerte,
}

@Collection(accessor: 'checkinsAnimo')
class CheckinAnimo {
  CheckinAnimo({
    this.id = Isar.autoIncrement,
    required this.fecha,
    required this.estado,
    required this.energia,
    this.nota,
  });

  Id id;

  @Index()
  DateTime fecha;

  @Enumerated(EnumType.name)
  EstadoAnimo estado;

  int energia;

  String? nota;
}