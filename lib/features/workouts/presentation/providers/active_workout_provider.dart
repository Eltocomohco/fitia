import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/ejercicio.dart';
import '../../data/models/registro_ejercicio_sesion.dart';
import '../../data/models/rutina_ejercicio.dart';
import '../../data/models/serie.dart';
import '../../data/models/sesion_entrenamiento.dart';
import '../../domain/services/workout_automation_service.dart';
import 'workout_catalog_provider.dart';
import 'workout_history_provider.dart';
import 'workout_routine_provider.dart';
import 'workout_timer_provider.dart';

part 'active_workout_provider.g.dart';

/// Indica si el proveedor está reconstruyendo una sesión persistida.
@Riverpod(keepAlive: true)
class ActiveWorkoutRestoring extends _$ActiveWorkoutRestoring {
  @override
  bool build() => false;

  /// Actualiza el estado de reconstrucción.
  void setRestoring(bool value) {
    state = value;
  }
}

/// Grupo de trabajo lineal para pintar una cabecera de ejercicio y sus series.
class WorkoutExerciseGroup {
  /// Crea un [WorkoutExerciseGroup].
  const WorkoutExerciseGroup({
    required this.ejercicio,
    required this.series,
    required this.registro,
  });

  /// Ejercicio asociado al bloque.
  final Ejercicio ejercicio;

  /// Series del ejercicio dentro de la sesión activa.
  final List<Serie> series;

  /// Registro diario del ejercicio para capturar sensación y contexto.
  final RegistroEjercicioSesion registro;

  /// Copia el bloque cambiando los campos indicados.
  WorkoutExerciseGroup copyWith({
    Ejercicio? ejercicio,
    List<Serie>? series,
    RegistroEjercicioSesion? registro,
  }) {
    return WorkoutExerciseGroup(
      ejercicio: ejercicio ?? this.ejercicio,
      series: series ?? this.series,
      registro: registro ?? this.registro,
    );
  }
}

/// Estado transaccional en vivo de la sesión de entrenamiento.
class ActiveWorkoutState {
  /// Crea un [ActiveWorkoutState].
  const ActiveWorkoutState({required this.sesion, required this.grupos});

  /// Sesión persistida actualmente abierta.
  final SesionEntrenamiento sesion;

  /// Bloques agrupados por ejercicio para la UI operativa.
  final List<WorkoutExerciseGroup> grupos;

  /// Copia el estado cambiando los campos indicados.
  ActiveWorkoutState copyWith({
    SesionEntrenamiento? sesion,
    List<WorkoutExerciseGroup>? grupos,
  }) {
    return ActiveWorkoutState(
      sesion: sesion ?? this.sesion,
      grupos: grupos ?? this.grupos,
    );
  }
}

/// Gestor de la sesión de entrenamiento actualmente abierta.
@Riverpod(keepAlive: true)
class ActiveWorkout extends _$ActiveWorkout {
  @override
  ActiveWorkoutState? build() {
    ref.read(activeWorkoutRestoringProvider.notifier).setRestoring(false);
    final isar = ref.read(workoutIsarProvider);
    return _restoreActiveSessionSync(isar);
  }

  /// Inicia una sesión vacía para construir el entrenamiento sobre la marcha.
  Future<void> iniciarEntrenamientoVacio() async {
    final isar = ref.read(workoutIsarProvider);
    final sesion = SesionEntrenamiento(fechaInicio: DateTime.now());

    await isar.writeTxn(() async {
      sesion.id = await isar.sesionesEntrenamiento.put(sesion);
    });

    state = ActiveWorkoutState(sesion: sesion, grupos: const []);
    ref.read(activeWorkoutRestoringProvider.notifier).setRestoring(false);
  }

