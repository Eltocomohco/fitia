// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rutina_plantilla.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRutinaPlantillaCollection on Isar {
  IsarCollection<RutinaPlantilla> get rutinasPlantilla => this.collection();
}

const RutinaPlantillaSchema = CollectionSchema(
  name: r'RutinaPlantilla',
  id: -2726288283229102126,
  properties: {
    r'nombre': PropertySchema(id: 0, name: r'nombre', type: IsarType.string),
  },

  estimateSize: _rutinaPlantillaEstimateSize,
  serialize: _rutinaPlantillaSerialize,
  deserialize: _rutinaPlantillaDeserialize,
  deserializeProp: _rutinaPlantillaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _rutinaPlantillaGetId,
  getLinks: _rutinaPlantillaGetLinks,
  attach: _rutinaPlantillaAttach,
  version: '3.3.2',
);

int _rutinaPlantillaEstimateSize(
  RutinaPlantilla object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _rutinaPlantillaSerialize(
  RutinaPlantilla object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nombre);
}

RutinaPlantilla _rutinaPlantillaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RutinaPlantilla(id: id, nombre: reader.readString(offsets[0]));
  return object;
}

P _rutinaPlantillaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rutinaPlantillaGetId(RutinaPlantilla object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rutinaPlantillaGetLinks(RutinaPlantilla object) {
  return [];
}

void _rutinaPlantillaAttach(
  IsarCollection<dynamic> col,
  Id id,
  RutinaPlantilla object,
) {
  object.id = id;
}

extension RutinaPlantillaQueryWhereSort
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QWhere> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RutinaPlantillaQueryWhere
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QWhereClause> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhereClause>
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

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterWhereClause> idBetween(
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

extension RutinaPlantillaQueryFilter
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QFilterCondition> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
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

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
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

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
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

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nombre',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nombre',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nombre',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterFilterCondition>
  nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }
}

extension RutinaPlantillaQueryObject
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QFilterCondition> {}

extension RutinaPlantillaQueryLinks
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QFilterCondition> {}

extension RutinaPlantillaQuerySortBy
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QSortBy> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy>
  sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension RutinaPlantillaQuerySortThenBy
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QSortThenBy> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QAfterSortBy>
  thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension RutinaPlantillaQueryWhereDistinct
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QDistinct> {
  QueryBuilder<RutinaPlantilla, RutinaPlantilla, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension RutinaPlantillaQueryProperty
    on QueryBuilder<RutinaPlantilla, RutinaPlantilla, QQueryProperty> {
  QueryBuilder<RutinaPlantilla, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RutinaPlantilla, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}
