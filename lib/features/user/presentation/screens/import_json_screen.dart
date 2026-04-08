import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/ingrediente_receta.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../recipes/presentation/providers/recipe_provider.dart';

/// Pantalla para importar alimentos y recetas desde JSON.
class ImportJsonScreen extends ConsumerStatefulWidget {
  /// Crea un [ImportJsonScreen].
  const ImportJsonScreen({super.key});

  @override
  ConsumerState<ImportJsonScreen> createState() => _ImportJsonScreenState();
}

class _ImportJsonScreenState extends ConsumerState<ImportJsonScreen> {
  final _controller = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _import() async {
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      return;
    }

    setState(() => _loading = true);
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('JSON inválido');
      }

      final alimentosJson = (decoded['alimentos'] as List?) ?? const [];
      final recetasJson = (decoded['recetas'] as List?) ?? const [];

      final isar = ref.read(inventoryIsarProvider);
      final foodsByName = <String, Alimento>{};
      final foodsByExternalId = <String, Alimento>{};
      final recipesByName = <String, Receta>{};
      final recipesByExternalId = <String, Receta>{};

      final existingFoods = await isar.alimentos.where().findAll();
      for (final food in existingFoods) {
        foodsByName[food.nombre.trim().toLowerCase()] = food;
        final ext = food.externalId?.trim();
        if (ext != null && ext.isNotEmpty) {
          foodsByExternalId[ext] = food;
        }
      }

      final existingRecipes = await isar.recetas.where().findAll();
      for (final recipe in existingRecipes) {
        recipesByName[recipe.nombre.trim().toLowerCase()] = recipe;
        final ext = recipe.externalId?.trim();
        if (ext != null && ext.isNotEmpty) {
          recipesByExternalId[ext] = recipe;
        }
      }

      final issues = <String>[];
      final foodDrafts = <_FoodDraft>[];
      final recipeDrafts = <_RecipeDraft>[];

      final payloadFoodExternalIds = <String>{};
      final payloadFoodNames = <String>{};
      final payloadRecipeExternalIds = <String>{};

      for (var i = 0; i < alimentosJson.length; i++) {
        final row = alimentosJson[i];
        final path = 'alimentos[$i]';
        if (row is! Map) {
          issues.add('$path: formato inválido');
          continue;
        }

        final id = (row['id'] ?? row['idExterno'] ?? '').toString().trim();
        final name = (row['nombre'] ?? '').toString().trim();
        final line = _lineFor(raw, id.isNotEmpty ? id : name);

        if (name.isEmpty) {
          issues.add(_issue(path, line, 'falta "nombre"'));
          continue;
        }

        final kcal = _num(row['kcal']);
        final p = _num(row['proteinas']);
        final c = _num(row['carbohidratos']);
        final g = _num(row['grasas']);
        final base = _num(row['porcionBaseGramos']) ?? 100;
        final groups = _parseFoodGroups(row['grupos']);

        if (kcal == null || p == null || c == null || g == null) {
          issues.add(
            _issue(
              path,
              line,
              'macros inválidos (kcal/proteinas/carbohidratos/grasas)',
            ),
          );
          continue;
        }
        if (kcal < 0 || p < 0 || c < 0 || g < 0 || base <= 0) {
          issues.add(
            _issue(path, line, 'valores negativos o porción base <= 0'),
          );
          continue;
        }

        final nameKey = name.toLowerCase();
        if (payloadFoodNames.contains(nameKey)) {
          issues.add(
            _issue(path, line, 'nombre de alimento duplicado en JSON'),
          );
          continue;
        }
        payloadFoodNames.add(nameKey);

        if (id.isNotEmpty) {
          if (payloadFoodExternalIds.contains(id)) {
            issues.add(
              _issue(path, line, 'id externo de alimento duplicado en JSON'),
            );
            continue;
          }
          payloadFoodExternalIds.add(id);
        }

        foodDrafts.add(
          _FoodDraft(
            externalId: id,
            nombre: name,
            kcal: kcal,
            proteinas: p,
            carbohidratos: c,
            grasas: g,
            porcionBaseGramos: base,
            grupos: groups,
          ),
        );
      }

      final knownFoodIds = {
        ...foodsByExternalId.keys,
        ...payloadFoodExternalIds,
      };
      final knownFoodNames = {...foodsByName.keys, ...payloadFoodNames};

      for (var i = 0; i < recetasJson.length; i++) {
        final row = recetasJson[i];
        final path = 'recetas[$i]';
        if (row is! Map) {
          issues.add('$path: formato inválido');
          continue;
        }

        final id = (row['id'] ?? row['idExterno'] ?? '').toString().trim();
        final name = (row['nombre'] ?? '').toString().trim();
        final line = _lineFor(raw, id.isNotEmpty ? id : name);

        if (name.isEmpty) {
          issues.add(_issue(path, line, 'falta "nombre"'));
          continue;
        }

        if (id.isNotEmpty) {
          if (payloadRecipeExternalIds.contains(id)) {
            issues.add(
              _issue(path, line, 'id externo de receta duplicado en JSON'),
            );
            continue;
          }
          payloadRecipeExternalIds.add(id);
        }

        final raciones = ((row['numeroRaciones'] as num?)?.toInt() ?? 1).clamp(
          1,
          1000,
        );
        final ingredientes = (row['ingredientes'] as List?) ?? const [];
        if (ingredientes.isEmpty) {
          issues.add(_issue(path, line, 'la receta no tiene ingredientes'));
          continue;
        }

        final ingDrafts = <_IngredientDraft>[];
        for (var j = 0; j < ingredientes.length; j++) {
          final ingRaw = ingredientes[j];
          final ingPath = '$path.ingredientes[$j]';
          if (ingRaw is! Map) {
            issues.add('$ingPath: formato inválido');
            continue;
          }

          final foodExternalId = (ingRaw['alimentoId'] ?? '').toString().trim();
          final foodName = (ingRaw['alimento'] ?? '').toString().trim();
          final grams = _num(ingRaw['cantidadGramos']);
          final rawGroup = (ingRaw['grupo'] ?? '').toString().trim();
          final group = rawGroup.isEmpty
              ? GrupoComponenteReceta.principal
              : _parseGrupo(rawGroup);
          final ingLine = _lineFor(
            raw,
            foodExternalId.isNotEmpty ? foodExternalId : foodName,
          );

          if (foodExternalId.isEmpty && foodName.isEmpty) {
            issues.add(
              _issue(ingPath, ingLine, 'falta "alimentoId" o "alimento"'),
            );
            continue;
          }
          if (grams == null || grams <= 0) {
            issues.add(_issue(ingPath, ingLine, '"cantidadGramos" inválida'));
            continue;
          }
          if (group == null) {
            issues.add(
              _issue(
                ingPath,
                ingLine,
                '"grupo" inválido (usa: principal, vegetal, anadido)',
              ),
            );
            continue;
          }

          if (foodExternalId.isNotEmpty &&
              !knownFoodIds.contains(foodExternalId)) {
            issues.add(
              _issue(ingPath, ingLine, 'alimentoId no existe: $foodExternalId'),
            );
            continue;
          }
          if (foodExternalId.isEmpty &&
              !knownFoodNames.contains(foodName.toLowerCase())) {
            issues.add(
              _issue(ingPath, ingLine, 'alimento no existe: $foodName'),
            );
            continue;
          }

          ingDrafts.add(
            _IngredientDraft(
              alimentoId: foodExternalId,
              alimentoNombre: foodName,
              cantidadGramos: grams,
              grupo: group,
            ),
          );
        }

        if (ingDrafts.isEmpty) {
          issues.add(_issue(path, line, 'sin ingredientes válidos'));
          continue;
        }

        recipeDrafts.add(
          _RecipeDraft(
            externalId: id,
            nombre: name,
            numeroRaciones: raciones,
            ingredientes: ingDrafts,
          ),
        );
      }

      if (issues.isNotEmpty) {
        if (mounted) {
          await _showIssuesDialog(context, issues);
        }
        return;
      }

      var foodsCreated = 0;
      var foodsUpdated = 0;
      var recipesCreated = 0;
      var recipesUpdated = 0;

      await isar.writeTxn(() async {
        for (final draft in foodDrafts) {
          final existing = draft.externalId.isNotEmpty
              ? foodsByExternalId[draft.externalId]
              : foodsByName[draft.nombre.toLowerCase()];

          final food =
              existing ??
              Alimento(
                nombre: draft.nombre,
                kcal: draft.kcal,
                proteinas: draft.proteinas,
                carbohidratos: draft.carbohidratos,
                grasas: draft.grasas,
                porcionBaseGramos: draft.porcionBaseGramos,
                grupos: draft.grupos,
              );

          food.externalId = draft.externalId.isEmpty ? null : draft.externalId;
          food.nombre = draft.nombre;
          food.kcal = draft.kcal;
          food.proteinas = draft.proteinas;
          food.carbohidratos = draft.carbohidratos;
          food.grasas = draft.grasas;
          food.porcionBaseGramos = draft.porcionBaseGramos;
          food.grupos = draft.grupos;

          food.id = await isar.alimentos.put(food);
          foodsByName[draft.nombre.toLowerCase()] = food;
          if (food.externalId != null && food.externalId!.isNotEmpty) {
            foodsByExternalId[food.externalId!] = food;
          }

          if (existing == null) {
            foodsCreated++;
          } else {
            foodsUpdated++;
          }
        }

        for (final draft in recipeDrafts) {
          final existing = draft.externalId.isNotEmpty
              ? recipesByExternalId[draft.externalId]
              : recipesByName[draft.nombre.toLowerCase()];

          final receta =
              existing ??
              Receta(
                nombre: draft.nombre,
                numeroRaciones: draft.numeroRaciones,
              );

          receta.externalId = draft.externalId.isEmpty
              ? null
              : draft.externalId;
          receta.nombre = draft.nombre;
          receta.numeroRaciones = draft.numeroRaciones;
          receta.id = await isar.recetas.put(receta);

          if (existing != null) {
            await receta.ingredientes.load();
            final oldIds = receta.ingredientes.map((e) => e.id).toList();
            await receta.ingredientes.reset();
            if (oldIds.isNotEmpty) {
              await isar.ingredientesReceta.deleteAll(oldIds);
            }
          }

          for (final ing in draft.ingredientes) {
            final food = ing.alimentoId.isNotEmpty
                ? foodsByExternalId[ing.alimentoId]
                : foodsByName[ing.alimentoNombre.toLowerCase()];
            if (food == null) {
              continue;
            }

            final ingrediente = IngredienteReceta(
              cantidadGramos: ing.cantidadGramos,
              grupo: ing.grupo,
            );
            ingrediente.alimento.value = food;
            ingrediente.id = await isar.ingredientesReceta.put(ingrediente);
            await ingrediente.alimento.save();
            receta.ingredientes.add(ingrediente);
          }

          await receta.ingredientes.save();

          recipesByName[draft.nombre.toLowerCase()] = receta;
          if (receta.externalId != null && receta.externalId!.isNotEmpty) {
            recipesByExternalId[receta.externalId!] = receta;
          }

          if (existing == null) {
            recipesCreated++;
          } else {
            recipesUpdated++;
          }
        }
      });

      ref.invalidate(inventoryProvider);
      ref.invalidate(recipeListProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Importación lista · Alimentos +$foodsCreated / ↻$foodsUpdated · Recetas +$recipesCreated / ↻$recipesUpdated',
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error al importar JSON')));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Importar JSON')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Modo PRO: upsert por id externo, sin duplicados y validación previa.',
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '{"alimentos": [...], "recetas": [...]}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : _import,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.file_upload_outlined),
                label: Text(_loading ? 'Importando...' : 'Importar JSON'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double? _num(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value.replaceAll(',', '.'));
  }
  return null;
}

