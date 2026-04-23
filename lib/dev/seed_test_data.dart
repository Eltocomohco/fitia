import 'package:isar_community/isar.dart';
import '../features/nutrition/data/models/alimento.dart';
import '../features/nutrition/data/models/receta.dart';
import '../features/nutrition/data/models/ingrediente_receta.dart';
import '../features/progress/data/models/metrica_corporal.dart';
import '../features/tracking/data/models/perfil_usuario.dart';

Future<void> seedTestData(Isar isar) async {
  final alreadySeeded = await isar.alimentos.where().findFirst();
  if (alreadySeeded != null) {
    return;
  }

  // Alimentos
  final pollo = Alimento(
    nombre: 'Pechuga de pollo',
    kcal: 110,
    proteinas: 23.0,
    carbohidratos: 0.0,
    grasas: 1.5,
    porcionBaseGramos: 100,
    stockDisponibleGramos: 800,
    grupos: ['principal'],
  );
  final arroz = Alimento(
    nombre: 'Arroz blanco',
    kcal: 350,
    proteinas: 7.0,
    carbohidratos: 78.0,
    grasas: 0.6,
    porcionBaseGramos: 100,
    stockDisponibleGramos: 1000,
    grupos: ['principal'],
  );
  final brocoli = Alimento(
    nombre: 'Brócoli',
    kcal: 35,
    proteinas: 2.8,
    carbohidratos: 7.2,
    grasas: 0.4,
    porcionBaseGramos: 100,
    stockDisponibleGramos: 500,
    grupos: ['vegetal'],
  );
  final huevo = Alimento(
    nombre: 'Huevo',
    kcal: 150,
    proteinas: 13.0,
    carbohidratos: 1.1,
    grasas: 11.0,
    porcionBaseGramos: 60,
    stockDisponibleGramos: 360,
    grupos: ['principal'],
  );

  // Receta
  final receta = Receta(
    nombre: 'Pollo con arroz y brócoli',
    instrucciones: 'Cocinar el arroz, saltear el pollo y el brócoli juntos.',
    numeroRaciones: 2,
  );
  final ingPollo = IngredienteReceta(
    cantidadGramos: 200,
    grupo: GrupoComponenteReceta.principal,
  );
  ingPollo.alimento.value = pollo;
  final ingArroz = IngredienteReceta(
    cantidadGramos: 150,
    grupo: GrupoComponenteReceta.principal,
  );
  ingArroz.alimento.value = arroz;
  final ingBrocoli = IngredienteReceta(
    cantidadGramos: 100,
    grupo: GrupoComponenteReceta.vegetal,
  );
  ingBrocoli.alimento.value = brocoli;
  receta.ingredientes.addAll([ingPollo, ingArroz, ingBrocoli]);

  // Métricas corporales
  final metrica = MetricaCorporal(
    fecha: DateTime.now().subtract(const Duration(days: 1)),
    peso: 70.0,
    porcentajeGrasa: 18.0,
  );

  // Usuario
  final perfil = PerfilUsuario(
    nombre: 'Test User',
    edad: 30,
    genero: 'masculino',
    alturaCm: 175.0,
    pesoObjetivoKg: 68.0,
    preferenciasComida: 'sin lactosa',
    adherenciaDietaSemanal: 80,
    adherenciaEntrenoSemanal: 90,
    pasosDiarios: 8000,
    objetivoPrincipal: 'Definición',
    digestion: 'Normal',
    hambreHabitual: 'Media',
    saciedadComidas: 'Buena',
    saciedadDesayuno: 'Media',
    saciedadComida: 'Alta',
    saciedadCena: 'Media',
    alimentosQueSientanMal: 'Ninguno',
    estadoEmocionalComida: 'Normal',
    suenoInicioMinutos: 1380,
    suenoFinMinutos: 420,
  );

  await isar.writeTxn(() async {
    await isar.alimentos.putAll([pollo, arroz, brocoli, huevo]);

    await isar.ingredientesReceta.putAll([ingPollo, ingArroz, ingBrocoli]);
    await ingPollo.alimento.save();
    await ingArroz.alimento.save();
    await ingBrocoli.alimento.save();

    receta.ingredientes.addAll([ingPollo, ingArroz, ingBrocoli]);
    await isar.recetas.put(receta);
    await receta.ingredientes.save();

    await isar.metricasCorporales.put(metrica);
    await isar.perfilesUsuario.put(perfil);
  });
}
