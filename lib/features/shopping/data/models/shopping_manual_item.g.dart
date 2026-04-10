// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_manual_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShoppingManualItemCollection on Isar {
  IsarCollection<ShoppingManualItem> get shoppingManualItems =>
      this.collection();
}

const ShoppingManualItemSchema = CollectionSchema(
  name: r'ShoppingManualItem',
  id: -7234153864646410014,
  properties: {
    r'endDate': PropertySchema(
      id: 0,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'grams': PropertySchema(id: 1, name: r'grams', type: IsarType.double),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'startDate': PropertySchema(
      id: 3,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _shoppingManualItemEstimateSize,
  serialize: _shoppingManualItemSerialize,
  deserialize: _shoppingManualItemDeserialize,
  deserializeProp: _shoppingManualItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'startDate': IndexSchema(
      id: 7723980484494730382,
      name: r'startDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'startDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'endDate': IndexSchema(
      id: 422088669960424970,
      name: r'endDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'endDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _shoppingManualItemGetId,
  getLinks: _shoppingManualItemGetLinks,
  attach: _shoppingManualItemAttach,
  version: '3.3.2',
);

int _shoppingManualItemEstimateSize(
  ShoppingManualItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _shoppingManualItemSerialize(
  ShoppingManualItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endDate);
  writer.writeDouble(offsets[1], object.grams);
  writer.writeString(offsets[2], object.name);
  writer.writeDateTime(offsets[3], object.startDate);
}

ShoppingManualItem _shoppingManualItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShoppingManualItem(
    endDate: reader.readDateTime(offsets[0]),
    grams: reader.readDouble(offsets[1]),
    id: id,
    name: reader.readString(offsets[2]),
    startDate: reader.readDateTime(offsets[3]),
  );
  return object;
}

P _shoppingManualItemDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shoppingManualItemGetId(ShoppingManualItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shoppingManualItemGetLinks(
  ShoppingManualItem object,
) {
  return [];
}

void _shoppingManualItemAttach(
  IsarCollection<dynamic> col,
  Id id,
  ShoppingManualItem object,
) {
  object.id = id;
}

extension ShoppingManualItemQueryWhereSort
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QWhere> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhere>
  anyStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startDate'),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhere>
  anyEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'endDate'),
      );
    });
  }
}

extension ShoppingManualItemQueryWhere
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QWhereClause> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
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

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
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

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  startDateEqualTo(DateTime startDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'startDate', value: [startDate]),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  startDateNotEqualTo(DateTime startDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startDate',
                lower: [],
                upper: [startDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startDate',
                lower: [startDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startDate',
                lower: [startDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startDate',
                lower: [],
                upper: [startDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  startDateGreaterThan(DateTime startDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startDate',
          lower: [startDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  startDateLessThan(DateTime startDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startDate',
          lower: [],
          upper: [startDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  startDateBetween(
    DateTime lowerStartDate,
    DateTime upperStartDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startDate',
          lower: [lowerStartDate],
          includeLower: includeLower,
          upper: [upperStartDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  endDateEqualTo(DateTime endDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'endDate', value: [endDate]),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  endDateNotEqualTo(DateTime endDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'endDate',
                lower: [],
                upper: [endDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'endDate',
                lower: [endDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'endDate',
                lower: [endDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'endDate',
                lower: [],
                upper: [endDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  endDateGreaterThan(DateTime endDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'endDate',
          lower: [endDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  endDateLessThan(DateTime endDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'endDate',
          lower: [],
          upper: [endDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterWhereClause>
  endDateBetween(
    DateTime lowerEndDate,
    DateTime upperEndDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'endDate',
          lower: [lowerEndDate],
          includeLower: includeLower,
          upper: [upperEndDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ShoppingManualItemQueryFilter
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QFilterCondition> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  endDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endDate', value: value),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  endDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  endDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  endDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  gramsEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grams',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  gramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grams',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  gramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grams',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  gramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grams',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startDate', value: value),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  startDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  startDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterFilterCondition>
  startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ShoppingManualItemQueryObject
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QFilterCondition> {}

extension ShoppingManualItemQueryLinks
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QFilterCondition> {}

extension ShoppingManualItemQuerySortBy
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QSortBy> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grams', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grams', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }
}

extension ShoppingManualItemQuerySortThenBy
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QSortThenBy> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grams', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grams', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QAfterSortBy>
  thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }
}

extension ShoppingManualItemQueryWhereDistinct
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QDistinct> {
  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QDistinct>
  distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QDistinct>
  distinctByGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grams');
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingManualItem, ShoppingManualItem, QDistinct>
  distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }
}

extension ShoppingManualItemQueryProperty
    on QueryBuilder<ShoppingManualItem, ShoppingManualItem, QQueryProperty> {
  QueryBuilder<ShoppingManualItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShoppingManualItem, DateTime, QQueryOperations>
  endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<ShoppingManualItem, double, QQueryOperations> gramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grams');
    });
  }

  QueryBuilder<ShoppingManualItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ShoppingManualItem, DateTime, QQueryOperations>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }
}
