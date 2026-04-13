// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarea_hoy.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTareaHoyCollection on Isar {
  IsarCollection<TareaHoy> get tareasHoy => this.collection();
}

const TareaHoySchema = CollectionSchema(
  name: r'TareaHoy',
  id: 5402509168376048630,
  properties: {
    r'completada': PropertySchema(
      id: 0,
      name: r'completada',
      type: IsarType.bool,
    ),
    r'completadaEn': PropertySchema(
      id: 1,
      name: r'completadaEn',
      type: IsarType.dateTime,
    ),
    r'creadaEn': PropertySchema(
      id: 2,
      name: r'creadaEn',
      type: IsarType.dateTime,
    ),
    r'fecha': PropertySchema(id: 3, name: r'fecha', type: IsarType.dateTime),
    r'titulo': PropertySchema(id: 4, name: r'titulo', type: IsarType.string),
  },

  estimateSize: _tareaHoyEstimateSize,
  serialize: _tareaHoySerialize,
  deserialize: _tareaHoyDeserialize,
  deserializeProp: _tareaHoyDeserializeProp,
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
    r'titulo': IndexSchema(
      id: 6803526659352100783,
      name: r'titulo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titulo',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _tareaHoyGetId,
  getLinks: _tareaHoyGetLinks,
  attach: _tareaHoyAttach,
  version: '3.3.2',
);

int _tareaHoyEstimateSize(
  TareaHoy object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _tareaHoySerialize(
  TareaHoy object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completada);
  writer.writeDateTime(offsets[1], object.completadaEn);
  writer.writeDateTime(offsets[2], object.creadaEn);
  writer.writeDateTime(offsets[3], object.fecha);
  writer.writeString(offsets[4], object.titulo);
}

TareaHoy _tareaHoyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TareaHoy(
    completada: reader.readBoolOrNull(offsets[0]) ?? false,
    completadaEn: reader.readDateTimeOrNull(offsets[1]),
    fecha: reader.readDateTime(offsets[3]),
    id: id,
    titulo: reader.readString(offsets[4]),
  );
  object.creadaEn = reader.readDateTime(offsets[2]);
  return object;
}

P _tareaHoyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tareaHoyGetId(TareaHoy object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tareaHoyGetLinks(TareaHoy object) {
  return [];
}

void _tareaHoyAttach(IsarCollection<dynamic> col, Id id, TareaHoy object) {
  object.id = id;
}

extension TareaHoyQueryWhereSort on QueryBuilder<TareaHoy, TareaHoy, QWhere> {
  QueryBuilder<TareaHoy, TareaHoy, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension TareaHoyQueryWhere on QueryBuilder<TareaHoy, TareaHoy, QWhereClause> {
  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> idBetween(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> fechaEqualTo(
    DateTime fecha,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> fechaNotEqualTo(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> fechaGreaterThan(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> fechaLessThan(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> fechaBetween(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> tituloEqualTo(
    String titulo,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'titulo', value: [titulo]),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterWhereClause> tituloNotEqualTo(
    String titulo,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titulo',
                lower: [],
                upper: [titulo],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titulo',
                lower: [titulo],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titulo',
                lower: [titulo],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titulo',
                lower: [],
                upper: [titulo],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension TareaHoyQueryFilter
    on QueryBuilder<TareaHoy, TareaHoy, QFilterCondition> {
  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> completadaEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completada', value: value),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> completadaEnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'completadaEn'),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition>
  completadaEnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'completadaEn'),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> completadaEnEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completadaEn', value: value),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition>
  completadaEnGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'completadaEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> completadaEnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'completadaEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> completadaEnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'completadaEn',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> creadaEnEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'creadaEn', value: value),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> creadaEnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'creadaEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> creadaEnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'creadaEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> creadaEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'creadaEn',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> fechaEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> fechaLessThan(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'titulo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'titulo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'titulo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'titulo', value: ''),
      );
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterFilterCondition> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'titulo', value: ''),
      );
    });
  }
}

extension TareaHoyQueryObject
    on QueryBuilder<TareaHoy, TareaHoy, QFilterCondition> {}

extension TareaHoyQueryLinks
    on QueryBuilder<TareaHoy, TareaHoy, QFilterCondition> {}

extension TareaHoyQuerySortBy on QueryBuilder<TareaHoy, TareaHoy, QSortBy> {
  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCompletadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completadaEn', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCompletadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completadaEn', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCreadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadaEn', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByCreadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadaEn', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaHoyQuerySortThenBy
    on QueryBuilder<TareaHoy, TareaHoy, QSortThenBy> {
  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCompletadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completada', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCompletadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completadaEn', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCompletadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completadaEn', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCreadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadaEn', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByCreadaEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadaEn', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaHoyQueryWhereDistinct
    on QueryBuilder<TareaHoy, TareaHoy, QDistinct> {
  QueryBuilder<TareaHoy, TareaHoy, QDistinct> distinctByCompletada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completada');
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QDistinct> distinctByCompletadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completadaEn');
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QDistinct> distinctByCreadaEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creadaEn');
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<TareaHoy, TareaHoy, QDistinct> distinctByTitulo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }
}

extension TareaHoyQueryProperty
    on QueryBuilder<TareaHoy, TareaHoy, QQueryProperty> {
  QueryBuilder<TareaHoy, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TareaHoy, bool, QQueryOperations> completadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completada');
    });
  }

  QueryBuilder<TareaHoy, DateTime?, QQueryOperations> completadaEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completadaEn');
    });
  }

  QueryBuilder<TareaHoy, DateTime, QQueryOperations> creadaEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creadaEn');
    });
  }

  QueryBuilder<TareaHoy, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<TareaHoy, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }
}
