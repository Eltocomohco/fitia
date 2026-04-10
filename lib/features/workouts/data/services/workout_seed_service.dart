import 'package:isar_community/isar.dart';

import '../models/ejercicio.dart';

/// Servicio de inicialización de ejercicios base del módulo Workouts.
abstract final class WorkoutSeedService {
  /// Inserta ejercicios por defecto si la base de datos aún no tiene ninguno.
  static Future<void> seedExercisesIfEmpty(Isar isar) async {
    final existentes = await isar.ejercicios.where().findAll();
    final existentesPorNombre = <String, Ejercicio>{
      for (final ejercicio in existentes)
        ejercicio.nombre.toLowerCase(): ejercicio,
    };
    final catalogo = _masterCatalog();
    final pendientes = <Ejercicio>[];

    for (final candidato in catalogo) {
      final key = candidato.nombre.toLowerCase();
      final existente = existentesPorNombre[key];
      if (existente == null) {
        pendientes.add(candidato);
        continue;
      }

      var actualizado = false;
      if (existente.grupoMuscular != candidato.grupoMuscular) {
        existente.grupoMuscular = candidato.grupoMuscular;
        actualizado = true;
      }
      if (existente.tiempoDescansoBaseSegundos !=
          candidato.tiempoDescansoBaseSegundos) {
        existente.tiempoDescansoBaseSegundos =
            candidato.tiempoDescansoBaseSegundos;
        actualizado = true;
      }
      if (existente.descripcionBreve != candidato.descripcionBreve) {
        existente.descripcionBreve = candidato.descripcionBreve;
        actualizado = true;
      }
      if (existente.tipoEjercicio != candidato.tipoEjercicio) {
        existente.tipoEjercicio = candidato.tipoEjercicio;
        actualizado = true;
      }
      if (actualizado) {
        pendientes.add(existente);
      }
    }

    if (pendientes.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.ejercicios.putAll(pendientes);
    });
  }

  static List<Ejercicio> _masterCatalog() {
    return <Ejercicio>[
      _fuerzaCompuesto('Press banca plano', 'Pecho'),
      _fuerzaCompuesto('Press inclinado con mancuernas', 'Pecho'),
      _fuerzaCompuesto('Fondos en paralelas', 'Pecho'),
      _fuerzaAislado('Aperturas con mancuernas', 'Pecho'),
      _fuerzaAislado('Cruce de poleas', 'Pecho'),
      _fuerzaAislado('Pullover con mancuerna', 'Pecho'),
      _fuerzaCompuesto('Press Militar', 'Hombro'),
      _fuerzaAislado('Elevaciones Laterales', 'Hombro'),
      _fuerzaCompuesto('Press Arnold', 'Hombro'),
      _fuerzaAislado('Face-Pulls', 'Hombro'),
      _fuerzaAislado('Pájaros', 'Hombro'),
      _fuerzaCompuesto('Remo al mentón', 'Hombro'),
      _fuerzaCompuesto('Dominadas pronas', 'Espalda'),
      _fuerzaCompuesto('Remo con barra', 'Espalda'),
      _fuerzaCompuesto('Jalon al pecho', 'Espalda'),
      _fuerzaAislado('Remo en polea baja', 'Espalda'),
      _fuerzaAislado('Pullover en polea', 'Espalda'),
      _fuerzaAislado('Face pull', 'Espalda'),
      _movilidad(
        'Gato-Camello',
        'Espalda',
        'Alterna arqueando y redondeando la espalda para activar la columna antes de tirar.',
      ),
      _fuerzaCompuesto('Sentadilla trasera', 'Pierna'),
      _fuerzaCompuesto('Prensa de piernas', 'Pierna'),
      _fuerzaCompuesto('Peso muerto rumano', 'Pierna'),
      _fuerzaCompuesto('Zancadas caminando', 'Pierna'),
      _fuerzaAislado('Curl femoral tumbado', 'Pierna'),
      _fuerzaAislado('Extension de cuadriceps', 'Pierna'),
      _movilidad(
        'Aperturas de cadera 90-90',
        'Pierna',
        'Cambia de un lado al otro con control para abrir cadera y preparar gluteos y femorales.',
      ),
      _fuerzaCompuesto('Curl con barra', 'Brazo'),
      _fuerzaCompuesto('Press cerrado', 'Brazo'),
      _fuerzaAislado('Curl inclinado con mancuernas', 'Brazo'),
      _fuerzaAislado('Curl martillo', 'Brazo'),
      _fuerzaAislado('Extension de triceps en polea', 'Brazo'),
      _fuerzaAislado('Extension francesa', 'Brazo'),
      _fuerzaCompuesto('Rueda abdominal', 'Core'),
      _fuerzaCompuesto('Elevaciones de piernas colgado', 'Core'),
      _fuerzaAislado('Crunch en polea', 'Core'),
      _fuerzaAislado('Plancha frontal', 'Core'),
      _fuerzaAislado('Plancha lateral', 'Core'),
      _fuerzaAislado('Dead bug', 'Core'),
      _movilidad(
        'Dislocaciones de hombro',
        'Torso',
        'Pasa una banda o toalla por encima de la cabeza y detras del cuerpo sin perder control del hombro.',
      ),
      _estiramiento(
        'Pectoral en puerta',
        'Pecho',
        'Apoya el antebrazo en el marco, abre el pecho y mantén una tension suave sin dolor.',
      ),
      _estiramiento(
        'Isquiotibiales con banda',
        'Pierna',
        'Tumbándote boca arriba, eleva una pierna con ayuda de una banda hasta notar el estiramiento posterior.',
      ),
      _estiramiento(
        'Cobra',
        'Espalda',
        'Empuja el suelo con las manos para extender la espalda y abrir la parte frontal del torso.',
      ),
    ];
  }

  static Ejercicio _fuerzaCompuesto(String nombre, String grupoMuscular) {
    return Ejercicio(
      nombre: nombre,
      grupoMuscular: grupoMuscular,
      tiempoDescansoBaseSegundos: 90,
      tipoEjercicio: TipoEjercicio.fuerza,
    );
  }

  static Ejercicio _fuerzaAislado(String nombre, String grupoMuscular) {
    return Ejercicio(
      nombre: nombre,
      grupoMuscular: grupoMuscular,
      tiempoDescansoBaseSegundos: 60,
      tipoEjercicio: TipoEjercicio.fuerza,
    );
  }

  static Ejercicio _movilidad(
    String nombre,
    String grupoMuscular,
    String descripcionBreve,
  ) {
    return Ejercicio(
      nombre: nombre,
      grupoMuscular: grupoMuscular,
      tiempoDescansoBaseSegundos: 30,
      descripcionBreve: descripcionBreve,
      tipoEjercicio: TipoEjercicio.movilidad,
    );
  }

  static Ejercicio _estiramiento(
    String nombre,
    String grupoMuscular,
    String descripcionBreve,
  ) {
    return Ejercicio(
      nombre: nombre,
      grupoMuscular: grupoMuscular,
      tiempoDescansoBaseSegundos: 30,
      descripcionBreve: descripcionBreve,
      tipoEjercicio: TipoEjercicio.estiramiento,
    );
  }
}
