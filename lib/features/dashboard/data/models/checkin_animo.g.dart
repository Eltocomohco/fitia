// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_animo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCheckinAnimoCollection on Isar {
  IsarCollection<CheckinAnimo> get checkinsAnimo => this.collection();
}

const CheckinAnimoSchema = CollectionSchema(
  name: r'CheckinAnimo',
  id: -7014316466199702981,
  properties: {
    r'energia': PropertySchema(id: 0, name: r'energia', type: IsarType.long),
    r'estado': PropertySchema(
      id: 1,
      name: r'estado',
      type: IsarType.string,
      enumMap: _CheckinAnimoestadoEnumValueMap,
    ),
    r'fecha': PropertySchema(id: 2, name: r'fecha', type: IsarType.dateTime),
    r'nota': PropertySchema(id: 3, name: r'nota', type: IsarType.string),
  },

  estimateSize: _checkinAnimoEstimateSize,
  serialize: _checkinAnimoSerialize,
  deserialize: _checkinAnimoDeserialize,
  deserializeProp: _checkinAnimoDeserializeProp,
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

  getId: _checkinAnimoGetId,
  getLinks: _checkinAnimoGetLinks,
  attach: _checkinAnimoAttach,
  version: '3.3.2',
);

int _checkinAnimoEstimateSize(
  CheckinAnimo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.name.length * 3;
  {
    final value = object.nota;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _checkinAnimoSerialize(
  CheckinAnimo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.energia);
  writer.writeString(offsets[1], object.estado.name);
  writer.writeDateTime(offsets[2], object.fecha);
  writer.writeString(offsets[3], object.nota);
}

CheckinAnimo _checkinAnimoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CheckinAnimo(
    energia: reader.readLong(offsets[0]),
    estado:
        _CheckinAnimoestadoValueEnumMap[reader.readStringOrNull(offsets[1])] ??
        EstadoAnimo.hundido,
    fecha: reader.readDateTime(offsets[2]),
    id: id,
    nota: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _checkinAnimoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (_CheckinAnimoestadoValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              EstadoAnimo.hundido)
          as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CheckinAnimoestadoEnumValueMap = {
  r'hundido': r'hundido',
  r'bajo': r'bajo',
  r'estable': r'estable',
  r'bien': r'bien',
  r'fuerte': r'fuerte',
};
const _CheckinAnimoestadoValueEnumMap = {
  r'hundido': EstadoAnimo.hundido,
  r'bajo': EstadoAnimo.bajo,
  r'estable': EstadoAnimo.estable,
  r'bien': EstadoAnimo.bien,
  r'fuerte': EstadoAnimo.fuerte,
};

Id _checkinAnimoGetId(CheckinAnimo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _checkinAnimoGetLinks(CheckinAnimo object) {
  return [];
}

void _checkinAnimoAttach(
  IsarCollection<dynamic> col,
  Id id,
  CheckinAnimo object,
) {
  object.id = id;
}

extension CheckinAnimoQueryWhereSort
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QWhere> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension CheckinAnimoQueryWhere
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QWhereClause> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> idBetween(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> fechaEqualTo(
    DateTime fecha,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> fechaNotEqualTo(
    DateTime fecha,
  ) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> fechaGreaterThan(
    DateTime fecha, {
    bool include = false,
  }) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> fechaLessThan(
    DateTime fecha, {
    bool include = false,
  }) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterWhereClause> fechaBetween(
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

extension CheckinAnimoQueryFilter
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QFilterCondition> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  energiaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'energia', value: value),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  energiaGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'energia',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  energiaLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'energia',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  energiaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'energia',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> estadoEqualTo(
    EstadoAnimo value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  estadoGreaterThan(
    EstadoAnimo value, {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  estadoLessThan(
    EstadoAnimo value, {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> estadoBetween(
    EstadoAnimo lower,
    EstadoAnimo upper, {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> estadoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> fechaEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nota'),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  notaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nota'),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  notaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nota',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  notaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nota',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition> notaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nota',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  notaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nota', value: ''),
      );
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterFilterCondition>
  notaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nota', value: ''),
      );
    });
  }
}

extension CheckinAnimoQueryObject
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QFilterCondition> {}

extension CheckinAnimoQueryLinks
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QFilterCondition> {}

extension CheckinAnimoQuerySortBy
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QSortBy> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energia', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByEnergiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energia', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> sortByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }
}

extension CheckinAnimoQuerySortThenBy
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QSortThenBy> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energia', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByEnergiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energia', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QAfterSortBy> thenByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }
}

extension CheckinAnimoQueryWhereDistinct
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QDistinct> {
  QueryBuilder<CheckinAnimo, CheckinAnimo, QDistinct> distinctByEnergia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energia');
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QDistinct> distinctByEstado({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<CheckinAnimo, CheckinAnimo, QDistinct> distinctByNota({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nota', caseSensitive: caseSensitive);
    });
  }
}

extension CheckinAnimoQueryProperty
    on QueryBuilder<CheckinAnimo, CheckinAnimo, QQueryProperty> {
  QueryBuilder<CheckinAnimo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CheckinAnimo, int, QQueryOperations> energiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energia');
    });
  }

  QueryBuilder<CheckinAnimo, EstadoAnimo, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<CheckinAnimo, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<CheckinAnimo, String?, QQueryOperations> notaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nota');
    });
  }
}