List<String> _parseFoodGroups(Object? raw) {
  if (raw is! List) {
    return const [];
  }
  final valid = {'principal', 'vegetal', 'anadido', 'añadido'};
  final output = <String>{};
  for (final item in raw) {
    final value = item.toString().trim().toLowerCase();
    if (!valid.contains(value)) {
      continue;
    }
    output.add(value == 'añadido' ? 'anadido' : value);
  }
  return output.toList();
}

GrupoComponenteReceta? _parseGrupo(String raw) {
  switch (raw.trim().toLowerCase()) {
    case 'principal':
      return GrupoComponenteReceta.principal;
    case 'vegetal':
      return GrupoComponenteReceta.vegetal;
    case 'anadido':
    case 'añadido':
    case 'extra':
      return GrupoComponenteReceta.anadido;
    default:
      return null;
  }
}

int? _lineFor(String raw, String token) {
  if (token.isEmpty) {
    return null;
  }
  final i = raw.indexOf(token);
  if (i < 0) {
    return null;
  }
  return '\n'.allMatches(raw.substring(0, i)).length + 1;
}

String _issue(String path, int? line, String message) {
  if (line == null) {
    return '$path: $message';
  }
  return 'Línea ~$line · $path: $message';
}

Future<void> _showIssuesDialog(BuildContext context, List<String> issues) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Errores de validación'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(child: SelectableText(issues.join('\n'))),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

class _FoodDraft {
  const _FoodDraft({
    required this.externalId,
    required this.nombre,
    required this.kcal,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    required this.porcionBaseGramos,
    required this.grupos,
  });

  final String externalId;
  final String nombre;
  final double kcal;
  final double proteinas;
  final double carbohidratos;
  final double grasas;
  final double porcionBaseGramos;
  final List<String> grupos;
}

class _RecipeDraft {
  const _RecipeDraft({
    required this.externalId,
    required this.nombre,
    required this.numeroRaciones,
    required this.ingredientes,
  });

  final String externalId;
  final String nombre;
  final int numeroRaciones;
  final List<_IngredientDraft> ingredientes;
}

class _IngredientDraft {
  const _IngredientDraft({
    required this.alimentoId,
    required this.alimentoNombre,
    required this.cantidadGramos,
    required this.grupo,
  });

  final String alimentoId;
  final String alimentoNombre;
  final double cantidadGramos;
  final GrupoComponenteReceta grupo;
}
