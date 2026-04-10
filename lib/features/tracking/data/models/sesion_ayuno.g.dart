// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_ayuno.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSesionAyunoCollection on Isar {
  IsarCollection<SesionAyuno> get sesionesAyuno => this.collection();
}

const SesionAyunoSchema = CollectionSchema(
  name: r'SesionAyuno',
  id: 4028844918978848557,
  properties: {
    r'activa': PropertySchema(id: 0, name: r'activa', type: IsarType.bool),
    r'fechaInicio': PropertySchema(
      id: 1,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'horasObjetivo': PropertySchema(
      id: 2,
      name: r'horasObjetivo',
      type: IsarType.long,
    ),
  },

  estimateSize: _sesionAyunoEstimateSize,
  serialize: _sesionAyunoSerialize,
  deserialize: _sesionAyunoDeserialize,
  deserializeProp: _sesionAyunoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _sesionAyunoGetId,
  getLinks: _sesionAyunoGetLinks,
  attach: _sesionAyunoAttach,
  version: '3.3.2',
);

int _sesionAyunoEstimateSize(
  SesionAyuno object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sesionAyunoSerialize(
  SesionAyuno object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.activa);
  writer.writeDateTime(offsets[1], object.fechaInicio);
  writer.writeLong(offsets[2], object.horasObjetivo);
}

SesionAyuno _sesionAyunoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SesionAyuno(
    activa: reader.readBoolOrNull(offsets[0]) ?? false,
    fechaInicio: reader.readDateTime(offsets[1]),
    horasObjetivo: reader.readLongOrNull(offsets[2]) ?? 16,
    id: id,
  );
  return object;
}

P _sesionAyunoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 16) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sesionAyunoGetId(SesionAyuno object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sesionAyunoGetLinks(SesionAyuno object) {
  return [];
}

void _sesionAyunoAttach(
  IsarCollection<dynamic> col,
  Id id,
  SesionAyuno object,
) {
  object.id = id;
}

extension SesionAyunoQueryWhereSort
    on QueryBuilder<SesionAyuno, SesionAyuno, QWhere> {
  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SesionAyunoQueryWhere
    on QueryBuilder<SesionAyuno, SesionAyuno, QWhereClause> {
  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterWhereClause> idBetween(
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

extension SesionAyunoQueryFilter
    on QueryBuilder<SesionAyuno, SesionAyuno, QFilterCondition> {
  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition> activaEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activa', value: value),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaInicio', value: value),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  fechaInicioGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fechaInicio',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  fechaInicioLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fechaInicio',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  fechaInicioBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fechaInicio',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  horasObjetivoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'horasObjetivo', value: value),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  horasObjetivoGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'horasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  horasObjetivoLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'horasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition>
  horasObjetivoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'horasObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterFilterCondition> idBetween(
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

extension SesionAyunoQueryObject
    on QueryBuilder<SesionAyuno, SesionAyuno, QFilterCondition> {}

extension SesionAyunoQueryLinks
    on QueryBuilder<SesionAyuno, SesionAyuno, QFilterCondition> {}

extension SesionAyunoQuerySortBy
    on QueryBuilder<SesionAyuno, SesionAyuno, QSortBy> {
  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> sortByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> sortByActivaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.desc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> sortByHorasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy>
  sortByHorasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horasObjetivo', Sort.desc);
    });
  }
}

extension SesionAyunoQuerySortThenBy
    on QueryBuilder<SesionAyuno, SesionAyuno, QSortThenBy> {
  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByActivaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.desc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByHorasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy>
  thenByHorasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension SesionAyunoQueryWhereDistinct
    on QueryBuilder<SesionAyuno, SesionAyuno, QDistinct> {
  QueryBuilder<SesionAyuno, SesionAyuno, QDistinct> distinctByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activa');
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QDistinct> distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<SesionAyuno, SesionAyuno, QDistinct> distinctByHorasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horasObjetivo');
    });
  }
}

extension SesionAyunoQueryProperty
    on QueryBuilder<SesionAyuno, SesionAyuno, QQueryProperty> {
  QueryBuilder<SesionAyuno, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SesionAyuno, bool, QQueryOperations> activaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activa');
    });
  }

  QueryBuilder<SesionAyuno, DateTime, QQueryOperations> fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<SesionAyuno, int, QQueryOperations> horasObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horasObjetivo');
    });
  }
}
