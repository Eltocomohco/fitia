import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../progress/data/models/objetivos_nutricionales.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';

part 'daily_macros_provider.freezed.dart';
part 'daily_macros_provider.g.dart';

/// Estado agregado de macronutrientes para el día seleccionado.
@freezed
abstract class DailyMacrosState with _$DailyMacrosState {
  /// Crea un estado inmutable de macros diarios.
  const factory DailyMacrosState({
    @Default(0.0) double kcalConsumidas,
    @Default(2000.0) double kcalObjetivo,
    @Default(0.0) double proteinasGramos,
    @Default(150.0) double proteinasObjetivo,
    @Default(0.0) double carbohidratosGramos,
    @Default(25.0) double carbohidratosObjetivo,
    @Default(0.0) double grasasGramos,
    @Default(140.0) double grasasObjetivo,
    @Default(2500.0) double aguaObjetivoMl,
  }) = _DailyMacrosState;
}

/// Proveedor de instancia Isar activa.
///
/// Debe ser sobreescrito en composición o inicializado vía `Isar.open(...)`
/// antes de consumir este notifier.
final isarInstanceProvider = Provider<Isar>((ref) {
  final instance = Isar.instanceNames.isNotEmpty
      ? Isar.getInstance(Isar.instanceNames.first)
      : null;

  if (instance == null) {
    throw StateError('No existe una instancia de Isar activa.');
  }

  return instance;
});

/// Controlador de estado para la agregación diaria de macronutrientes.
@Riverpod(keepAlive: true)
class DailyMacros extends _$DailyMacros {
  late DateTime _selectedDate;

  @override
  FutureOr<DailyMacrosState> build() {
    _selectedDate = _truncate(DateTime.now());

    Future.microtask(() => fetchDailyData(_selectedDate));

    return const DailyMacrosState();
  }

  /// Consulta `RegistroDiario` por rango del día y recalcula todos los macros.
  Future<void> fetchDailyData(DateTime date) async {
    final isar = ref.read(isarInstanceProvider);

    _selectedDate = _truncate(date);
    final startOfDay = _selectedDate;
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final goals = await _loadGoals(isar);

    state = const AsyncLoading();

    final registros = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfDay, endOfDay)
        .findAll();

    var kcal = 0.0;
    var proteinas = 0.0;
    var carbohidratos = 0.0;
    var grasas = 0.0;

    for (final registro in registros) {
      final totals = registro.esReceta
          ? await _sumarMacrosReceta(isar, registro)
          : await _sumarMacrosAlimento(isar, registro);

      kcal += totals.kcal;
      proteinas += totals.proteinas;
      carbohidratos += totals.carbohidratos;
      grasas += totals.grasas;
    }