  /// Inicia una sesión a partir de una rutina plantilla existente.
  Future<void> iniciarDesdeRutina(int rutinaId) async {
    final isar = ref.read(workoutIsarProvider);
    final sesion = SesionEntrenamiento(
      fechaInicio: DateTime.now(),
      rutinaPlantillaId: rutinaId,
    );
    final relaciones = await _loadRoutineRelations(isar, rutinaId);
    final catalogo = await isar.ejercicios.where().findAll();
    final ejerciciosSeleccionados = <Ejercicio>[
      for (final relation in relaciones)
        if (relation.ejercicio.value != null) relation.ejercicio.value!,
    ];
    final seriesObjetivo = <int, int>{
      for (final relation in relaciones)
        if (relation.ejercicio.value != null)
          relation.ejercicio.value!.id: relation.seriesObjetivo,
    };
    final plan = WorkoutAutomationService.buildAutomatedSession(
      selectedExercises: ejerciciosSeleccionados,
      selectedSeriesCount: seriesObjetivo,
      catalog: catalogo,
    );
    final groups = <WorkoutExerciseGroup>[];

    await isar.writeTxn(() async {
      sesion.id = await isar.sesionesEntrenamiento.put(sesion);

      for (var index = 0; index < plan.length; index++) {
        final block = plan[index];
        final ejercicio = block.exercise;
        final registro = RegistroEjercicioSesion(orden: index);
        registro.sesion.value = sesion;
        registro.ejercicio.value = ejercicio;
        registro.id = await isar.registrosEjercicioSesion.put(registro);
        await registro.sesion.save();
        await registro.ejercicio.save();

        final series = <Serie>[];
        for (var serieIndex = 0; serieIndex < block.seriesCount; serieIndex++) {
          final serie = Serie();
          serie.sesion.value = sesion;
          serie.ejercicio.value = ejercicio;
          serie.id = await isar.series.put(serie);
          await serie.sesion.save();
          await serie.ejercicio.save();
          series.add(serie);
        }

        groups.add(
          WorkoutExerciseGroup(
            ejercicio: ejercicio,
            series: series,
            registro: registro,
          ),
        );
      }
    });

    state = ActiveWorkoutState(sesion: sesion, grupos: groups);
    ref.read(activeWorkoutRestoringProvider.notifier).setRestoring(false);
  }

  /// Añade un ejercicio a la sesión activa creando su primera serie pendiente.
  Future<void> agregarEjercicio(int ejercicioId) async {
    final current = state;
    if (current == null) {
      return;
    }

    final isar = ref.read(workoutIsarProvider);
    final ejercicio = await isar.ejercicios.get(ejercicioId);
    if (ejercicio == null) {
      return;
    }

    RegistroEjercicioSesion? registro;
    final serie = Serie();
    serie.sesion.value = current.sesion;
    serie.ejercicio.value = ejercicio;

    await isar.writeTxn(() async {
      if (!current.grupos.any((group) => group.ejercicio.id == ejercicioId)) {
        registro = RegistroEjercicioSesion(orden: current.grupos.length);
        registro!.sesion.value = current.sesion;
        registro!.ejercicio.value = ejercicio;
        registro!.id = await isar.registrosEjercicioSesion.put(registro!);
        await registro!.sesion.save();
        await registro!.ejercicio.save();
      }

      serie.id = await isar.series.put(serie);
      await serie.sesion.save();
      await serie.ejercicio.save();
    });

    final groups = [...current.grupos];
    final index = groups.indexWhere(
      (group) => group.ejercicio.id == ejercicioId,
    );
    if (index >= 0) {
      final series = [...groups[index].series, serie];
      groups[index] = groups[index].copyWith(series: series);
    } else {
      groups.add(
        WorkoutExerciseGroup(
          ejercicio: ejercicio,
          series: [serie],
          registro: registro!,
        ),
      );
    }

    state = current.copyWith(grupos: groups);
  }

  /// Añade una nueva serie pendiente al ejercicio indicado.
  Future<void> agregarSerie(int ejercicioId) async {
    await agregarEjercicio(ejercicioId);
  }

