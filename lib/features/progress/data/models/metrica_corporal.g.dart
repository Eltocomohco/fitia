// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metrica_corporal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMetricaCorporalCollection on Isar {
  IsarCollection<MetricaCorporal> get metricasCorporales => this.collection();
}

const MetricaCorporalSchema = CollectionSchema(
  name: r'MetricaCorporal',
  id: 2405515714069607353,
  properties: {
    r'fecha': PropertySchema(id: 0, name: r'fecha', type: IsarType.dateTime),
    r'peso': PropertySchema(id: 1, name: r'peso', type: IsarType.double),
    r'porcentajeGrasa': PropertySchema(
      id: 2,
      name: r'porcentajeGrasa',
      type: IsarType.double,
    ),
  },

  estimateSize: _metricaCorporalEstimateSize,
  serialize: _metricaCorporalSerialize,
  deserialize: _metricaCorporalDeserialize,
  deserializeProp: _metricaCorporalDeserializeProp,
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
  },
  links: {},
  embeddedSchemas: {},

  getId: _metricaCorporalGetId,
  getLinks: _metricaCorporalGetLinks,
  attach: _metricaCorporalAttach,
  version: '3.3.2',
);

int _metricaCorporalEstimateSize(
  MetricaCorporal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _metricaCorporalSerialize(
  MetricaCorporal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fecha);
  writer.writeDouble(offsets[1], object.peso);
  writer.writeDouble(offsets[2], object.porcentajeGrasa);
}

MetricaCorporal _metricaCorporalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MetricaCorporal(
    fecha: reader.readDateTime(offsets[0]),
    id: id,
    peso: reader.readDouble(offsets[1]),
    porcentajeGrasa: reader.readDoubleOrNull(offsets[2]),
  );
  return object;
}

P _metricaCorporalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _metricaCorporalGetId(MetricaCorporal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _metricaCorporalGetLinks(MetricaCorporal object) {
  return [];
}

void _metricaCorporalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MetricaCorporal object,
) {
  object.id = id;
}

extension MetricaCorporalQueryWhereSort
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QWhere> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension MetricaCorporalQueryWhere
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QWhereClause> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause> idBetween(
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
  fechaEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterWhereClause>
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
}

extension MetricaCorporalQueryFilter
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QFilterCondition> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
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

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  pesoEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'peso',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  pesoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'peso',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  pesoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'peso',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  pesoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'peso',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'porcentajeGrasa'),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'porcentajeGrasa'),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'porcentajeGrasa',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'porcentajeGrasa',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'porcentajeGrasa',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterFilterCondition>
  porcentajeGrasaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'porcentajeGrasa',
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

extension MetricaCorporalQueryObject
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QFilterCondition> {}

extension MetricaCorporalQueryLinks
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QFilterCondition> {}

extension MetricaCorporalQuerySortBy
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QSortBy> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> sortByPeso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peso', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  sortByPesoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peso', Sort.desc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  sortByPorcentajeGrasa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeGrasa', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  sortByPorcentajeGrasaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeGrasa', Sort.desc);
    });
  }
}

extension MetricaCorporalQuerySortThenBy
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QSortThenBy> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy> thenByPeso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peso', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  thenByPesoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peso', Sort.desc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  thenByPorcentajeGrasa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeGrasa', Sort.asc);
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QAfterSortBy>
  thenByPorcentajeGrasaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'porcentajeGrasa', Sort.desc);
    });
  }
}

extension MetricaCorporalQueryWhereDistinct
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QDistinct> {
  QueryBuilder<MetricaCorporal, MetricaCorporal, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QDistinct> distinctByPeso() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peso');
    });
  }

  QueryBuilder<MetricaCorporal, MetricaCorporal, QDistinct>
  distinctByPorcentajeGrasa() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'porcentajeGrasa');
    });
  }
}

extension MetricaCorporalQueryProperty
    on QueryBuilder<MetricaCorporal, MetricaCorporal, QQueryProperty> {
  QueryBuilder<MetricaCorporal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MetricaCorporal, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<MetricaCorporal, double, QQueryOperations> pesoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peso');
    });
  }

  QueryBuilder<MetricaCorporal, double?, QQueryOperations>
  porcentajeGrasaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'porcentajeGrasa');
    });
  }
}
