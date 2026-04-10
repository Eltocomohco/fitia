// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationPreferencesCollection on Isar {
  IsarCollection<NotificationPreferences> get notificationPreferences =>
      this.collection();
}

const NotificationPreferencesSchema = CollectionSchema(
  name: r'NotificationPreferences',
  id: 4550166405663651190,
  properties: {
    r'dinnerPlanningEnabled': PropertySchema(
      id: 0,
      name: r'dinnerPlanningEnabled',
      type: IsarType.bool,
    ),
    r'dinnerPlanningMinutes': PropertySchema(
      id: 1,
      name: r'dinnerPlanningMinutes',
      type: IsarType.long,
    ),
    r'goalsReviewEnabled': PropertySchema(
      id: 2,
      name: r'goalsReviewEnabled',
      type: IsarType.bool,
    ),
    r'goalsReviewMinutes': PropertySchema(
      id: 3,
      name: r'goalsReviewMinutes',
      type: IsarType.long,
    ),
    r'mealLoggingEnabled': PropertySchema(
      id: 4,
      name: r'mealLoggingEnabled',
      type: IsarType.bool,
    ),
    r'mealLoggingMinutes': PropertySchema(
      id: 5,
      name: r'mealLoggingMinutes',
      type: IsarType.long,
    ),
    r'mealPrepEnabled': PropertySchema(
      id: 6,
      name: r'mealPrepEnabled',
      type: IsarType.bool,
    ),
    r'mealPrepMinutes': PropertySchema(
      id: 7,
      name: r'mealPrepMinutes',
      type: IsarType.long,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 8,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'quietHoursEndMinutes': PropertySchema(
      id: 9,
      name: r'quietHoursEndMinutes',
      type: IsarType.long,
    ),
    r'quietHoursStartMinutes': PropertySchema(
      id: 10,
      name: r'quietHoursStartMinutes',
      type: IsarType.long,
    ),
    r'shoppingEnabled': PropertySchema(
      id: 11,
      name: r'shoppingEnabled',
      type: IsarType.bool,
    ),
    r'shoppingMinutes': PropertySchema(
      id: 12,
      name: r'shoppingMinutes',
      type: IsarType.long,
    ),
    r'waterEnabled': PropertySchema(
      id: 13,
      name: r'waterEnabled',
      type: IsarType.bool,
    ),
    r'waterIntervalHours': PropertySchema(
      id: 14,
      name: r'waterIntervalHours',
      type: IsarType.long,
    ),
    r'workoutEnabled': PropertySchema(
      id: 15,
      name: r'workoutEnabled',
      type: IsarType.bool,
    ),
    r'workoutMinutes': PropertySchema(
      id: 16,
      name: r'workoutMinutes',
      type: IsarType.long,
    ),
  },

  estimateSize: _notificationPreferencesEstimateSize,
  serialize: _notificationPreferencesSerialize,
  deserialize: _notificationPreferencesDeserialize,
  deserializeProp: _notificationPreferencesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _notificationPreferencesGetId,
  getLinks: _notificationPreferencesGetLinks,
  attach: _notificationPreferencesAttach,
  version: '3.3.2',
);

int _notificationPreferencesEstimateSize(
  NotificationPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _notificationPreferencesSerialize(
  NotificationPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.dinnerPlanningEnabled);
  writer.writeLong(offsets[1], object.dinnerPlanningMinutes);
  writer.writeBool(offsets[2], object.goalsReviewEnabled);
  writer.writeLong(offsets[3], object.goalsReviewMinutes);
  writer.writeBool(offsets[4], object.mealLoggingEnabled);
  writer.writeLong(offsets[5], object.mealLoggingMinutes);
  writer.writeBool(offsets[6], object.mealPrepEnabled);
  writer.writeLong(offsets[7], object.mealPrepMinutes);
  writer.writeBool(offsets[8], object.notificationsEnabled);
  writer.writeLong(offsets[9], object.quietHoursEndMinutes);
  writer.writeLong(offsets[10], object.quietHoursStartMinutes);
  writer.writeBool(offsets[11], object.shoppingEnabled);
  writer.writeLong(offsets[12], object.shoppingMinutes);
  writer.writeBool(offsets[13], object.waterEnabled);
  writer.writeLong(offsets[14], object.waterIntervalHours);
  writer.writeBool(offsets[15], object.workoutEnabled);
  writer.writeLong(offsets[16], object.workoutMinutes);
}

NotificationPreferences _notificationPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationPreferences(
    dinnerPlanningEnabled: reader.readBoolOrNull(offsets[0]) ?? true,
    dinnerPlanningMinutes: reader.readLongOrNull(offsets[1]) ?? 20 * 60 + 30,
    goalsReviewEnabled: reader.readBoolOrNull(offsets[2]) ?? true,
    goalsReviewMinutes: reader.readLongOrNull(offsets[3]) ?? 21 * 60 + 45,
    id: id,
    mealLoggingEnabled: reader.readBoolOrNull(offsets[4]) ?? false,
    mealLoggingMinutes: reader.readLongOrNull(offsets[5]) ?? 14 * 60 + 30,
    mealPrepEnabled: reader.readBoolOrNull(offsets[6]) ?? true,
    mealPrepMinutes: reader.readLongOrNull(offsets[7]) ?? 21 * 60,
    notificationsEnabled: reader.readBoolOrNull(offsets[8]) ?? false,
    quietHoursEndMinutes: reader.readLongOrNull(offsets[9]) ?? 8 * 60,
    quietHoursStartMinutes: reader.readLongOrNull(offsets[10]) ?? 22 * 60,
    shoppingEnabled: reader.readBoolOrNull(offsets[11]) ?? false,
    shoppingMinutes: reader.readLongOrNull(offsets[12]) ?? 19 * 60 + 30,
    waterEnabled: reader.readBoolOrNull(offsets[13]) ?? true,
    waterIntervalHours: reader.readLongOrNull(offsets[14]) ?? 2,
    workoutEnabled: reader.readBoolOrNull(offsets[15]) ?? false,
    workoutMinutes: reader.readLongOrNull(offsets[16]) ?? 18 * 60,
  );
  return object;
}

