// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAiChatMessageCollection on Isar {
  IsarCollection<AiChatMessage> get aiChatMessages => this.collection();
}

const AiChatMessageSchema = CollectionSchema(
  name: r'AiChatMessage',
  id: -1977251114127073363,
  properties: {
    r'actionResult': PropertySchema(
      id: 0,
      name: r'actionResult',
      type: IsarType.string,
    ),
    r'actionStatus': PropertySchema(
      id: 1,
      name: r'actionStatus',
      type: IsarType.byte,
      enumMap: _AiChatMessageactionStatusEnumValueMap,
    ),
    r'actionsJson': PropertySchema(
      id: 2,
      name: r'actionsJson',
      type: IsarType.string,
    ),
    r'conversationId': PropertySchema(
      id: 3,
      name: r'conversationId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'role': PropertySchema(
      id: 5,
      name: r'role',
      type: IsarType.byte,
      enumMap: _AiChatMessageroleEnumValueMap,
    ),
    r'text': PropertySchema(id: 6, name: r'text', type: IsarType.string),
  },

  estimateSize: _aiChatMessageEstimateSize,
  serialize: _aiChatMessageSerialize,
  deserialize: _aiChatMessageDeserialize,
  deserializeProp: _aiChatMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'conversationId': IndexSchema(
      id: 2945908346256754300,
      name: r'conversationId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'conversationId',
          type: IndexType.value,
          caseSensitive: false,
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

  getId: _aiChatMessageGetId,
  getLinks: _aiChatMessageGetLinks,
  attach: _aiChatMessageAttach,
  version: '3.3.2',
);

int _aiChatMessageEstimateSize(
  AiChatMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.actionResult;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.actionsJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _aiChatMessageSerialize(
  AiChatMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.actionResult);
  writer.writeByte(offsets[1], object.actionStatus.index);
  writer.writeString(offsets[2], object.actionsJson);
  writer.writeLong(offsets[3], object.conversationId);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeByte(offsets[5], object.role.index);
  writer.writeString(offsets[6], object.text);
}

AiChatMessage _aiChatMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiChatMessage(
    actionResult: reader.readStringOrNull(offsets[0]),
    actionStatus:
        _AiChatMessageactionStatusValueEnumMap[reader.readByteOrNull(
          offsets[1],
        )] ??
        AiChatMessageActionStatus.none,
    actionsJson: reader.readStringOrNull(offsets[2]),
    conversationId: reader.readLong(offsets[3]),
    createdAt: reader.readDateTime(offsets[4]),
    id: id,
    role:
        _AiChatMessageroleValueEnumMap[reader.readByteOrNull(offsets[5])] ??
        AiChatMessageRole.user,
    text: reader.readString(offsets[6]),
  );
  return object;
}

P _aiChatMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (_AiChatMessageactionStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              AiChatMessageActionStatus.none)
          as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (_AiChatMessageroleValueEnumMap[reader.readByteOrNull(offset)] ??
              AiChatMessageRole.user)
          as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AiChatMessageactionStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'applying': 2,
  'applied': 3,
  'dismissed': 4,
  'failed': 5,
};
const _AiChatMessageactionStatusValueEnumMap = {
  0: AiChatMessageActionStatus.none,
  1: AiChatMessageActionStatus.pending,
  2: AiChatMessageActionStatus.applying,
  3: AiChatMessageActionStatus.applied,
  4: AiChatMessageActionStatus.dismissed,
  5: AiChatMessageActionStatus.failed,
};
const _AiChatMessageroleEnumValueMap = {'user': 0, 'assistant': 1};
const _AiChatMessageroleValueEnumMap = {
  0: AiChatMessageRole.user,
  1: AiChatMessageRole.assistant,
};

