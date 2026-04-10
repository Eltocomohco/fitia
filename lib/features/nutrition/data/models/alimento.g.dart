// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alimento.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlimentoCollection on Isar {
  IsarCollection<Alimento> get alimentos => this.collection();
}

const AlimentoSchema = CollectionSchema(
  name: r'Alimento',
  id: 4440087674309768090,
  properties: {
    r'carbohidratos': PropertySchema(
      id: 0,
      name: r'carbohidratos',
      type: IsarType.double,
    ),
    r'externalId': PropertySchema(
      id: 1,
      name: r'externalId',
      type: IsarType.string,
    ),
    r'grasas': PropertySchema(id: 2, name: r'grasas', type: IsarType.double),
    r'grupos': PropertySchema(
      id: 3,
      name: r'grupos',
      type: IsarType.stringList,
    ),
    r'kcal': PropertySchema(id: 4, name: r'kcal', type: IsarType.double),
    r'nombre': PropertySchema(id: 5, name: r'nombre', type: IsarType.string),
    r'porcionBaseGramos': PropertySchema(
      id: 6,
      name: r'porcionBaseGramos',
      type: IsarType.double,
    ),
    r'proteinas': PropertySchema(
      id: 7,
      name: r'proteinas',
      type: IsarType.double,
    ),
    r'stockDisponibleGramos': PropertySchema(
      id: 8,
      name: r'stockDisponibleGramos',
      type: IsarType.double,
    ),
    r'stockPersonalDisponibleGramos': PropertySchema(
      id: 9,
      name: r'stockPersonalDisponibleGramos',
      type: IsarType.double,
    ),
  },

  estimateSize: _alimentoEstimateSize,
  serialize: _alimentoSerialize,
  deserialize: _alimentoDeserialize,
  deserializeProp: _alimentoDeserializeProp,
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
  links: {},
  embeddedSchemas: {},

  getId: _alimentoGetId,
  getLinks: _alimentoGetLinks,
  attach: _alimentoAttach,
  version: '3.3.2',
);

