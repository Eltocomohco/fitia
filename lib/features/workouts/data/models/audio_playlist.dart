import 'package:isar_community/isar.dart';

part 'audio_playlist.g.dart';

@Collection(accessor: 'audioPlaylists')
class AudioPlaylist {
  AudioPlaylist({
    this.id = Isar.autoIncrement,
    required this.nombre,
    this.rutasCanciones = const <String>[],
    DateTime? initialCreadoEn,
    DateTime? initialActualizadoEn,
  }) : creadoEn = initialCreadoEn ?? DateTime.now(),
       actualizadoEn = initialActualizadoEn ?? DateTime.now();

  Id id;

  @Index(caseSensitive: false)
  late String nombre;

  late List<String> rutasCanciones;

  late DateTime creadoEn;

  late DateTime actualizadoEn;
}
