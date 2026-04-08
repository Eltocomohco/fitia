// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dia_entrenamiento.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDiaEntrenamientoCollection on Isar {
  IsarCollection<DiaEntrenamiento> get diasEntrenamiento => this.collection();
}

const DiaEntrenamientoSchema = CollectionSchema(
  name: r'DiaEntrenamiento',
  id: -5424453743536112924,
  properties: {
    r'fecha': PropertySchema(id: 0, name: r'fecha', type: IsarType.dateTime),
    r'fechaDiaKey': PropertySchema(
      id: 1,
      name: r'fechaDiaKey',
      type: IsarType.long,
    ),
  },

  estimateSize: _diaEntrenamientoEstimateSize,
  serialize: _diaEntrenamientoSerialize,
  deserialize: _diaEntrenamientoDeserialize,
  deserializeProp: _diaEntrenamientoDeserializeProp,
  idName: r'id',
  indexes: {
    r'fecha': IndexSchema(
      id: -5395179286312083551,
      name: r'fecha',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fecha',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'fechaDiaKey': IndexSchema(
      id: -3860554356302594530,
      name: r'fechaDiaKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fechaDiaKey',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _diaEntrenamientoGetId,
  getLinks: _diaEntrenamientoGetLinks,
  attach: _diaEntrenamientoAttach,
  version: '3.3.2',
);

int _diaEntrenamientoEstimateSize(
  DiaEntrenamiento object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _diaEntrenamientoSerialize(
  DiaEntrenamiento object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fecha);
  writer.writeLong(offsets[1], object.fechaDiaKey);
}

DiaEntrenamiento _diaEntrenamientoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DiaEntrenamiento(
    fecha: reader.readDateTime(offsets[0]),
    id: id,
  );
  return object;
}

P _diaEntrenamientoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diaEntrenamientoGetId(DiaEntrenamiento object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _diaEntrenamientoGetLinks(DiaEntrenamiento object) {
  return [];
}

void _diaEntrenamientoAttach(
  IsarCollection<dynamic> col,
  Id id,
  DiaEntrenamiento object,
) {
  object.id = id;
}

extension DiaEntrenamientoQueryWhereSort
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QWhere> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhere>
  anyFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fechaDiaKey'),
      );
    });
  }
}

extension DiaEntrenamientoQueryWhere
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QWhereClause> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
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

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause> idBetween(
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

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaNotEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [],
                upper: [fecha],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [fecha],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [fecha],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [],
                upper: [fecha],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaGreaterThan(DateTime fecha, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [fecha],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaLessThan(DateTime fecha, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [],
          upper: [fecha],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaBetween(
    DateTime lowerFecha,
    DateTime upperFecha, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [lowerFecha],
          includeLower: includeLower,
          upper: [upperFecha],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaDiaKeyEqualTo(int fechaDiaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'fechaDiaKey',
          value: [fechaDiaKey],
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaDiaKeyNotEqualTo(int fechaDiaKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [],
                upper: [fechaDiaKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [fechaDiaKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [fechaDiaKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [],
                upper: [fechaDiaKey],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaDiaKeyGreaterThan(int fechaDiaKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [fechaDiaKey],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaDiaKeyLessThan(int fechaDiaKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [],
          upper: [fechaDiaKey],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterWhereClause>
  fechaDiaKeyBetween(
    int lowerFechaDiaKey,
    int upperFechaDiaKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [lowerFechaDiaKey],
          includeLower: includeLower,
          upper: [upperFechaDiaKey],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DiaEntrenamientoQueryFilter
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QFilterCondition> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fecha',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaDiaKeyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaDiaKey', value: value),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaDiaKeyGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fechaDiaKey',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaDiaKeyLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fechaDiaKey',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  fechaDiaKeyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fechaDiaKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterFilterCondition>
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
}

extension DiaEntrenamientoQueryObject
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QFilterCondition> {}

extension DiaEntrenamientoQueryLinks
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QFilterCondition> {}

extension DiaEntrenamientoQuerySortBy
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QSortBy> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  sortByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.asc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  sortByFechaDiaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.desc);
    });
  }
}

extension DiaEntrenamientoQuerySortThenBy
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QSortThenBy> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  thenByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.asc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  thenByFechaDiaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.desc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DiaEntrenamientoQueryWhereDistinct
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QDistinct> {
  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QDistinct>
  distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QDistinct>
  distinctByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaDiaKey');
    });
  }
}

extension DiaEntrenamientoQueryProperty
    on QueryBuilder<DiaEntrenamiento, DiaEntrenamiento, QQueryProperty> {
  QueryBuilder<DiaEntrenamiento, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DiaEntrenamiento, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<DiaEntrenamiento, int, QQueryOperations> fechaDiaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaDiaKey');
    });
  }
}
