// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receta.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecetaCollection on Isar {
  IsarCollection<Receta> get recetas => this.collection();
}

const RecetaSchema = CollectionSchema(
  name: r'Receta',
  id: 2389442207196209360,
  properties: {
    r'externalId': PropertySchema(
      id: 0,
      name: r'externalId',
      type: IsarType.string,
    ),
    r'instrucciones': PropertySchema(
      id: 1,
      name: r'instrucciones',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(id: 2, name: r'nombre', type: IsarType.string),
    r'numeroRaciones': PropertySchema(
      id: 3,
      name: r'numeroRaciones',
      type: IsarType.long,
    ),
  },

  estimateSize: _recetaEstimateSize,
  serialize: _recetaSerialize,
  deserialize: _recetaDeserialize,
  deserializeProp: _recetaDeserializeProp,
  idName: r'id',
  indexes: {
    r'externalId': IndexSchema(
      id: 8629824136592255998,
      name: r'externalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'externalId',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'nombre': IndexSchema(
      id: -8239814765453414572,
      name: r'nombre',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nombre',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'ingredientes': LinkSchema(
      id: -8663966304767973361,
      name: r'ingredientes',
      target: r'IngredienteReceta',
      single: false,
    ),
  },
  embeddedSchemas: {},

  getId: _recetaGetId,
  getLinks: _recetaGetLinks,
  attach: _recetaAttach,
  version: '3.3.2',
);

int _recetaEstimateSize(
  Receta object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.externalId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.instrucciones;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _recetaSerialize(
  Receta object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.externalId);
  writer.writeString(offsets[1], object.instrucciones);
  writer.writeString(offsets[2], object.nombre);
  writer.writeLong(offsets[3], object.numeroRaciones);
}

Receta _recetaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Receta(
    externalId: reader.readStringOrNull(offsets[0]),
    id: id,
    instrucciones: reader.readStringOrNull(offsets[1]),
    nombre: reader.readString(offsets[2]),
    numeroRaciones: reader.readLongOrNull(offsets[3]) ?? 1,
  );
  return object;
}

P _recetaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recetaGetId(Receta object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recetaGetLinks(Receta object) {
  return [object.ingredientes];
}

void _recetaAttach(IsarCollection<dynamic> col, Id id, Receta object) {
  object.id = id;
  object.ingredientes.attach(
    col,
    col.isar.collection<IngredienteReceta>(),
    r'ingredientes',
    id,
  );
}

extension RecetaQueryWhereSort on QueryBuilder<Receta, Receta, QWhere> {
  QueryBuilder<Receta, Receta, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecetaQueryWhere on QueryBuilder<Receta, Receta, QWhereClause> {
  QueryBuilder<Receta, Receta, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> externalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'externalId', value: [null]),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> externalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'externalId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> externalIdEqualTo(
    String? externalId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'externalId', value: [externalId]),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> externalIdNotEqualTo(
    String? externalId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId',
                lower: [],
                upper: [externalId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId',
                lower: [externalId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId',
                lower: [externalId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'externalId',
                lower: [],
                upper: [externalId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> nombreEqualTo(String nombre) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'nombre', value: [nombre]),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterWhereClause> nombreNotEqualTo(
    String nombre,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [],
                upper: [nombre],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [nombre],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [nombre],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [],
                upper: [nombre],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension RecetaQueryFilter on QueryBuilder<Receta, Receta, QFilterCondition> {
  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'externalId'),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'externalId'),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'externalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'externalId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'externalId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> externalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'instrucciones'),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'instrucciones'),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'instrucciones',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'instrucciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'instrucciones',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> instruccionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'instrucciones', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition>
  instruccionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'instrucciones', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nombre',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nombre',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> numeroRacionesEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numeroRaciones', value: value),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> numeroRacionesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numeroRaciones',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> numeroRacionesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numeroRaciones',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> numeroRacionesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numeroRaciones',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RecetaQueryObject on QueryBuilder<Receta, Receta, QFilterCondition> {}

extension RecetaQueryLinks on QueryBuilder<Receta, Receta, QFilterCondition> {
  QueryBuilder<Receta, Receta, QAfterFilterCondition> ingredientes(
    FilterQuery<IngredienteReceta> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ingredientes');
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> ingredientesLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ingredientes', length, true, length, true);
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> ingredientesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ingredientes', 0, true, 0, true);
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> ingredientesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ingredientes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition>
  ingredientesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ingredientes', 0, true, length, include);
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition>
  ingredientesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ingredientes', length, include, 999999, true);
    });
  }

  QueryBuilder<Receta, Receta, QAfterFilterCondition> ingredientesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'ingredientes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RecetaQuerySortBy on QueryBuilder<Receta, Receta, QSortBy> {
  QueryBuilder<Receta, Receta, QAfterSortBy> sortByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByInstrucciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrucciones', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByInstruccionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrucciones', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByNumeroRaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroRaciones', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> sortByNumeroRacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroRaciones', Sort.desc);
    });
  }
}

extension RecetaQuerySortThenBy on QueryBuilder<Receta, Receta, QSortThenBy> {
  QueryBuilder<Receta, Receta, QAfterSortBy> thenByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByInstrucciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrucciones', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByInstruccionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrucciones', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByNumeroRaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroRaciones', Sort.asc);
    });
  }

  QueryBuilder<Receta, Receta, QAfterSortBy> thenByNumeroRacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroRaciones', Sort.desc);
    });
  }
}

extension RecetaQueryWhereDistinct on QueryBuilder<Receta, Receta, QDistinct> {
  QueryBuilder<Receta, Receta, QDistinct> distinctByExternalId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Receta, Receta, QDistinct> distinctByInstrucciones({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'instrucciones',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Receta, Receta, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Receta, Receta, QDistinct> distinctByNumeroRaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroRaciones');
    });
  }
}

extension RecetaQueryProperty on QueryBuilder<Receta, Receta, QQueryProperty> {
  QueryBuilder<Receta, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Receta, String?, QQueryOperations> externalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalId');
    });
  }

  QueryBuilder<Receta, String?, QQueryOperations> instruccionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instrucciones');
    });
  }

  QueryBuilder<Receta, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<Receta, int, QQueryOperations> numeroRacionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroRaciones');
    });
  }
}
