// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_memory_snapshot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAiChatMemorySnapshotCollection on Isar {
  IsarCollection<AiChatMemorySnapshot> get aiChatMemorySnapshots =>
      this.collection();
}

const AiChatMemorySnapshotSchema = CollectionSchema(
  name: r'AiChatMemorySnapshot',
  id: -8694747700454990436,
  properties: {
    r'frequentFoodsSummary': PropertySchema(
      id: 0,
      name: r'frequentFoodsSummary',
      type: IsarType.string,
    ),
    r'preferencesSummary': PropertySchema(
      id: 1,
      name: r'preferencesSummary',
      type: IsarType.string,
    ),
    r'repeatedDinnersSummary': PropertySchema(
      id: 2,
      name: r'repeatedDinnersSummary',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 3,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weeklyAdherenceSummary': PropertySchema(
      id: 4,
      name: r'weeklyAdherenceSummary',
      type: IsarType.string,
    ),
  },

  estimateSize: _aiChatMemorySnapshotEstimateSize,
  serialize: _aiChatMemorySnapshotSerialize,
  deserialize: _aiChatMemorySnapshotDeserialize,
  deserializeProp: _aiChatMemorySnapshotDeserializeProp,
  idName: r'id',
  indexes: {
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _aiChatMemorySnapshotGetId,
  getLinks: _aiChatMemorySnapshotGetLinks,
  attach: _aiChatMemorySnapshotAttach,
  version: '3.3.2',
);

int _aiChatMemorySnapshotEstimateSize(
  AiChatMemorySnapshot object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.frequentFoodsSummary.length * 3;
  bytesCount += 3 + object.preferencesSummary.length * 3;
  bytesCount += 3 + object.repeatedDinnersSummary.length * 3;
  bytesCount += 3 + object.weeklyAdherenceSummary.length * 3;
  return bytesCount;
}

void _aiChatMemorySnapshotSerialize(
  AiChatMemorySnapshot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.frequentFoodsSummary);
  writer.writeString(offsets[1], object.preferencesSummary);
  writer.writeString(offsets[2], object.repeatedDinnersSummary);
  writer.writeDateTime(offsets[3], object.updatedAt);
  writer.writeString(offsets[4], object.weeklyAdherenceSummary);
}

AiChatMemorySnapshot _aiChatMemorySnapshotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiChatMemorySnapshot(
    frequentFoodsSummary:
        reader.readStringOrNull(offsets[0]) ??
        'Sin alimentos frecuentes detectados.',
    id: id,
    preferencesSummary:
        reader.readStringOrNull(offsets[1]) ??
        'Sin resumen de preferencias todavia.',
    repeatedDinnersSummary:
        reader.readStringOrNull(offsets[2]) ??
        'Sin cenas repetidas detectadas.',
    updatedAt: reader.readDateTime(offsets[3]),
    weeklyAdherenceSummary:
        reader.readStringOrNull(offsets[4]) ??
        'Sin cumplimiento semanal calculado.',
  );
  return object;
}

P _aiChatMemorySnapshotDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ??
              'Sin alimentos frecuentes detectados.')
          as P;
    case 1:
      return (reader.readStringOrNull(offset) ??
              'Sin resumen de preferencias todavia.')
          as P;
    case 2:
      return (reader.readStringOrNull(offset) ??
              'Sin cenas repetidas detectadas.')
          as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ??
              'Sin cumplimiento semanal calculado.')
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aiChatMemorySnapshotGetId(AiChatMemorySnapshot object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiChatMemorySnapshotGetLinks(
  AiChatMemorySnapshot object,
) {
  return [];
}

void _aiChatMemorySnapshotAttach(
  IsarCollection<dynamic> col,
  Id id,
  AiChatMemorySnapshot object,
) {
  object.id = id;
}

extension AiChatMemorySnapshotQueryWhereSort
    on QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QWhere> {
  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhere>
  anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension AiChatMemorySnapshotQueryWhere
    on QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QWhereClause> {
  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
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

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
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

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  updatedAtEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'updatedAt', value: [updatedAt]),
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  updatedAtNotEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'updatedAt',
                lower: [],
                upper: [updatedAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'updatedAt',
                lower: [updatedAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'updatedAt',
                lower: [updatedAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'updatedAt',
                lower: [],
                upper: [updatedAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  updatedAtGreaterThan(DateTime updatedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'updatedAt',
          lower: [updatedAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  updatedAtLessThan(DateTime updatedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'updatedAt',
          lower: [],
          upper: [updatedAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterWhereClause>
  updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'updatedAt',
          lower: [lowerUpdatedAt],
          includeLower: includeLower,
          upper: [upperUpdatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AiChatMemorySnapshotQueryFilter
    on
        QueryBuilder<
          AiChatMemorySnapshot,
          AiChatMemorySnapshot,
          QFilterCondition
        > {
  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'frequentFoodsSummary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'frequentFoodsSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'frequentFoodsSummary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'frequentFoodsSummary', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  frequentFoodsSummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'frequentFoodsSummary',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'preferencesSummary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'preferencesSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'preferencesSummary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'preferencesSummary', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  preferencesSummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'preferencesSummary', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeatedDinnersSummary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'repeatedDinnersSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'repeatedDinnersSummary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repeatedDinnersSummary', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  repeatedDinnersSummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'repeatedDinnersSummary',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weeklyAdherenceSummary',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'weeklyAdherenceSummary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'weeklyAdherenceSummary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'weeklyAdherenceSummary', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatMemorySnapshot,
    AiChatMemorySnapshot,
    QAfterFilterCondition
  >
  weeklyAdherenceSummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'weeklyAdherenceSummary',
          value: '',
        ),
      );
    });
  }
}

extension AiChatMemorySnapshotQueryObject
    on
        QueryBuilder<
          AiChatMemorySnapshot,
          AiChatMemorySnapshot,
          QFilterCondition
        > {}

extension AiChatMemorySnapshotQueryLinks
    on
        QueryBuilder<
          AiChatMemorySnapshot,
          AiChatMemorySnapshot,
          QFilterCondition
        > {}

extension AiChatMemorySnapshotQuerySortBy
    on QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QSortBy> {
  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByFrequentFoodsSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequentFoodsSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByFrequentFoodsSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequentFoodsSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByPreferencesSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferencesSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByPreferencesSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferencesSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByRepeatedDinnersSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatedDinnersSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByRepeatedDinnersSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatedDinnersSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByWeeklyAdherenceSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyAdherenceSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  sortByWeeklyAdherenceSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyAdherenceSummary', Sort.desc);
    });
  }
}

extension AiChatMemorySnapshotQuerySortThenBy
    on QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QSortThenBy> {
  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByFrequentFoodsSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequentFoodsSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByFrequentFoodsSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequentFoodsSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByPreferencesSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferencesSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByPreferencesSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferencesSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByRepeatedDinnersSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatedDinnersSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByRepeatedDinnersSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatedDinnersSummary', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByWeeklyAdherenceSummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyAdherenceSummary', Sort.asc);
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QAfterSortBy>
  thenByWeeklyAdherenceSummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyAdherenceSummary', Sort.desc);
    });
  }
}

extension AiChatMemorySnapshotQueryWhereDistinct
    on QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct> {
  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct>
  distinctByFrequentFoodsSummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'frequentFoodsSummary',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct>
  distinctByPreferencesSummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'preferencesSummary',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct>
  distinctByRepeatedDinnersSummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'repeatedDinnersSummary',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, AiChatMemorySnapshot, QDistinct>
  distinctByWeeklyAdherenceSummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'weeklyAdherenceSummary',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension AiChatMemorySnapshotQueryProperty
    on
        QueryBuilder<
          AiChatMemorySnapshot,
          AiChatMemorySnapshot,
          QQueryProperty
        > {
  QueryBuilder<AiChatMemorySnapshot, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, String, QQueryOperations>
  frequentFoodsSummaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequentFoodsSummary');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, String, QQueryOperations>
  preferencesSummaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferencesSummary');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, String, QQueryOperations>
  repeatedDinnersSummaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatedDinnersSummary');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<AiChatMemorySnapshot, String, QQueryOperations>
  weeklyAdherenceSummaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weeklyAdherenceSummary');
    });
  }
}
