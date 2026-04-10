// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_conversation_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAiChatConversationLogCollection on Isar {
  IsarCollection<AiChatConversationLog> get aiChatConversationLogs =>
      this.collection();
}

const AiChatConversationLogSchema = CollectionSchema(
  name: r'AiChatConversationLog',
  id: -6768557863953853644,
  properties: {
    r'agentKey': PropertySchema(
      id: 0,
      name: r'agentKey',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'transcript': PropertySchema(
      id: 2,
      name: r'transcript',
      type: IsarType.string,
    ),
  },

  estimateSize: _aiChatConversationLogEstimateSize,
  serialize: _aiChatConversationLogSerialize,
  deserialize: _aiChatConversationLogDeserialize,
  deserializeProp: _aiChatConversationLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'agentKey': IndexSchema(
      id: -5231794304599812572,
      name: r'agentKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'agentKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _aiChatConversationLogGetId,
  getLinks: _aiChatConversationLogGetLinks,
  attach: _aiChatConversationLogAttach,
  version: '3.3.2',
);

int _aiChatConversationLogEstimateSize(
  AiChatConversationLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.agentKey.length * 3;
  bytesCount += 3 + object.transcript.length * 3;
  return bytesCount;
}

void _aiChatConversationLogSerialize(
  AiChatConversationLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.agentKey);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.transcript);
}

AiChatConversationLog _aiChatConversationLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiChatConversationLog(
    agentKey: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    id: id,
    transcript: reader.readString(offsets[2]),
  );
  return object;
}

P _aiChatConversationLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aiChatConversationLogGetId(AiChatConversationLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiChatConversationLogGetLinks(
  AiChatConversationLog object,
) {
  return [];
}

void _aiChatConversationLogAttach(
  IsarCollection<dynamic> col,
  Id id,
  AiChatConversationLog object,
) {
  object.id = id;
}

extension AiChatConversationLogQueryWhereSort
    on QueryBuilder<AiChatConversationLog, AiChatConversationLog, QWhere> {
  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhere>
  anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension AiChatConversationLogQueryWhere
    on
        QueryBuilder<
          AiChatConversationLog,
          AiChatConversationLog,
          QWhereClause
        > {
  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
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

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
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

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  agentKeyEqualTo(String agentKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'agentKey', value: [agentKey]),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  agentKeyNotEqualTo(String agentKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'agentKey',
                lower: [],
                upper: [agentKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'agentKey',
                lower: [agentKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'agentKey',
                lower: [agentKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'agentKey',
                lower: [],
                upper: [agentKey],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  createdAtGreaterThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [createdAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  createdAtLessThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [],
          upper: [createdAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterWhereClause>
  createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [lowerCreatedAt],
          includeLower: includeLower,
          upper: [upperCreatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AiChatConversationLogQueryFilter
    on
        QueryBuilder<
          AiChatConversationLog,
          AiChatConversationLog,
          QFilterCondition
        > {
  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'agentKey',
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
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'agentKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'agentKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'agentKey', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  agentKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'agentKey', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
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
    AiChatConversationLog,
    AiChatConversationLog,
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
    AiChatConversationLog,
    AiChatConversationLog,
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
    AiChatConversationLog,
    AiChatConversationLog,
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
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'transcript',
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
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'transcript',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'transcript', value: ''),
      );
    });
  }

  QueryBuilder<
    AiChatConversationLog,
    AiChatConversationLog,
    QAfterFilterCondition
  >
  transcriptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'transcript', value: ''),
      );
    });
  }
}

extension AiChatConversationLogQueryObject
    on
        QueryBuilder<
          AiChatConversationLog,
          AiChatConversationLog,
          QFilterCondition
        > {}

extension AiChatConversationLogQueryLinks
    on
        QueryBuilder<
          AiChatConversationLog,
          AiChatConversationLog,
          QFilterCondition
        > {}

extension AiChatConversationLogQuerySortBy
    on QueryBuilder<AiChatConversationLog, AiChatConversationLog, QSortBy> {
  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByAgentKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentKey', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByAgentKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentKey', Sort.desc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  sortByTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.desc);
    });
  }
}

extension AiChatConversationLogQuerySortThenBy
    on QueryBuilder<AiChatConversationLog, AiChatConversationLog, QSortThenBy> {
  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByAgentKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentKey', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByAgentKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentKey', Sort.desc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.asc);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QAfterSortBy>
  thenByTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.desc);
    });
  }
}

extension AiChatConversationLogQueryWhereDistinct
    on QueryBuilder<AiChatConversationLog, AiChatConversationLog, QDistinct> {
  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QDistinct>
  distinctByAgentKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agentKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AiChatConversationLog, AiChatConversationLog, QDistinct>
  distinctByTranscript({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transcript', caseSensitive: caseSensitive);
    });
  }
}

extension AiChatConversationLogQueryProperty
    on
        QueryBuilder<
          AiChatConversationLog,
          AiChatConversationLog,
          QQueryProperty
        > {
  QueryBuilder<AiChatConversationLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiChatConversationLog, String, QQueryOperations>
  agentKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agentKey');
    });
  }

  QueryBuilder<AiChatConversationLog, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AiChatConversationLog, String, QQueryOperations>
  transcriptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transcript');
    });
  }
}
