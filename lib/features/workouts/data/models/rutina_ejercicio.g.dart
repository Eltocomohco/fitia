// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rutina_ejercicio.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRutinaEjercicioCollection on Isar {
  IsarCollection<RutinaEjercicio> get rutinasEjercicio => this.collection();
}

const RutinaEjercicioSchema = CollectionSchema(
  name: r'RutinaEjercicio',
  id: -7968614956658535000,
  properties: {
    r'orden': PropertySchema(id: 0, name: r'orden', type: IsarType.long),
    r'pesoObjetivoKg': PropertySchema(
      id: 1,
      name: r'pesoObjetivoKg',
      type: IsarType.double,
    ),
    r'repeticionesMaximasObjetivo': PropertySchema(
      id: 2,
      name: r'repeticionesMaximasObjetivo',
      type: IsarType.long,
    ),
    r'repeticionesMinimasObjetivo': PropertySchema(
      id: 3,
      name: r'repeticionesMinimasObjetivo',
      type: IsarType.long,
    ),
    r'seriesObjetivo': PropertySchema(
      id: 4,
      name: r'seriesObjetivo',
      type: IsarType.long,
    ),
  },

  estimateSize: _rutinaEjercicioEstimateSize,
  serialize: _rutinaEjercicioSerialize,
  deserialize: _rutinaEjercicioDeserialize,
  deserializeProp: _rutinaEjercicioDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'rutina': LinkSchema(
      id: 6672534385730366745,
      name: r'rutina',
      target: r'RutinaPlantilla',
      single: true,
    ),
    r'ejercicio': LinkSchema(
      id: -7689505489480633425,
      name: r'ejercicio',
      target: r'Ejercicio',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _rutinaEjercicioGetId,
  getLinks: _rutinaEjercicioGetLinks,
  attach: _rutinaEjercicioAttach,
  version: '3.3.2',
);

int _rutinaEjercicioEstimateSize(
  RutinaEjercicio object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _rutinaEjercicioSerialize(
  RutinaEjercicio object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.orden);
  writer.writeDouble(offsets[1], object.pesoObjetivoKg);
  writer.writeLong(offsets[2], object.repeticionesMaximasObjetivo);
  writer.writeLong(offsets[3], object.repeticionesMinimasObjetivo);
  writer.writeLong(offsets[4], object.seriesObjetivo);
}

RutinaEjercicio _rutinaEjercicioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RutinaEjercicio(
    id: id,
    orden: reader.readLong(offsets[0]),
    pesoObjetivoKg: reader.readDoubleOrNull(offsets[1]),
    repeticionesMaximasObjetivo: reader.readLongOrNull(offsets[2]),
    repeticionesMinimasObjetivo: reader.readLongOrNull(offsets[3]),
    seriesObjetivo: reader.readLongOrNull(offsets[4]) ?? 3,
  );
  return object;
}

P _rutinaEjercicioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 3) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rutinaEjercicioGetId(RutinaEjercicio object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rutinaEjercicioGetLinks(RutinaEjercicio object) {
  return [object.rutina, object.ejercicio];
}

void _rutinaEjercicioAttach(
  IsarCollection<dynamic> col,
  Id id,
  RutinaEjercicio object,
) {
  object.id = id;
  object.rutina.attach(
    col,
    col.isar.collection<RutinaPlantilla>(),
    r'rutina',
    id,
  );
  object.ejercicio.attach(
    col,
    col.isar.collection<Ejercicio>(),
    r'ejercicio',
    id,
  );
}

extension RutinaEjercicioQueryWhereSort
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QWhere> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RutinaEjercicioQueryWhere
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QWhereClause> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhereClause>
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

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterWhereClause> idBetween(
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

extension RutinaEjercicioQueryFilter
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QFilterCondition> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ordenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orden', value: value),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ordenGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'orden',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ordenLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'orden',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ordenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'orden',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pesoObjetivoKg'),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pesoObjetivoKg'),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  pesoObjetivoKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pesoObjetivoKg',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'repeticionesMaximasObjetivo'),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'repeticionesMaximasObjetivo',
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'repeticionesMaximasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeticionesMaximasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeticionesMaximasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMaximasObjetivoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeticionesMaximasObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'repeticionesMinimasObjetivo'),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'repeticionesMinimasObjetivo',
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'repeticionesMinimasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeticionesMinimasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeticionesMinimasObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  repeticionesMinimasObjetivoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeticionesMinimasObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  seriesObjetivoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'seriesObjetivo', value: value),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  seriesObjetivoGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'seriesObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  seriesObjetivoLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'seriesObjetivo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  seriesObjetivoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'seriesObjetivo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RutinaEjercicioQueryObject
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QFilterCondition> {}

extension RutinaEjercicioQueryLinks
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QFilterCondition> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition> rutina(
    FilterQuery<RutinaPlantilla> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'rutina');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  rutinaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'rutina', 0, true, 0, true);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ejercicio(FilterQuery<Ejercicio> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ejercicio');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterFilterCondition>
  ejercicioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ejercicio', 0, true, 0, true);
    });
  }
}

extension RutinaEjercicioQuerySortBy
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QSortBy> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy> sortByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByOrdenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByPesoObjetivoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByRepeticionesMaximasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMaximasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByRepeticionesMaximasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMaximasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByRepeticionesMinimasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMinimasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortByRepeticionesMinimasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMinimasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortBySeriesObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  sortBySeriesObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesObjetivo', Sort.desc);
    });
  }
}

extension RutinaEjercicioQuerySortThenBy
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QSortThenBy> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy> thenByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByOrdenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByPesoObjetivoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByRepeticionesMaximasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMaximasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByRepeticionesMaximasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMaximasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByRepeticionesMinimasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMinimasObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenByRepeticionesMinimasObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeticionesMinimasObjetivo', Sort.desc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenBySeriesObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesObjetivo', Sort.asc);
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QAfterSortBy>
  thenBySeriesObjetivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesObjetivo', Sort.desc);
    });
  }
}

extension RutinaEjercicioQueryWhereDistinct
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct> {
  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct> distinctByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orden');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct>
  distinctByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoObjetivoKg');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct>
  distinctByRepeticionesMaximasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeticionesMaximasObjetivo');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct>
  distinctByRepeticionesMinimasObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeticionesMinimasObjetivo');
    });
  }

  QueryBuilder<RutinaEjercicio, RutinaEjercicio, QDistinct>
  distinctBySeriesObjetivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seriesObjetivo');
    });
  }
}

extension RutinaEjercicioQueryProperty
    on QueryBuilder<RutinaEjercicio, RutinaEjercicio, QQueryProperty> {
  QueryBuilder<RutinaEjercicio, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RutinaEjercicio, int, QQueryOperations> ordenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orden');
    });
  }

  QueryBuilder<RutinaEjercicio, double?, QQueryOperations>
  pesoObjetivoKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoObjetivoKg');
    });
  }

  QueryBuilder<RutinaEjercicio, int?, QQueryOperations>
  repeticionesMaximasObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeticionesMaximasObjetivo');
    });
  }

  QueryBuilder<RutinaEjercicio, int?, QQueryOperations>
  repeticionesMinimasObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeticionesMinimasObjetivo');
    });
  }

  QueryBuilder<RutinaEjercicio, int, QQueryOperations>
  seriesObjetivoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seriesObjetivo');
    });
  }
}
