import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_config.dart';
import '../../data/models/perfil_usuario.dart';

part 'body_profile_provider.freezed.dart';
part 'body_profile_provider.g.dart';

/// Estado inmutable del perfil corporal del usuario.
@freezed
abstract class BodyProfileState with _$BodyProfileState {
  /// Crea un estado de perfil corporal.
  const factory BodyProfileState({
    @Default(34) int edad,
    @Default(176.0) double alturaCm,
  }) = _BodyProfileState;
}

/// Notifier que persiste el perfil corporal en Isar (singleton id=1).
@riverpod
class BodyProfile extends _$BodyProfile {
  static const int _singletonId = 1;

  @override
  Future<BodyProfileState> build() async {
    final isar = await IsarConfig.ensureInitialized();
    final stored = await isar.perfilesUsuario.get(_singletonId);
    if (stored == null) {
      return const BodyProfileState();
    }
    return BodyProfileState(edad: stored.edad, alturaCm: stored.alturaCm);
  }

  /// Actualiza edad y altura y los persiste en Isar.
  Future<void> saveProfile({
    required int edad,
    required double alturaCm,
  }) async {
    final safeEdad = edad < 1 ? 1 : edad;
    final safeAltura = alturaCm <= 0 ? 1.0 : alturaCm;

    final isar = await IsarConfig.ensureInitialized();
    await isar.writeTxn(() async {
      await isar.perfilesUsuario.put(
        PerfilUsuario(id: _singletonId, edad: safeEdad, alturaCm: safeAltura),
      );
    });

    state = AsyncData(BodyProfileState(edad: safeEdad, alturaCm: safeAltura));
  }
}