  /// Marca una serie como completada, la persiste y arranca el descanso base.
  Future<void> marcarSerie(int serieId, double peso, int reps) async {
    final current = state;
    if (current == null) {
      return;
    }

    final isar = ref.read(workoutIsarProvider);
    final serie = await isar.series.get(serieId);
    if (serie == null) {
      return;
    }

    await serie.ejercicio.load();
    final ejercicio = serie.ejercicio.value;
    if (ejercicio == null) {
      return;
    }

    serie.pesoKg = peso < 0 ? 0 : peso;
    serie.repeticiones = reps < 0 ? 0 : reps;
    serie.completada = true;

    await isar.writeTxn(() async {
      await isar.series.put(serie);
    });

    final groups = [
      for (final group in current.grupos)
        if (group.ejercicio.id != ejercicio.id)
          group
        else
          group.copyWith(
            series: [
              for (final item in group.series)
                if (item.id == serieId) serie else item,
            ],
          ),
    ];

    state = current.copyWith(grupos: groups);
    ref
        .read(workoutTimerProvider.notifier)
        .startTimer(_resolveRestSeconds(ejercicio));
  }

  /// Persiste cambios intermedios de peso y repeticiones sin esperar a cerrar la serie.
  Future<void> actualizarSerieDraft(
    int serieId, {
    double? pesoKg,
    int? repeticiones,
  }) async {
    final current = state;
    if (current == null) {
      return;
    }

    final isar = ref.read(workoutIsarProvider);
    final serie = await isar.series.get(serieId);
    if (serie == null) {
      return;
    }

    var changed = false;
    if (pesoKg != null && serie.pesoKg != pesoKg) {
      serie.pesoKg = pesoKg < 0 ? 0 : pesoKg;
      changed = true;
    }
    if (repeticiones != null && serie.repeticiones != repeticiones) {
      serie.repeticiones = repeticiones < 0 ? 0 : repeticiones;
      changed = true;
    }
    if (!changed) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.series.put(serie);
    });

    state = current.copyWith(grupos: _replaceSerie(current.grupos, serie));
  }

  /// Actualiza la sensación subjetiva del día para un ejercicio de la sesión activa.
  Future<void> actualizarSensacion(
    int ejercicioId,
    SensacionEjercicio sensacion,
  ) async {
    final current = state;
    if (current == null) {
      return;
    }

    final index = current.grupos.indexWhere(
      (group) => group.ejercicio.id == ejercicioId,
    );
    if (index < 0) {
      return;
    }

    final registro = current.grupos[index].registro;
    registro.sensacion = sensacion;
    registro.sesion.value = current.sesion;
    registro.ejercicio.value = current.grupos[index].ejercicio;

    final isar = ref.read(workoutIsarProvider);
    await isar.writeTxn(() async {
      await isar.registrosEjercicioSesion.put(registro);
    });

    final groups = [...current.grupos];
    groups[index] = groups[index].copyWith(registro: registro);
    state = current.copyWith(grupos: groups);
  }

  /// Cierra la sesión actual, persiste la hora final y limpia el estado activo.
  Future<void> finalizarSesion() async {
    final current = state;
    if (current == null) {
      return;
    }

    final isar = ref.read(workoutIsarProvider);
    final sesion = current.sesion;
    sesion.fechaFin = DateTime.now();
    sesion.estado = EstadoSesionEntrenamiento.completada;

    await isar.writeTxn(() async {
      await isar.sesionesEntrenamiento.put(sesion);
    });

    ref.invalidate(workoutCatalogProvider);
    ref.invalidate(workoutSessionHistoryProvider);
    if (sesion.rutinaPlantillaId != null) {
      ref.invalidate(workoutRoutineDetailProvider(sesion.rutinaPlantillaId!));
    }
    ref.read(workoutTimerProvider.notifier).reset();
    state = null;
  }

  ActiveWorkoutState? _restoreActiveSessionSync(Isar isar) {
    final sesiones = isar.sesionesEntrenamiento.where().findAllSync();
    SesionEntrenamiento? sesionActiva;
    for (final sesion in sesiones) {
      if (sesion.estado != EstadoSesionEntrenamiento.activa) {
        continue;
      }

      if (sesionActiva == null ||
          sesion.fechaInicio.isAfter(sesionActiva.fechaInicio)) {
        sesionActiva = sesion;
      }
    }

    if (sesionActiva == null) {
      return null;
    }

    final registros = _loadSessionRegistrosSync(isar, sesionActiva.id);
    final todasLasSeries = isar.series.where().findAllSync();
    final seriesSesion = <Serie>[];

    for (final serie in todasLasSeries) {
      serie.sesion.loadSync();
      if (serie.sesion.value?.id != sesionActiva.id) {
        continue;
      }

      serie.ejercicio.loadSync();
      seriesSesion.add(serie);
    }

    seriesSesion.sort((a, b) => a.id.compareTo(b.id));
    return ActiveWorkoutState(
      sesion: sesionActiva,
      grupos: _groupsFromSeries(seriesSesion, registros),
    );
  }

  Map<int, RegistroEjercicioSesion> _loadSessionRegistrosSync(
    Isar isar,
    int sesionId,
  ) {
    final registros = isar.registrosEjercicioSesion.where().findAllSync();
    final result = <int, RegistroEjercicioSesion>{};
    for (final registro in registros) {
      registro.sesion.loadSync();
      if (registro.sesion.value?.id != sesionId) {
        continue;
      }

      registro.ejercicio.loadSync();
      final exerciseId = registro.ejercicio.value?.id;
      if (exerciseId != null) {
        result[exerciseId] = registro;
      }
    }
    return result;
  }

  Future<List<RutinaEjercicio>> _loadRoutineRelations(
    Isar isar,
    int rutinaId,
  ) async {
    final relations = await isar.rutinasEjercicio.where().findAll();
    final filtered = <RutinaEjercicio>[];
    for (final relation in relations) {
      await relation.rutina.load();
      if (relation.rutina.value?.id != rutinaId) {
        continue;
      }
      await relation.ejercicio.load();
      filtered.add(relation);
    }

    filtered.sort((a, b) => a.orden.compareTo(b.orden));
    return filtered;
  }

  List<WorkoutExerciseGroup> _groupsFromSeries(
    List<Serie> items,
    Map<int, RegistroEjercicioSesion> registros,
  ) {
    final order = <int>[];
    final exercises = <int, Ejercicio>{};
    final grouped = <int, List<Serie>>{};

    for (final serie in items) {
      final ejercicio = serie.ejercicio.value;
      if (ejercicio == null) {
        continue;
      }

      if (!grouped.containsKey(ejercicio.id)) {
        order.add(ejercicio.id);
        grouped[ejercicio.id] = <Serie>[];
        exercises[ejercicio.id] = ejercicio;
      }
      grouped[ejercicio.id]!.add(serie);
    }

    order.sort((left, right) {
      final leftOrder = registros[left]?.orden ?? 1 << 20;
      final rightOrder = registros[right]?.orden ?? 1 << 20;
      return leftOrder.compareTo(rightOrder);
    });

    return [
      for (final exerciseId in order)
        WorkoutExerciseGroup(
          ejercicio: exercises[exerciseId]!,
          series: grouped[exerciseId]!,
          registro:
              registros[exerciseId] ??
              RegistroEjercicioSesion(orden: order.indexOf(exerciseId)),
        ),
    ];
  }

  List<WorkoutExerciseGroup> _replaceSerie(
    List<WorkoutExerciseGroup> groups,
    Serie updatedSerie,
  ) {
    return [
      for (final group in groups)
        if (group.ejercicio.id != updatedSerie.ejercicio.value?.id)
          group
        else
          group.copyWith(
            series: [
              for (final serie in group.series)
                if (serie.id == updatedSerie.id) updatedSerie else serie,
            ],
          ),
    ];
  }

  int _resolveRestSeconds(Ejercicio ejercicio) {
    if (ejercicio.tipoEjercicio == TipoEjercicio.movilidad ||
        ejercicio.tipoEjercicio == TipoEjercicio.estiramiento) {
      return 30;
    }
    return ejercicio.tiempoDescansoBaseSegundos;
  }
}
