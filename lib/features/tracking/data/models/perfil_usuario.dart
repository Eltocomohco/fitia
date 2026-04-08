import 'package:isar_community/isar.dart';

part 'perfil_usuario.g.dart';

/// Singleton de perfil del usuario almacenado en Isar.
///
/// Siempre usa `id = 1` para garantizar que haya un único documento.
@Collection(accessor: 'perfilesUsuario')
class PerfilUsuario {
  /// Crea un [PerfilUsuario] con valores predeterminados.
  PerfilUsuario({
    this.id = 1,
    this.alturaCm = 176.0,
    this.edad = 34,
    this.genero = '',
  });

  /// Identificador fijo (siempre 1).
  Id id;

  /// Altura en centímetros.
  double alturaCm;

  /// Edad en años.
  int edad;

  /// Género del usuario (opcional).
  String genero;
}
