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
    this.nombre = '',
    this.genero = '',
    this.objetivoPrincipal = '',
    this.pesoObjetivoKg,
    this.pesoObjetivoPlazoSemanas,
    this.hambreHabitual = '',
    this.saciedadComidas = '',
    this.saciedadDesayuno = '',
    this.saciedadComida = '',
    this.saciedadCena = '',
    this.suenoInicioMinutos,
    this.suenoFinMinutos,
    this.pasosDiarios = 0,
    this.adherenciaDietaSemanal = 0,
    this.adherenciaEntrenoSemanal = 0,
    this.digestion = '',
    this.alimentosQueSientanMal = '',
    this.preferenciasComida = '',
    this.estadoEmocionalComida = '',
  });

  /// Identificador fijo (siempre 1).
  Id id;

  /// Altura en centímetros.
  double alturaCm;

  /// Edad en años.
  int edad;

  /// Nombre del usuario para personalizar la conversación.
  String nombre;

  /// Género del usuario (opcional).
  String genero;

  /// Objetivo principal actual del usuario.
  String objetivoPrincipal;

  /// Peso objetivo en kg.
  double? pesoObjetivoKg;

  /// Horizonte deseado para alcanzar el peso objetivo, en semanas.
  int? pesoObjetivoPlazoSemanas;

  /// Nivel habitual de hambre percibida.
  String hambreHabitual;

  /// Percepción general de saciedad tras las comidas.
  String saciedadComidas;

  /// Sensación habitual tras el desayuno.
  String saciedadDesayuno;

  /// Sensación habitual tras la comida.
  String saciedadComida;

  /// Sensación habitual tras la cena.
  String saciedadCena;

  /// Hora de inicio del último sueño importado desde Health, en minutos desde medianoche.
  int? suenoInicioMinutos;

  /// Hora de fin del último sueño importado desde Health, en minutos desde medianoche.
  int? suenoFinMinutos;

  /// Pasos diarios sincronizados desde Health.
  int pasosDiarios;

  /// Adherencia semanal percibida a la dieta, de 0 a 100.
  int adherenciaDietaSemanal;

  /// Adherencia semanal percibida al entreno, de 0 a 100.
  int adherenciaEntrenoSemanal;

  /// Estado digestivo o molestias predominantes.
  String digestion;

  /// Alimentos o grupos que suelen sentar mal.
  String alimentosQueSientanMal;

  /// Preferencias fuertes de comida del usuario.
  String preferenciasComida;

  /// Estado emocional más frecuente al comer.
  String estadoEmocionalComida;
}
