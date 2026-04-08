// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_agua.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroAguaCollection on Isar {
  IsarCollection<RegistroAgua> get registrosAgua => this.collection();
}

const RegistroAguaSchema = CollectionSchema(
  name: r'RegistroAgua',
  id: 3228413567836297462,
  properties: {
    r'fecha': PropertySchema(id: 0, name: r'fecha', type: IsarType.dateTime),
    r'mililitros': PropertySchema(
      id: 1,
      name: r'mililitros',
      type: IsarType.long,
    ),
  },

  estimateSize: _registroAguaEstimateSize,
  serialize: _registroAguaSerialize,
  deserialize: _registroAguaDeserialize,
  deserializeProp: _registroAguaDeserializeProp,
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

  getId: _registroAguaGetId,
  getLinks: _registroAguaGetLinks,
  attach: _registroAguaAttach,
  version: '3.3.2',
);

int _registroAguaEstimateSize(
  RegistroAgua object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _registroAguaSerialize(
  RegistroAgua object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fecha);
  writer.writeLong(offsets[1], object.mililitros);
}

RegistroAgua _registroAguaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroAgua(
    fecha: reader.readDateTime(offsets[0]),
    id: id,
    mililitros: reader.readLong(offsets[1]),
  );
  return object;
}

P _registroAguaDeserializeProp<P>(
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

Id _registroAguaGetId(RegistroAgua object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroAguaGetLinks(RegistroAgua object) {
  return [];
}

void _registroAguaAttach(
  IsarCollection<dynamic> col,
  Id id,
  RegistroAgua object,
) {
  object.id = id;
}

extension RegistroAguaQueryWhereSort
    on QueryBuilder<RegistroAgua, RegistroAgua, QWhere> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension RegistroAguaQueryWhere
    on QueryBuilder<RegistroAgua, RegistroAgua, QWhereClause> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaEqualTo(
    DateTime fecha,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaNotEqualTo(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaGreaterThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaBetween(
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

extension RegistroAguaQueryFilter
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
  mililitrosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mililitros', value: value),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
  mililitrosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mililitros',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
  mililitrosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mililitros',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
  mililitrosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mililitros',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RegistroAguaQueryObject
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {}

extension RegistroAguaQueryLinks
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {}

extension RegistroAguaQuerySortBy
    on QueryBuilder<RegistroAgua, RegistroAgua, QSortBy> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByMililitros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mililitros', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
  sortByMililitrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mililitros', Sort.desc);
    });
  }
}

extension RegistroAguaQuerySortThenBy
    on QueryBuilder<RegistroAgua, RegistroAgua, QSortThenBy> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByMililitros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mililitros', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
  thenByMililitrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mililitros', Sort.desc);
    });
  }
}

extension RegistroAguaQueryWhereDistinct
    on QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> {
  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByMililitros() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mililitros');
    });
  }
}

extension RegistroAguaQueryProperty
    on QueryBuilder<RegistroAgua, RegistroAgua, QQueryProperty> {
  QueryBuilder<RegistroAgua, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroAgua, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<RegistroAgua, int, QQueryOperations> mililitrosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mililitros');
    });
  }
}
