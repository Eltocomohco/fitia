import 'package:isar_community/isar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_config.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../progress/data/models/dia_entrenamiento.dart';
import '../../../progress/data/models/objetivos_nutricionales.dart';
import '../../data/models/perfil_usuario.dart';
import '../../../workouts/data/models/sesion_entrenamiento.dart';

part 'body_profile_provider.freezed.dart';
part 'body_profile_provider.g.dart';

/// Estado inmutable del perfil corporal del usuario.
@freezed
abstract class BodyProfileState with _$BodyProfileState {
  /// Crea un estado de perfil corporal.
  const factory BodyProfileState({
    @Default(34) int edad,
    @Default(176.0) double alturaCm,
    @Default('') String nombre,
    @Default('') String objetivoPrincipal,
    double? pesoObjetivoKg,
    int? pesoObjetivoPlazoSemanas,
    @Default('') String hambreHabitual,
    @Default('') String saciedadComidas,
    @Default('') String saciedadDesayuno,
    @Default('') String saciedadComida,
    @Default('') String saciedadCena,
    int? suenoInicioMinutos,
    int? suenoFinMinutos,
    @Default(0) int pasosDiarios,
    @Default(0) int adherenciaDietaSemanal,
    @Default(0) int adherenciaEntrenoSemanal,
    @Default('') String digestion,
    @Default('') String alimentosQueSientanMal,
    @Default('') String preferenciasComida,
    @Default('') String estadoEmocionalComida,
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
    final initial = stored == null ? const BodyProfileState() : _toState(stored);
    final hydrated = await _withComputedInsights(initial, isar: isar);
    if (stored == null || _shouldPersistComputedFields(initial, hydrated)) {
      await isar.writeTxn(() async {
        await isar.perfilesUsuario.put(_toModel(hydrated));
      });
    }
    return hydrated;
  }

  /// Actualiza el perfil extendido y lo persiste en Isar.
  Future<void> saveProfile({
    required int edad,
    required double alturaCm,
    String? nombre,
    String? objetivoPrincipal,
    double? pesoObjetivoKg,
    int? pesoObjetivoPlazoSemanas,
    String? hambreHabitual,
    String? saciedadDesayuno,
    String? saciedadComida,
    String? saciedadCena,
    String? digestion,
    String? alimentosQueSientanMal,
    String? preferenciasComida,
    String? estadoEmocionalComida,
  }) async {
    final safeEdad = edad < 1 ? 1 : edad;
    final safeAltura = alturaCm <= 0 ? 1.0 : alturaCm;
    final current = state.asData?.value ?? const BodyProfileState();

    final isar = await IsarConfig.ensureInitialized();
    final next = await _withComputedInsights(
      current.copyWith(
        edad: safeEdad,
        alturaCm: safeAltura,
        nombre: _cleanText(nombre ?? current.nombre),
        objetivoPrincipal: _cleanText(
          objetivoPrincipal ?? current.objetivoPrincipal,
        ),
        pesoObjetivoKg: _normalizeWeightGoal(
          pesoObjetivoKg ?? current.pesoObjetivoKg,
        ),
        pesoObjetivoPlazoSemanas: _normalizeGoalWeeks(
          pesoObjetivoPlazoSemanas ?? current.pesoObjetivoPlazoSemanas,
        ),
        hambreHabitual: _cleanText(hambreHabitual ?? current.hambreHabitual),
        saciedadDesayuno: _cleanText(
          saciedadDesayuno ?? current.saciedadDesayuno,
        ),
        saciedadComida: _cleanText(saciedadComida ?? current.saciedadComida),
        saciedadCena: _cleanText(saciedadCena ?? current.saciedadCena),
        digestion: _cleanText(digestion ?? current.digestion),
        alimentosQueSientanMal: _cleanText(
          alimentosQueSientanMal ?? current.alimentosQueSientanMal,
        ),
        preferenciasComida: _cleanText(
          preferenciasComida ?? current.preferenciasComida,
        ),
        estadoEmocionalComida: _cleanText(
          estadoEmocionalComida ?? current.estadoEmocionalComida,
        ),
      ),
      isar: isar,
    );

    await isar.writeTxn(() async {
      await isar.perfilesUsuario.put(_toModel(next));
    });

    if (!ref.mounted) {
      return;
    }

    state = AsyncData(next);
  }

  /// Persiste datos sincronizados desde Health Connect.
  Future<void> syncHealthMetrics({
    required int pasosDiarios,
    DateTime? suenoInicio,
    DateTime? suenoFin,
  }) async {
    final current = state.asData?.value ?? const BodyProfileState();
    final isar = await IsarConfig.ensureInitialized();
    final next = current.copyWith(
      pasosDiarios: pasosDiarios < 0 ? 0 : pasosDiarios,
      suenoInicioMinutos: suenoInicio == null ? current.suenoInicioMinutos : _toMinutesOfDay(suenoInicio),
      suenoFinMinutos: suenoFin == null ? current.suenoFinMinutos : _toMinutesOfDay(suenoFin),
    );
    final hydrated = await _withComputedInsights(next, isar: isar);

    await isar.writeTxn(() async {
      await isar.perfilesUsuario.put(_toModel(hydrated));
    });

    if (!ref.mounted) {
      return;
    }

    state = AsyncData(hydrated);
  }

  BodyProfileState _toState(PerfilUsuario stored) {
    return BodyProfileState(
      edad: stored.edad,
      alturaCm: stored.alturaCm,
      nombre: stored.nombre,
      objetivoPrincipal: stored.objetivoPrincipal,
      pesoObjetivoKg: stored.pesoObjetivoKg,
      pesoObjetivoPlazoSemanas: stored.pesoObjetivoPlazoSemanas,
      hambreHabitual: stored.hambreHabitual,
      saciedadComidas: stored.saciedadComidas,
      saciedadDesayuno: stored.saciedadDesayuno,
      saciedadComida: stored.saciedadComida,
      saciedadCena: stored.saciedadCena,
      suenoInicioMinutos: stored.suenoInicioMinutos,
      suenoFinMinutos: stored.suenoFinMinutos,
      pasosDiarios: stored.pasosDiarios,
      adherenciaDietaSemanal: stored.adherenciaDietaSemanal,
      adherenciaEntrenoSemanal: stored.adherenciaEntrenoSemanal,
      digestion: stored.digestion,
      alimentosQueSientanMal: stored.alimentosQueSientanMal,
      preferenciasComida: stored.preferenciasComida,
      estadoEmocionalComida: stored.estadoEmocionalComida,
    );
  }

  PerfilUsuario _toModel(BodyProfileState state) {
    return PerfilUsuario(
      id: _singletonId,
      edad: state.edad,
      alturaCm: state.alturaCm,
      nombre: state.nombre,
      objetivoPrincipal: state.objetivoPrincipal,
      pesoObjetivoKg: state.pesoObjetivoKg,
      pesoObjetivoPlazoSemanas: state.pesoObjetivoPlazoSemanas,
      hambreHabitual: state.hambreHabitual,
      saciedadComidas: state.saciedadComidas,
      saciedadDesayuno: state.saciedadDesayuno,
      saciedadComida: state.saciedadComida,
      saciedadCena: state.saciedadCena,
      suenoInicioMinutos: state.suenoInicioMinutos,
      suenoFinMinutos: state.suenoFinMinutos,
      pasosDiarios: state.pasosDiarios,
      adherenciaDietaSemanal: state.adherenciaDietaSemanal,
      adherenciaEntrenoSemanal: state.adherenciaEntrenoSemanal,
      digestion: state.digestion,
      alimentosQueSientanMal: state.alimentosQueSientanMal,
      preferenciasComida: state.preferenciasComida,
      estadoEmocionalComida: state.estadoEmocionalComida,
    );
  }

  String _cleanText(String value) => value.trim();

  Future<BodyProfileState> _withComputedInsights(
    BodyProfileState input, {
    required Isar isar,
  }) async {
    final desayuno = _cleanText(input.saciedadDesayuno);
    final comida = _cleanText(input.saciedadComida);
    final cena = _cleanText(input.saciedadCena);
    final dietAdherence = await _computeDietAdherencePercent(isar);
    final workoutAdherence = await _computeWorkoutAdherencePercent(isar);
    return input.copyWith(
      pesoObjetivoPlazoSemanas: _normalizeGoalWeeks(
        input.pesoObjetivoPlazoSemanas,
      ),
      saciedadDesayuno: desayuno,
      saciedadComida: comida,
      saciedadCena: cena,
      saciedadComidas: _composeSatietySummary(
        desayuno: desayuno,
        comida: comida,
        cena: cena,
        fallback: input.saciedadComidas,
      ),
      adherenciaDietaSemanal: dietAdherence,
      adherenciaEntrenoSemanal: workoutAdherence,
    );
  }

  bool _shouldPersistComputedFields(
    BodyProfileState previous,
    BodyProfileState next,
  ) {
    return previous.pesoObjetivoPlazoSemanas != next.pesoObjetivoPlazoSemanas ||
        previous.saciedadComidas != next.saciedadComidas ||
        previous.saciedadDesayuno != next.saciedadDesayuno ||
        previous.saciedadComida != next.saciedadComida ||
        previous.saciedadCena != next.saciedadCena ||
        previous.adherenciaDietaSemanal != next.adherenciaDietaSemanal ||
        previous.adherenciaEntrenoSemanal != next.adherenciaEntrenoSemanal;
  }

  double? _normalizeWeightGoal(double? value) {
    if (value == null || value <= 0) {
      return null;
    }
    return value;
  }

  int? _normalizeGoalWeeks(int? value) {
    if (value == null || value <= 0) {
      return null;
    }
    return value;
  }

  String _composeSatietySummary({
    required String desayuno,
    required String comida,
    required String cena,
    required String fallback,
  }) {
    final parts = <String>[];
    if (desayuno.isNotEmpty) {
      parts.add('desayuno: $desayuno');
    }
    if (comida.isNotEmpty) {
      parts.add('comida: $comida');
    }
    if (cena.isNotEmpty) {
      parts.add('cena: $cena');
    }
    if (parts.isNotEmpty) {
      return parts.join(' | ');
    }
    return _cleanText(fallback);
  }

  int _normalizePercent(int value) => value.clamp(0, 100);

  Future<int> _computeDietAdherencePercent(Isar isar) async {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfWindow = startOfToday.subtract(const Duration(days: 6));
    final records = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfWindow, now)
        .findAll();

    if (records.isEmpty) {
      return 0;
    }

    final calorieGoal = await _loadCalorieGoal(isar);
    final recordsByDay = <int, List<RegistroDiario>>{};
    for (final record in records) {
      recordsByDay.putIfAbsent(record.fechaDiaKey, () => <RegistroDiario>[]).add(record);
    }

    if (calorieGoal != null && calorieGoal > 0) {
      var compliantDays = 0;
      for (final dayRecords in recordsByDay.values) {
        var totalKcal = 0.0;
        for (final record in dayRecords) {
          totalKcal += await _loadConsumedKcal(isar, record);
        }
        final delta = (totalKcal - calorieGoal).abs();
        if (delta <= calorieGoal * 0.1) {
          compliantDays += 1;
        }
      }
      return _normalizePercent(((compliantDays / 7) * 100).round());
    }

    var weeklyCoverage = 0.0;
    for (final dayRecords in recordsByDay.values) {
      final mainMeals = dayRecords
          .map((record) => record.tipoComida)
          .where(
            (mealType) =>
                mealType == TipoComida.desayuno ||
                mealType == TipoComida.comida ||
                mealType == TipoComida.cena,
          )
          .toSet();
      weeklyCoverage += mainMeals.length / 3;
    }
    return _normalizePercent(((weeklyCoverage / 7) * 100).round());
  }