    state = AsyncData(
      DailyMacrosState(
        kcalConsumidas: kcal,
        kcalObjetivo: goals.kcalObjetivo,
        proteinasGramos: proteinas,
        proteinasObjetivo: goals.proteinasObjetivo,
        carbohidratosGramos: carbohidratos,
        carbohidratosObjetivo: goals.carbohidratosObjetivo,
        grasasGramos: grasas,
        grasasObjetivo: goals.grasasObjetivo,
        aguaObjetivoMl: goals.aguaObjetivoMl,
      ),
    );
  }

  /// Actualiza objetivos nutricionales del plan diario.
  Future<void> updateGoals({
    required double kcalObjetivo,
    required double proteinasObjetivo,
    required double carbohidratosObjetivo,
    required double grasasObjetivo,
    required double aguaObjetivoMl,
  }) async {
    final isar = ref.read(isarInstanceProvider);
    final current = state.asData?.value ?? const DailyMacrosState();

    final safeKcal = kcalObjetivo <= 0 ? 1.0 : kcalObjetivo;
    final safeProteinas = proteinasObjetivo < 0 ? 0.0 : proteinasObjetivo;
    final safeCarbohidratos = carbohidratosObjetivo < 0
        ? 0.0
        : carbohidratosObjetivo;
    final safeGrasas = grasasObjetivo < 0 ? 0.0 : grasasObjetivo;
    final safeAgua = aguaObjetivoMl <= 0 ? 1.0 : aguaObjetivoMl;

    await isar.writeTxn(() async {
      final existing = await isar.objetivosNutricionales.where().findFirst();
      final objetivos = existing ?? ObjetivosNutricionales();
      objetivos.kcalObjetivo = safeKcal;
      objetivos.proteinasObjetivo = safeProteinas;
      objetivos.carbohidratosObjetivo = safeCarbohidratos;
      objetivos.grasasObjetivo = safeGrasas;
      objetivos.aguaObjetivoMl = safeAgua;
      await isar.objetivosNutricionales.put(objetivos);
    });

    state = AsyncData(
      current.copyWith(
        kcalObjetivo: safeKcal,
        proteinasObjetivo: safeProteinas,
        carbohidratosObjetivo: safeCarbohidratos,
        grasasObjetivo: safeGrasas,
        aguaObjetivoMl: safeAgua,
      ),
    );
  }

  Future<DailyMacrosState> _loadGoals(Isar isar) async {
    final stored = await isar.objetivosNutricionales.where().findFirst();
    if (stored == null) {
      return const DailyMacrosState();
    }
    return DailyMacrosState(
      kcalObjetivo: stored.kcalObjetivo,
      proteinasObjetivo: stored.proteinasObjetivo,
      carbohidratosObjetivo: stored.carbohidratosObjetivo,
      grasasObjetivo: stored.grasasObjetivo,
      aguaObjetivoMl: stored.aguaObjetivoMl,
    );
  }

  /// Inserta un nuevo registro diario y refresca automáticamente el estado.
  Future<void> addFoodEntry({
    required DateTime date,
    required TipoComida tipoComida,
    required bool esReceta,
    required int itemId,
    required double cantidadConsumidaGramos,
  }) async {
    final isar = ref.read(isarInstanceProvider);

    await isar.writeTxn(() async {
      await isar.registrosDiarios.put(
        RegistroDiario(
          fecha: date,
          tipoComida: tipoComida,
          esReceta: esReceta,
          itemId: itemId,
          cantidadConsumidaGramos: cantidadConsumidaGramos,
        ),
      );
    });

    await fetchDailyData(date);
  }

  Future<_MacroTotals> _sumarMacrosAlimento(
    Isar isar,
    RegistroDiario registro,
  ) async {
    final alimento = await isar.alimentos.get(registro.itemId);
    if (alimento == null) {
      return const _MacroTotals();
    }

    final factor = alimento.porcionBaseGramos <= 0
        ? 0.0
        : registro.cantidadConsumidaGramos / alimento.porcionBaseGramos;

    return _MacroTotals(
      kcal: alimento.kcal * factor,
      proteinas: alimento.proteinas * factor,
      carbohidratos: alimento.carbohidratos * factor,
      grasas: alimento.grasas * factor,
    );
  }

  Future<_MacroTotals> _sumarMacrosReceta(
    Isar isar,
    RegistroDiario registro,
  ) async {
    final receta = await isar.recetas.get(registro.itemId);
    if (receta == null) {
      return const _MacroTotals();
    }

    await receta.ingredientes.load();

    if (receta.ingredientes.isEmpty) {
      return const _MacroTotals();
    }

    var recetaKcal = 0.0;
    var recetaProteinas = 0.0;
    var recetaCarbohidratos = 0.0;
    var recetaGrasas = 0.0;
    var pesoTotalReceta = 0.0;

    for (final ingrediente in receta.ingredientes) {
      await ingrediente.alimento.load();
      final alimento = ingrediente.alimento.value;
      if (alimento == null) {
        continue;
      }

      final factorIngrediente = alimento.porcionBaseGramos <= 0
          ? 0.0
          : ingrediente.cantidadGramos / alimento.porcionBaseGramos;

      recetaKcal += alimento.kcal * factorIngrediente;
      recetaProteinas += alimento.proteinas * factorIngrediente;
      recetaCarbohidratos += alimento.carbohidratos * factorIngrediente;
      recetaGrasas += alimento.grasas * factorIngrediente;
      pesoTotalReceta += ingrediente.cantidadGramos;
    }

    final factorConsumo = pesoTotalReceta <= 0
        ? 0.0
        : registro.cantidadConsumidaGramos / pesoTotalReceta;

    return _MacroTotals(
      kcal: recetaKcal * factorConsumo,
      proteinas: recetaProteinas * factorConsumo,
      carbohidratos: recetaCarbohidratos * factorConsumo,
      grasas: recetaGrasas * factorConsumo,
    );
  }

  DateTime _truncate(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}

class _MacroTotals {
  const _MacroTotals({
    this.kcal = 0.0,
    this.proteinas = 0.0,
    this.carbohidratos = 0.0,
    this.grasas = 0.0,
  });

  final double kcal;
  final double proteinas;
  final double carbohidratos;
  final double grasas;
}