int _alimentoEstimateSize(
  Alimento object,
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
  bytesCount += 3 + object.grupos.length * 3;
  {
    for (var i = 0; i < object.grupos.length; i++) {
      final value = object.grupos[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _alimentoSerialize(
  Alimento object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.carbohidratos);
  writer.writeString(offsets[1], object.externalId);
  writer.writeDouble(offsets[2], object.grasas);
  writer.writeStringList(offsets[3], object.grupos);
  writer.writeDouble(offsets[4], object.kcal);
  writer.writeString(offsets[5], object.nombre);
  writer.writeDouble(offsets[6], object.porcionBaseGramos);
  writer.writeDouble(offsets[7], object.proteinas);
  writer.writeDouble(offsets[8], object.stockDisponibleGramos);
  writer.writeDouble(offsets[9], object.stockPersonalDisponibleGramos);
}

Alimento _alimentoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Alimento(
    carbohidratos: reader.readDouble(offsets[0]),
    externalId: reader.readStringOrNull(offsets[1]),
    grasas: reader.readDouble(offsets[2]),
    grupos: reader.readStringList(offsets[3]) ?? const [],
    id: id,
    kcal: reader.readDouble(offsets[4]),
    nombre: reader.readString(offsets[5]),
    porcionBaseGramos: reader.readDoubleOrNull(offsets[6]) ?? 100.0,
    proteinas: reader.readDouble(offsets[7]),
    stockDisponibleGramos: reader.readDoubleOrNull(offsets[8]) ?? 0.0,
    stockPersonalDisponibleGramos: reader.readDoubleOrNull(offsets[9]) ?? 0.0,
  );
  return object;
}

P _alimentoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? const []) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 100.0) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 9:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _alimentoGetId(Alimento object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _alimentoGetLinks(Alimento object) {
  return [];
}

void _alimentoAttach(IsarCollection<dynamic> col, Id id, Alimento object) {
  object.id = id;
}

extension AlimentoQueryWhereSort on QueryBuilder<Alimento, Alimento, QWhere> {
  QueryBuilder<Alimento, Alimento, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlimentoQueryWhere on QueryBuilder<Alimento, Alimento, QWhereClause> {
  QueryBuilder<Alimento, Alimento, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> idBetween(
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

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> externalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'externalId', value: [null]),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> externalIdIsNotNull() {
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

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> externalIdEqualTo(
    String? externalId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'externalId', value: [externalId]),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> externalIdNotEqualTo(
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

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> nombreEqualTo(
    String nombre,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'nombre', value: [nombre]),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterWhereClause> nombreNotEqualTo(
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

extension AlimentoQueryFilter
    on QueryBuilder<Alimento, Alimento, QFilterCondition> {
  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> carbohidratosEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'carbohidratos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  carbohidratosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'carbohidratos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> carbohidratosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'carbohidratos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> carbohidratosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'carbohidratos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'externalId'),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  externalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'externalId'),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdEqualTo(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdGreaterThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdLessThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdBetween(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdStartsWith(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdEndsWith(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdContains(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdMatches(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> externalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  externalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'externalId', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> grasasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grasas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> grasasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grasas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> grasasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grasas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> grasasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grasas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  gruposElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grupos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  gruposElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'grupos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'grupos',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  gruposElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'grupos', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  gruposElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'grupos', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'grupos', length, true, length, true);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'grupos', 0, true, 0, true);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'grupos', 0, false, 999999, true);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'grupos', 0, true, length, include);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  gruposLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'grupos', length, include, 999999, true);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> gruposLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'grupos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> kcalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'kcal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> kcalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'kcal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> kcalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'kcal',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> kcalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'kcal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreGreaterThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreStartsWith(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreEndsWith(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreContains(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreMatches(
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

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  porcionBaseGramosEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'porcionBaseGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  porcionBaseGramosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'porcionBaseGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  porcionBaseGramosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'porcionBaseGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  porcionBaseGramosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'porcionBaseGramos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> proteinasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'proteinas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> proteinasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'proteinas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> proteinasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'proteinas',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition> proteinasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'proteinas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockDisponibleGramosEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stockDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockDisponibleGramosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stockDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockDisponibleGramosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stockDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockDisponibleGramosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stockDisponibleGramos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockPersonalDisponibleGramosEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stockPersonalDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockPersonalDisponibleGramosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stockPersonalDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockPersonalDisponibleGramosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stockPersonalDisponibleGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterFilterCondition>
  stockPersonalDisponibleGramosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stockPersonalDisponibleGramos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension AlimentoQueryObject
    on QueryBuilder<Alimento, Alimento, QFilterCondition> {}

extension AlimentoQueryLinks
    on QueryBuilder<Alimento, Alimento, QFilterCondition> {}

extension AlimentoQuerySortBy on QueryBuilder<Alimento, Alimento, QSortBy> {
  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByPorcionBaseGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcionBaseGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByPorcionBaseGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcionBaseGramos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> sortByStockDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockDisponibleGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  sortByStockDisponibleGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockDisponibleGramos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  sortByStockPersonalDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockPersonalDisponibleGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  sortByStockPersonalDisponibleGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockPersonalDisponibleGramos', Sort.desc);
    });
  }
}

extension AlimentoQuerySortThenBy
    on QueryBuilder<Alimento, Alimento, QSortThenBy> {
  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcal', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByPorcionBaseGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcionBaseGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByPorcionBaseGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcionBaseGramos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy> thenByStockDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockDisponibleGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  thenByStockDisponibleGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockDisponibleGramos', Sort.desc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  thenByStockPersonalDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockPersonalDisponibleGramos', Sort.asc);
    });
  }

  QueryBuilder<Alimento, Alimento, QAfterSortBy>
  thenByStockPersonalDisponibleGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockPersonalDisponibleGramos', Sort.desc);
    });
  }
}

extension AlimentoQueryWhereDistinct
    on QueryBuilder<Alimento, Alimento, QDistinct> {
  QueryBuilder<Alimento, Alimento, QDistinct> distinctByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbohidratos');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByExternalId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grasas');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByGrupos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grupos');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kcal');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByPorcionBaseGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'porcionBaseGramos');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct> distinctByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinas');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct>
  distinctByStockDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stockDisponibleGramos');
    });
  }

  QueryBuilder<Alimento, Alimento, QDistinct>
  distinctByStockPersonalDisponibleGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stockPersonalDisponibleGramos');
    });
  }
}

extension AlimentoQueryProperty
    on QueryBuilder<Alimento, Alimento, QQueryProperty> {
  QueryBuilder<Alimento, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations> carbohidratosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbohidratos');
    });
  }

  QueryBuilder<Alimento, String?, QQueryOperations> externalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalId');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations> grasasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grasas');
    });
  }

  QueryBuilder<Alimento, List<String>, QQueryOperations> gruposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grupos');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations> kcalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kcal');
    });
  }

  QueryBuilder<Alimento, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations> porcionBaseGramosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'porcionBaseGramos');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations> proteinasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinas');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations>
  stockDisponibleGramosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stockDisponibleGramos');
    });
  }

  QueryBuilder<Alimento, double, QQueryOperations>
  stockPersonalDisponibleGramosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stockPersonalDisponibleGramos');
    });
  }
}