P _notificationPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 20 * 60 + 30) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 21 * 60 + 45) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 14 * 60 + 30) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 21 * 60) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 8 * 60) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 22 * 60) as P;
    case 11:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 12:
      return (reader.readLongOrNull(offset) ?? 19 * 60 + 30) as P;
    case 13:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 14:
      return (reader.readLongOrNull(offset) ?? 2) as P;
    case 15:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 16:
      return (reader.readLongOrNull(offset) ?? 18 * 60) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notificationPreferencesGetId(NotificationPreferences object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationPreferencesGetLinks(
  NotificationPreferences object,
) {
  return [];
}

void _notificationPreferencesAttach(
  IsarCollection<dynamic> col,
  Id id,
  NotificationPreferences object,
) {
  object.id = id;
}

extension NotificationPreferencesQueryWhereSort
    on QueryBuilder<NotificationPreferences, NotificationPreferences, QWhere> {
  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationPreferencesQueryWhere
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QWhereClause
        > {
  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterWhereClause
  >
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

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterWhereClause
  >
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

extension NotificationPreferencesQueryFilter
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QFilterCondition
        > {
  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  dinnerPlanningEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dinnerPlanningEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  dinnerPlanningMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dinnerPlanningMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  dinnerPlanningMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dinnerPlanningMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  dinnerPlanningMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dinnerPlanningMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  dinnerPlanningMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dinnerPlanningMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  goalsReviewEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'goalsReviewEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  goalsReviewMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'goalsReviewMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  goalsReviewMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'goalsReviewMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  goalsReviewMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'goalsReviewMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  goalsReviewMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'goalsReviewMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
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
    NotificationPreferences,
    NotificationPreferences,
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
    NotificationPreferences,
    NotificationPreferences,
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
    NotificationPreferences,
    NotificationPreferences,
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
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealLoggingEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mealLoggingEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealLoggingMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mealLoggingMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealLoggingMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mealLoggingMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealLoggingMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mealLoggingMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealLoggingMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mealLoggingMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealPrepEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mealPrepEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealPrepMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mealPrepMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealPrepMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mealPrepMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealPrepMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mealPrepMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  mealPrepMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mealPrepMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notificationsEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursEndMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'quietHoursEndMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursEndMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quietHoursEndMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursEndMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quietHoursEndMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursEndMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quietHoursEndMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursStartMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'quietHoursStartMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursStartMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quietHoursStartMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursStartMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quietHoursStartMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  quietHoursStartMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quietHoursStartMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  shoppingEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'shoppingEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  shoppingMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'shoppingMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  shoppingMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'shoppingMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  shoppingMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'shoppingMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  shoppingMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'shoppingMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  waterEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waterEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  waterIntervalHoursEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waterIntervalHours', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  waterIntervalHoursGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waterIntervalHours',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  waterIntervalHoursLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waterIntervalHours',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  waterIntervalHoursBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waterIntervalHours',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  workoutEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'workoutEnabled', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  workoutMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'workoutMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  workoutMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workoutMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  workoutMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workoutMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    NotificationPreferences,
    NotificationPreferences,
    QAfterFilterCondition
  >
  workoutMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workoutMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension NotificationPreferencesQueryObject
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QFilterCondition
        > {}

extension NotificationPreferencesQueryLinks
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QFilterCondition
        > {}

extension NotificationPreferencesQuerySortBy
    on QueryBuilder<NotificationPreferences, NotificationPreferences, QSortBy> {
  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByDinnerPlanningEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByDinnerPlanningEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByDinnerPlanningMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByDinnerPlanningMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByGoalsReviewEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByGoalsReviewEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByGoalsReviewMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByGoalsReviewMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealLoggingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealLoggingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealLoggingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealLoggingMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealPrepEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealPrepEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealPrepMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByMealPrepMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByQuietHoursEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByQuietHoursEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByQuietHoursStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByQuietHoursStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByShoppingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByShoppingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByShoppingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByShoppingMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWaterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWaterEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWaterIntervalHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalHours', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWaterIntervalHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalHours', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWorkoutEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWorkoutEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWorkoutMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  sortByWorkoutMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutMinutes', Sort.desc);
    });
  }
}

extension NotificationPreferencesQuerySortThenBy
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QSortThenBy
        > {
  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByDinnerPlanningEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByDinnerPlanningEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByDinnerPlanningMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByDinnerPlanningMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerPlanningMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByGoalsReviewEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByGoalsReviewEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByGoalsReviewMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByGoalsReviewMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsReviewMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealLoggingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealLoggingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealLoggingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealLoggingMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealLoggingMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealPrepEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealPrepEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealPrepMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByMealPrepMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealPrepMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByQuietHoursEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByQuietHoursEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByQuietHoursStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByQuietHoursStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByShoppingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByShoppingEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByShoppingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByShoppingMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shoppingMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWaterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWaterEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWaterIntervalHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalHours', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWaterIntervalHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalHours', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWorkoutEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutEnabled', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWorkoutEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutEnabled', Sort.desc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWorkoutMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QAfterSortBy>
  thenByWorkoutMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutMinutes', Sort.desc);
    });
  }
}

