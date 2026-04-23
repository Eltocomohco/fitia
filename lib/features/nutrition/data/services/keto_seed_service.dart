import 'package:isar_community/isar.dart';
import '../models/alimento.dart';

abstract final class KetoSeedService {
  static Future<int> seedKetoFoods(Isar isar) async {
    final existing = await isar.alimentos.where().count();
    // No bloqueamos si ya hay datos, simplemente añadimos si no existen por nombre
    
    final ketoFoods = [
      Alimento(nombre: 'Aceite de Oliva Virgen Extra', kcal: 884, proteinas: 0, carbohidratos: 0, grasas: 100, grupos: ['anadido']),
      Alimento(nombre: 'Aceite de Coco', kcal: 862, proteinas: 0, carbohidratos: 0, grasas: 100, grupos: ['anadido']),
      Alimento(nombre: 'Mantequilla', kcal: 717, proteinas: 0.8, carbohidratos: 0.1, grasas: 81, grupos: ['anadido']),
      Alimento(nombre: 'Aguacate', kcal: 160, proteinas: 2, carbohidratos: 8.5, grasas: 15, grupos: ['vegetal']),
      Alimento(nombre: 'Huevo (Grande)', kcal: 155, proteinas: 13, carbohidratos: 1.1, grasas: 11, porcionBaseGramos: 50, grupos: ['principal']),
      Alimento(nombre: 'Panceta de Cerdo', kcal: 541, proteinas: 9, carbohidratos: 0, grasas: 53, grupos: ['principal']),
      Alimento(nombre: 'Salmón', kcal: 208, proteinas: 20, carbohidratos: 0, grasas: 13, grupos: ['principal']),
      Alimento(nombre: 'Entrecot de Ternera', kcal: 250, proteinas: 26, carbohidratos: 0, grasas: 15, grupos: ['principal']),
      Alimento(nombre: 'Pechuga de Pollo con Piel', kcal: 197, proteinas: 30, carbohidratos: 0, grasas: 8, grupos: ['principal']),
      Alimento(nombre: 'Nueces de Macadamia', kcal: 718, proteinas: 8, carbohidratos: 14, grasas: 76, grupos: ['anadido']),
      Alimento(nombre: 'Nueces', kcal: 654, proteinas: 15, carbohidratos: 14, grasas: 65, grupos: ['anadido']),
      Alimento(nombre: 'Almendras', kcal: 579, proteinas: 21, carbohidratos: 22, grasas: 50, grupos: ['anadido']),
      Alimento(nombre: 'Queso Manchego Curado', kcal: 450, proteinas: 25, carbohidratos: 0.5, grasas: 38, grupos: ['principal', 'anadido']),
      Alimento(nombre: 'Queso Brie', kcal: 334, proteinas: 21, carbohidratos: 0.5, grasas: 28, grupos: ['anadido']),
      Alimento(nombre: 'Espinacas Frescas', kcal: 23, proteinas: 2.9, carbohidratos: 3.6, grasas: 0.4, grupos: ['vegetal']),
      Alimento(nombre: 'Brócoli', kcal: 34, proteinas: 2.8, carbohidratos: 6.6, grasas: 0.4, grupos: ['vegetal']),
      Alimento(nombre: 'Coliflor', kcal: 25, proteinas: 1.9, carbohidratos: 5, grasas: 0.3, grupos: ['vegetal']),
      Alimento(nombre: 'Calabacín', kcal: 17, proteinas: 1.2, carbohidratos: 3.1, grasas: 0.3, grupos: ['vegetal']),
      Alimento(nombre: 'Espárragos Trigueros', kcal: 20, proteinas: 2.2, carbohidratos: 3.9, grasas: 0.1, grupos: ['vegetal']),
      Alimento(nombre: 'Atún en Aceite de Oliva (Escurrido)', kcal: 198, proteinas: 29, carbohidratos: 0, grasas: 9, grupos: ['principal']),
      Alimento(nombre: 'Sardinas en Aceite de Oliva', kcal: 208, proteinas: 25, carbohidratos: 0, grasas: 12, grupos: ['principal']),
      Alimento(nombre: 'Aceitunas Verdes', kcal: 145, proteinas: 1, carbohidratos: 4, grasas: 15, grupos: ['anadido']),
      Alimento(nombre: 'Mayonesa Casera', kcal: 680, proteinas: 1, carbohidratos: 1, grasas: 75, grupos: ['anadido']),
      Alimento(nombre: 'Nata para Montar (35% MG)', kcal: 340, proteinas: 2, carbohidratos: 3, grasas: 35, grupos: ['anadido']),
      Alimento(nombre: 'Muslo de Pollo con Piel', kcal: 210, proteinas: 24, carbohidratos: 0, grasas: 12, grupos: ['principal']),
      Alimento(nombre: 'Carne Picada de Ternera (20% grasa)', kcal: 250, proteinas: 26, carbohidratos: 0, grasas: 20, grupos: ['principal']),
      Alimento(nombre: 'Lomo Embuchado', kcal: 255, proteinas: 32, carbohidratos: 1, grasas: 14, grupos: ['principal']),
      Alimento(nombre: 'Jamón Ibérico', kcal: 375, proteinas: 30, carbohidratos: 0, grasas: 28, grupos: ['principal']),
      Alimento(nombre: 'Anchoas en Aceite', kcal: 210, proteinas: 28, carbohidratos: 0, grasas: 10, grupos: ['anadido']),
      Alimento(nombre: 'Pepino', kcal: 15, proteinas: 0.7, carbohidratos: 3.6, grasas: 0.1, grupos: ['vegetal']),
      Alimento(nombre: 'Pimiento Verde', kcal: 20, proteinas: 0.9, carbohidratos: 4.6, grasas: 0.2, grupos: ['vegetal']),
      Alimento(nombre: 'Lechuga Iceberg', kcal: 14, proteinas: 0.9, carbohidratos: 3, grasas: 0.1, grupos: ['vegetal']),
    ];

    var added = 0;
    await isar.writeTxn(() async {
      for (final food in ketoFoods) {
        final exists = await isar.alimentos.filter().nombreEqualTo(food.nombre).findFirst();
        if (exists == null) {
          await isar.alimentos.put(food);
          added++;
        }
      }
    });
    
    return added;
  }
}