Id _aiChatMessageGetId(AiChatMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiChatMessageGetLinks(AiChatMessage object) {
  return [];
}

void _aiChatMessageAttach(
  IsarCollection<dynamic> col,
  Id id,
  AiChatMessage object,
) {
  object.id = id;
}

extension AiChatMessageQueryWhereSort
    on QueryBuilder<AiChatMessage, AiChatMessage, QWhere> {
  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhere> anyConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'conversationId'),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension AiChatMessageQueryWhere
    on QueryBuilder<AiChatMessage, AiChatMessage, QWhereClause> {
  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  conversationIdEqualTo(int conversationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'conversationId',
          value: [conversationId],
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  conversationIdNotEqualTo(int conversationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'conversationId',
                lower: [],
                upper: [conversationId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'conversationId',
                lower: [conversationId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'conversationId',
                lower: [conversationId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'conversationId',
                lower: [],
                upper: [conversationId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  conversationIdGreaterThan(int conversationId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'conversationId',
          lower: [conversationId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  conversationIdLessThan(int conversationId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'conversationId',
          lower: [],
          upper: [conversationId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  conversationIdBetween(
    int lowerConversationId,
    int upperConversationId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'conversationId',
          lower: [lowerConversationId],
          includeLower: includeLower,
          upper: [upperConversationId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
  createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterWhereClause>
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

extension AiChatMessageQueryFilter
    on QueryBuilder<AiChatMessage, AiChatMessage, QFilterCondition> {
  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'actionResult'),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'actionResult'),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actionResult',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'actionResult',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'actionResult',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actionResult', value: ''),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionResultIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'actionResult', value: ''),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionStatusEqualTo(AiChatMessageActionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actionStatus', value: value),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionStatusGreaterThan(
    AiChatMessageActionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actionStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionStatusLessThan(
    AiChatMessageActionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actionStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionStatusBetween(
    AiChatMessageActionStatus lower,
    AiChatMessageActionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actionStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'actionsJson'),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'actionsJson'),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actionsJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'actionsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'actionsJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actionsJson', value: ''),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  actionsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'actionsJson', value: ''),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  conversationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'conversationId', value: value),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  conversationIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'conversationId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  conversationIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'conversationId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  conversationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'conversationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> roleEqualTo(
    AiChatMessageRole value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'role', value: value),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  roleGreaterThan(AiChatMessageRole value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'role',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  roleLessThan(AiChatMessageRole value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'role',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> roleBetween(
    AiChatMessageRole lower,
    AiChatMessageRole upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'role',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'text',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition> textMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'text',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterFilterCondition>
  textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'text', value: ''),
      );
    });
  }
}

extension AiChatMessageQueryObject
    on QueryBuilder<AiChatMessage, AiChatMessage, QFilterCondition> {}

extension AiChatMessageQueryLinks
    on QueryBuilder<AiChatMessage, AiChatMessage, QFilterCondition> {}

extension AiChatMessageQuerySortBy
    on QueryBuilder<AiChatMessage, AiChatMessage, QSortBy> {
  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByActionResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionResult', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByActionResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionResult', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByActionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionStatus', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByActionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionStatus', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByActionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionsJson', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByActionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionsJson', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension AiChatMessageQuerySortThenBy
    on QueryBuilder<AiChatMessage, AiChatMessage, QSortThenBy> {
  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByActionResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionResult', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByActionResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionResult', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByActionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionStatus', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByActionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionStatus', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByActionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionsJson', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByActionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionsJson', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByConversationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationId', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension AiChatMessageQueryWhereDistinct
    on QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> {
  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> distinctByActionResult({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actionResult', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct>
  distinctByActionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actionStatus');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> distinctByActionsJson({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actionsJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct>
  distinctByConversationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationId');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> distinctByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessage, QDistinct> distinctByText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension AiChatMessageQueryProperty
    on QueryBuilder<AiChatMessage, AiChatMessage, QQueryProperty> {
  QueryBuilder<AiChatMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiChatMessage, String?, QQueryOperations>
  actionResultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actionResult');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessageActionStatus, QQueryOperations>
  actionStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actionStatus');
    });
  }

  QueryBuilder<AiChatMessage, String?, QQueryOperations> actionsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actionsJson');
    });
  }

  QueryBuilder<AiChatMessage, int, QQueryOperations> conversationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationId');
    });
  }

  QueryBuilder<AiChatMessage, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AiChatMessage, AiChatMessageRole, QQueryOperations>
  roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<AiChatMessage, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