extension NotificationPreferencesQueryWhereDistinct
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QDistinct
        > {
  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByDinnerPlanningEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dinnerPlanningEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByDinnerPlanningMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dinnerPlanningMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByGoalsReviewEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsReviewEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByGoalsReviewMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsReviewMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByMealLoggingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealLoggingEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByMealLoggingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealLoggingMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByMealPrepEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealPrepEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByMealPrepMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealPrepMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByQuietHoursEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursEndMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByQuietHoursStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursStartMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByShoppingEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shoppingEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByShoppingMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shoppingMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByWaterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByWaterIntervalHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterIntervalHours');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByWorkoutEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, NotificationPreferences, QDistinct>
  distinctByWorkoutMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutMinutes');
    });
  }
}

extension NotificationPreferencesQueryProperty
    on
        QueryBuilder<
          NotificationPreferences,
          NotificationPreferences,
          QQueryProperty
        > {
  QueryBuilder<NotificationPreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  dinnerPlanningEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dinnerPlanningEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  dinnerPlanningMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dinnerPlanningMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  goalsReviewEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsReviewEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  goalsReviewMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsReviewMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  mealLoggingEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealLoggingEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  mealLoggingMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealLoggingMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  mealPrepEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealPrepEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  mealPrepMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealPrepMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  quietHoursEndMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursEndMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  quietHoursStartMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursStartMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  shoppingEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shoppingEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  shoppingMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shoppingMinutes');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  waterEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  waterIntervalHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterIntervalHours');
    });
  }

  QueryBuilder<NotificationPreferences, bool, QQueryOperations>
  workoutEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutEnabled');
    });
  }

  QueryBuilder<NotificationPreferences, int, QQueryOperations>
  workoutMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutMinutes');
    });
  }
}