  Future<int> _computeWorkoutAdherencePercent(Isar isar) async {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfWindow = startOfToday.subtract(const Duration(days: 6));
    final trainedDayKeys = <int>{};

    final sessions = await isar.sesionesEntrenamiento
        .filter()
        .fechaInicioBetween(startOfWindow, now)
        .findAll();
    for (final session in sessions) {
      if (session.estado != EstadoSesionEntrenamiento.completada) {
        continue;
      }
      final date = session.fechaFin ?? session.fechaInicio;
      trainedDayKeys.add(_toDayKey(date));
    }

    final manualDays = await isar.diasEntrenamiento
        .filter()
        .fechaBetween(startOfWindow, now)
        .findAll();
    for (final day in manualDays) {
      trainedDayKeys.add(day.fechaDiaKey);
    }

    return _normalizePercent(((trainedDayKeys.length / 4) * 100).round());
  }

  Future<double?> _loadCalorieGoal(Isar isar) async {
    final goal = await isar.objetivosNutricionales.where().findFirst();
    return goal?.kcalObjetivo;
  }

  Future<double> _loadConsumedKcal(Isar isar, RegistroDiario record) async {
    if (record.esReceta) {
      final recipe = await isar.recetas.get(record.itemId);
      if (recipe == null) {
        return 0;
      }

      await recipe.ingredientes.load();
      if (recipe.ingredientes.isEmpty) {
        return 0;
      }

      var recipeKcal = 0.0;
      var totalRecipeWeight = 0.0;
      for (final ingredient in recipe.ingredientes) {
        await ingredient.alimento.load();
        final food = ingredient.alimento.value;
        if (food == null || food.porcionBaseGramos <= 0) {
          continue;
        }
        final factor = ingredient.cantidadGramos / food.porcionBaseGramos;
        recipeKcal += food.kcal * factor;
        totalRecipeWeight += ingredient.cantidadGramos;
      }

      if (totalRecipeWeight <= 0) {
        return 0;
      }

      return recipeKcal * (record.cantidadConsumidaGramos / totalRecipeWeight);
    }

    final food = await isar.alimentos.get(record.itemId);
    if (food == null || food.porcionBaseGramos <= 0) {
      return 0;
    }
    return food.kcal * (record.cantidadConsumidaGramos / food.porcionBaseGramos);
  }

  int _toDayKey(DateTime date) => date.year * 10000 + date.month * 100 + date.day;

  int _toMinutesOfDay(DateTime dateTime) => dateTime.hour * 60 + dateTime.minute;
}

extension BodyProfileStateX on BodyProfileState {
  bool get hasCompletedOnboarding {
    final hasSatiety = saciedadComidas.trim().isNotEmpty ||
        saciedadDesayuno.trim().isNotEmpty ||
        saciedadComida.trim().isNotEmpty ||
        saciedadCena.trim().isNotEmpty;
    return nombre.trim().isNotEmpty &&
        objetivoPrincipal.trim().isNotEmpty &&
        pesoObjetivoKg != null &&
        pesoObjetivoKg! > 0 &&
        hambreHabitual.trim().isNotEmpty &&
        hasSatiety;
  }
}
