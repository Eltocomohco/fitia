// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_entrenamiento.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSesionEntrenamientoCollection on Isar {
  IsarCollection<SesionEntrenamiento> get sesionesEntrenamiento =>
      this.collection();
}

const SesionEntrenamientoSchema = CollectionSchema(
  name: r'SesionEntrenamiento',
  id: -1014368116075866751,
  properties: {
    r'estado': PropertySchema(
      id: 0,
      name: r'estado',
      type: IsarType.string,
      enumMap: _SesionEntrenamientoestadoEnumValueMap,
    ),
    r'fechaFin': PropertySchema(
      id: 1,
      name: r'fechaFin',
      type: IsarType.dateTime,
    ),
    r'fechaInicio': PropertySchema(
      id: 2,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'rutinaPlantillaId': PropertySchema(
      id: 3,
      name: r'rutinaPlantillaId',
      type: IsarType.long,
    ),
  },

  estimateSize: _sesionEntrenamientoEstimateSize,
  serialize: _sesionEntrenamientoSerialize,
  deserialize: _sesionEntrenamientoDeserialize,
  deserializeProp: _sesionEntrenamientoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _sesionEntrenamientoGetId,
  getLinks: _sesionEntrenamientoGetLinks,
  attach: _sesionEntrenamientoAttach,
  version: '3.3.2',
);

int _sesionEntrenamientoEstimateSize(
  SesionEntrenamiento object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.name.length * 3;
  return bytesCount;
}

void _sesionEntrenamientoSerialize(
  SesionEntrenamiento object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.estado.name);
  writer.writeDateTime(offsets[1], object.fechaFin);
  writer.writeDateTime(offsets[2], object.fechaInicio);
  writer.writeLong(offsets[3], object.rutinaPlantillaId);
}

SesionEntrenamiento _sesionEntrenamientoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SesionEntrenamiento(
    estado:
        _SesionEntrenamientoestadoValueEnumMap[reader.readStringOrNull(
          offsets[0],
        )] ??
        EstadoSesionEntrenamiento.activa,
    fechaFin: reader.readDateTimeOrNull(offsets[1]),
    fechaInicio: reader.readDateTime(offsets[2]),
    id: id,
    rutinaPlantillaId: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _sesionEntrenamientoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_SesionEntrenamientoestadoValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              EstadoSesionEntrenamiento.activa)
          as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SesionEntrenamientoestadoEnumValueMap = {
  r'activa': r'activa',
  r'completada': r'completada',
};
const _SesionEntrenamientoestadoValueEnumMap = {
  r'activa': EstadoSesionEntrenamiento.activa,
  r'completada': EstadoSesionEntrenamiento.completada,
};

Id _sesionEntrenamientoGetId(SesionEntrenamiento object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sesionEntrenamientoGetLinks(
  SesionEntrenamiento object,
) {
  return [];
}

void _sesionEntrenamientoAttach(
  IsarCollection<dynamic> col,
  Id id,
  SesionEntrenamiento object,
) {
  object.id = id;
}

extension SesionEntrenamientoQueryWhereSort
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QWhere> {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SesionEntrenamientoQueryWhere
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QWhereClause> {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhereClause>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterWhereClause>
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

extension SesionEntrenamientoQueryFilter
    on
        QueryBuilder<
          SesionEntrenamiento,
          SesionEntrenamiento,
          QFilterCondition
        > {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoEqualTo(EstadoSesionEntrenamiento value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoGreaterThan(
    EstadoSesionEntrenamiento value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoLessThan(
    EstadoSesionEntrenamiento value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoBetween(
    EstadoSesionEntrenamiento lower,
    EstadoSesionEntrenamiento upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estado',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'estado',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fechaFin'),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fechaFin'),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaFin', value: value),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fechaFin',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fechaFin',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaFinBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fechaFin',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaInicio', value: value),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
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

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rutinaPlantillaId'),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rutinaPlantillaId'),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rutinaPlantillaId', value: value),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rutinaPlantillaId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rutinaPlantillaId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterFilterCondition>
  rutinaPlantillaIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rutinaPlantillaId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SesionEntrenamientoQueryObject
    on
        QueryBuilder<
          SesionEntrenamiento,
          SesionEntrenamiento,
          QFilterCondition
        > {}

extension SesionEntrenamientoQueryLinks
    on
        QueryBuilder<
          SesionEntrenamiento,
          SesionEntrenamiento,
          QFilterCondition
        > {}

extension SesionEntrenamientoQuerySortBy
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QSortBy> {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByRutinaPlantillaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutinaPlantillaId', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  sortByRutinaPlantillaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutinaPlantillaId', Sort.desc);
    });
  }
}

extension SesionEntrenamientoQuerySortThenBy
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QSortThenBy> {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByRutinaPlantillaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutinaPlantillaId', Sort.asc);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QAfterSortBy>
  thenByRutinaPlantillaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutinaPlantillaId', Sort.desc);
    });
  }
}

extension SesionEntrenamientoQueryWhereDistinct
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QDistinct> {
  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QDistinct>
  distinctByEstado({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QDistinct>
  distinctByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaFin');
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QDistinct>
  distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QDistinct>
  distinctByRutinaPlantillaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rutinaPlantillaId');
    });
  }
}

extension SesionEntrenamientoQueryProperty
    on QueryBuilder<SesionEntrenamiento, SesionEntrenamiento, QQueryProperty> {
  QueryBuilder<SesionEntrenamiento, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SesionEntrenamiento, EstadoSesionEntrenamiento, QQueryOperations>
  estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<SesionEntrenamiento, DateTime?, QQueryOperations>
  fechaFinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaFin');
    });
  }

  QueryBuilder<SesionEntrenamiento, DateTime, QQueryOperations>
  fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<SesionEntrenamiento, int?, QQueryOperations>
  rutinaPlantillaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rutinaPlantillaId');
    });
  }
}
