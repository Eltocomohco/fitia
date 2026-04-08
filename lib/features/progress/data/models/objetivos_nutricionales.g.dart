// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objetivos_nutricionales.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetObjetivosNutricionalesCollection on Isar {
  IsarCollection<ObjetivosNutricionales> get objetivosNutricionales =>
      this.collection();
}

const ObjetivosNutricionalesSchema = CollectionSchema(
  name: r'ObjetivosNutricionales',
  id: 8629390109351652838,
  properties: {
    r'aguaObjetivoMl': PropertySchema(
      id: 0,
      name: r'aguaObjetivoMl',
      type: IsarType.double,
    ),
    r'carbohidratosObjetivo': PropertySchema(
      id: 1,
      name: r'carbohidratosObjetivo',
      type: IsarType.double,
    ),
    r'grasasObjetivo': PropertySchema(
      id: 2,
      name: r'grasasObjetivo',
      type: IsarType.double,
    ),
    r'kcalObjetivo': PropertySchema(
      id: 3,
      name: r'kcalObjetivo',
      type: IsarType.double,
    ),
    r'proteinasObjetivo': PropertySchema(
      id: 4,
      name: r'proteinasObjetivo',
      type: IsarType.double,
    ),
  },

  estimateSize: _objetivosNutricionalesEstimateSize,
  serialize: _objetivosNutricionalesSerialize,
  deserialize: _objetivosNutricionalesDeserialize,
  deserializeProp: _objetivosNutricionalesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _objetivosNutricionalesGetId,
  getLinks: _objetivosNutricionalesGetLinks,
  attach: _objetivosNutricionalesAttach,
  version: '3.3.2',
);

int _objetivosNutricionalesEstimateSize(
  ObjetivosNutricionales object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _objetivosNutricionalesSerialize(
  ObjetivosNutricionales object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.aguaObjetivoMl);
  writer.writeDouble(offsets[1], object.carbohidratosObjetivo);
  writer.writeDouble(offsets[2], object.grasasObjetivo);
  writer.writeDouble(offsets[3], object.kcalObjetivo);
  writer.writeDouble(offsets[4], object.proteinasObjetivo);
}

ObjetivosNutricionales _objetivosNutricionalesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ObjetivosNutricionales(
    aguaObjetivoMl: reader.readDoubleOrNull(offsets[0]) ?? 2500,
    carbohidratosObjetivo: reader.readDoubleOrNull(offsets[1]) ?? 25,
    grasasObjetivo: reader.readDoubleOrNull(offsets[2]) ?? 140,
    id: id,
    kcalObjetivo: reader.readDoubleOrNull(offsets[3]) ?? 2000,
    proteinasObjetivo: reader.readDoubleOrNull(offsets[4]) ?? 150,
  );
  return object;
}

P _objetivosNutricionalesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 2500) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 25) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 140) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 2000) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 150) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _objetivosNutricionalesGetId(ObjetivosNutricionales object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _objetivosNutricionalesGetLinks(
  ObjetivosNutricionales object,
) {
  return [];
}

void _objetivosNutricionalesAttach(
  IsarCollection<dynamic> col,
  Id id,
  ObjetivosNutricionales object,
) {
  object.id = id;
}

extension ObjetivosNutricionalesQueryWhereSort
    on QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QWhere> {
  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ObjetivosNutricionalesQueryWhere
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QWhereClause
        > {
  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
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

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterWhereClause
  >
  idBetween(
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
}

extension ObjetivosNutricionalesQueryFilter
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QFilterCondition
        > {
  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  aguaObjetivoMlEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'aguaObjetivoMl',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  aguaObjetivoMlGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'aguaObjetivoMl',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  aguaObjetivoMlLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'aguaObjetivoMl',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  aguaObjetivoMlBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'aguaObjetivoMl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  carbohidratosObjetivoEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'carbohidratosObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  carbohidratosObjetivoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'carbohidratosObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  carbohidratosObjetivoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'carbohidratosObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  carbohidratosObjetivoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'carbohidratosObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  grasasObjetivoEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grasasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  grasasObjetivoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grasasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  grasasObjetivoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grasasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  grasasObjetivoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grasasObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  idBetween(
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

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  kcalObjetivoEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'kcalObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  kcalObjetivoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'kcalObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  kcalObjetivoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'kcalObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  kcalObjetivoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'kcalObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  proteinasObjetivoEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'proteinasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  proteinasObjetivoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'proteinasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  proteinasObjetivoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'proteinasObjetivo',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    ObjetivosNutricionales,
    ObjetivosNutricionales,
    QAfterFilterCondition
  >
  proteinasObjetivoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'proteinasObjetivo',
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

extension ObjetivosNutricionalesQueryObject
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QFilterCondition
        > {}

extension ObjetivosNutricionalesQueryLinks
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QFilterCondition
        > {}

extension ObjetivosNutricionalesQuerySortBy
    on QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QSortBy> {
  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByAguaObjetivoMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aguaObjetivoMl', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByAguaObjetivoMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aguaObjetivoMl', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByCarbohidratosObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratosObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByCarbohidratosObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratosObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByGrasasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByGrasasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByKcalObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcalObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByKcalObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcalObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByProteinasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  sortByProteinasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinasObjetivo', Sort.desc);
    });
  }
}

extension ObjetivosNutricionalesQuerySortThenBy
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QSortThenBy
        > {
  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByAguaObjetivoMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aguaObjetivoMl', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByAguaObjetivoMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aguaObjetivoMl', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByCarbohidratosObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratosObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByCarbohidratosObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratosObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByGrasasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByGrasasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByKcalObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcalObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByKcalObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kcalObjetivo', Sort.desc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByProteinasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QAfterSortBy>
  thenByProteinasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinasObjetivo', Sort.desc);
    });
  }
}

extension ObjetivosNutricionalesQueryWhereDistinct
    on QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct> {
  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct>
  distinctByAguaObjetivoMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aguaObjetivoMl');
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct>
  distinctByCarbohidratosObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbohidratosObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct>
  distinctByGrasasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grasasObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct>
  distinctByKcalObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kcalObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, ObjetivosNutricionales, QDistinct>
  distinctByProteinasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinasObjetivo');
    });
  }
}

extension ObjetivosNutricionalesQueryProperty
    on
        QueryBuilder<
          ObjetivosNutricionales,
          ObjetivosNutricionales,
          QQueryProperty
        > {
  QueryBuilder<ObjetivosNutricionales, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ObjetivosNutricionales, double, QQueryOperations>
  aguaObjetivoMlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aguaObjetivoMl');
    });
  }

  QueryBuilder<ObjetivosNutricionales, double, QQueryOperations>
  carbohidratosObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbohidratosObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, double, QQueryOperations>
  grasasObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grasasObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, double, QQueryOperations>
  kcalObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kcalObjetivo');
    });
  }

  QueryBuilder<ObjetivosNutricionales, double, QQueryOperations>
  proteinasObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinasObjetivo');
    });
  }
}
