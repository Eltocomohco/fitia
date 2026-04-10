// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSerieCollection on Isar {
  IsarCollection<Serie> get series => this.collection();
}

const SerieSchema = CollectionSchema(
  name: r'Serie',
  id: 1245856759724849144,
  properties: {
    r'completada': PropertySchema(
      id: 0,
      name: r'completada',
      type: IsarType.bool,
    ),
    r'pesoKg': PropertySchema(id: 1, name: r'pesoKg', type: IsarType.double),
    r'repeticiones': PropertySchema(
      id: 2,
      name: r'repeticiones',
      type: IsarType.long,
    ),
  },

  estimateSize: _serieEstimateSize,
  serialize: _serieSerialize,
  deserialize: _serieDeserialize,
  deserializeProp: _serieDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'sesion': LinkSchema(
      id: -3433045811052362356,
      name: r'sesion',
      target: r'SesionEntrenamiento',
      single: true,
    ),
    r'ejercicio': LinkSchema(
      id: -6710015599469669311,
      name: r'ejercicio',
      target: r'Ejercicio',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _serieGetId,
  getLinks: _serieGetLinks,
  attach: _serieAttach,
  version: '3.3.2',
);

int _serieEstimateSize(
  Serie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _serieSerialize(
  Serie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completada);
  writer.writeDouble(offsets[1], object.pesoKg);
  writer.writeLong(offsets[2], object.repeticiones);
}

Serie _serieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Serie(
    completada: reader.readBoolOrNull(offsets[0]) ?? false,
    id: id,
    pesoKg: reader.readDoubleOrNull(offsets[1]) ?? 0,
    repeticiones: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  return object;
}

P _serieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _serieGetId(Serie object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serieGetLinks(Serie object) {
  return [object.sesion, object.ejercicio];
}

void _serieAttach(IsarCollection<dynamic> col, Id id, Serie object) {
  object.id = id;
  object.sesion.attach(
    col,
    col.isar.collection<SesionEntrenamiento>(),
    r'sesion',
    id,
  );
  object.ejercicio.attach(
    col,
    col.isar.collection<Ejercicio>(),
    r'ejercicio',
    id,
  );
}

extension SerieQueryWhereSort on QueryBuilder<Serie, Serie, QWhere> {
  QueryBuilder<Serie, Serie, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SerieQueryWhere on QueryBuilder<Serie, Serie, QWhereClause> {
  QueryBuilder<Serie, Serie, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Serie, Serie, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Serie, Serie, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterWhereClause> idBetween(
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

extension SerieQueryFilter on QueryBuilder<Serie, Serie, QFilterCondition> {
  QueryBuilder<Serie, Serie, QAfterFilterCondition> completadaEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completada', value: value),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoKgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pesoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoKgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pesoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoKgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pesoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoKgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pesoKg',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repeticiones', value: value),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeticiones',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeticiones',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeticiones',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SerieQueryObject on QueryBuilder<Serie, Serie, QFilterCondition> {}

extension SerieQueryLinks on QueryBuilder<Serie, Serie, QFilterCondition> {
  QueryBuilder<Serie, Serie, QAfterFilterCondition> sesion(
    FilterQuery<SesionEntrenamiento> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sesion');
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> sesionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sesion', 0, true, 0, true);
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> ejercicio(
    FilterQuery<Ejercicio> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ejercicio');
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> ejercicioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ejercicio', 0, true, 0, true);
    });
  }
}

extension SerieQuerySortBy on QueryBuilder<Serie, Serie, QSortBy> {
  QueryBuilder<Serie, Serie, QAfterSortBy> sortByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> sortByCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.desc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> sortByPesoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoKg', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> sortByPesoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoKg', Sort.desc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> sortByRepeticiones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticiones', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> sortByRepeticionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticiones', Sort.desc);
    });
  }
}

extension SerieQuerySortThenBy on QueryBuilder<Serie, Serie, QSortThenBy> {
  QueryBuilder<Serie, Serie, QAfterSortBy> thenByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.desc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByPesoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoKg', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByPesoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoKg', Sort.desc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByRepeticiones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticiones', Sort.asc);
    });
  }

  QueryBuilder<Serie, Serie, QAfterSortBy> thenByRepeticionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticiones', Sort.desc);
    });
  }
}

extension SerieQueryWhereDistinct on QueryBuilder<Serie, Serie, QDistinct> {
  QueryBuilder<Serie, Serie, QDistinct> distinctByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completada');
    });
  }

  QueryBuilder<Serie, Serie, QDistinct> distinctByPesoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoKg');
    });
  }

  QueryBuilder<Serie, Serie, QDistinct> distinctByRepeticiones() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeticiones');
    });
  }
}

extension SerieQueryProperty on QueryBuilder<Serie, Serie, QQueryProperty> {
  QueryBuilder<Serie, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Serie, bool, QQueryOperations> completadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completada');
    });
  }

  QueryBuilder<Serie, double, QQueryOperations> pesoKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoKg');
    });
  }

  QueryBuilder<Serie, int, QQueryOperations> repeticionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeticiones');
    });
  }
}
