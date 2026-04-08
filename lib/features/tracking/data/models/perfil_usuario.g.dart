// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_usuario.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPerfilUsuarioCollection on Isar {
  IsarCollection<PerfilUsuario> get perfilesUsuario => this.collection();
}

const PerfilUsuarioSchema = CollectionSchema(
  name: r'PerfilUsuario',
  id: -1854772830458305577,
  properties: {
    r'alturaCm': PropertySchema(
      id: 0,
      name: r'alturaCm',
      type: IsarType.double,
    ),
    r'edad': PropertySchema(id: 1, name: r'edad', type: IsarType.long),
    r'genero': PropertySchema(id: 2, name: r'genero', type: IsarType.string),
  },

  estimateSize: _perfilUsuarioEstimateSize,
  serialize: _perfilUsuarioSerialize,
  deserialize: _perfilUsuarioDeserialize,
  deserializeProp: _perfilUsuarioDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _perfilUsuarioGetId,
  getLinks: _perfilUsuarioGetLinks,
  attach: _perfilUsuarioAttach,
  version: '3.3.2',
);

int _perfilUsuarioEstimateSize(
  PerfilUsuario object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.genero.length * 3;
  return bytesCount;
}

void _perfilUsuarioSerialize(
  PerfilUsuario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.alturaCm);
  writer.writeLong(offsets[1], object.edad);
  writer.writeString(offsets[2], object.genero);
}

PerfilUsuario _perfilUsuarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PerfilUsuario(
    alturaCm: reader.readDoubleOrNull(offsets[0]) ?? 176.0,
    edad: reader.readLongOrNull(offsets[1]) ?? 34,
    genero: reader.readStringOrNull(offsets[2]) ?? '',
    id: id,
  );
  return object;
}

P _perfilUsuarioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 176.0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 34) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _perfilUsuarioGetId(PerfilUsuario object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _perfilUsuarioGetLinks(PerfilUsuario object) {
  return [];
}

void _perfilUsuarioAttach(
  IsarCollection<dynamic> col,
  Id id,
  PerfilUsuario object,
) {
  object.id = id;
}

extension PerfilUsuarioQueryWhereSort
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QWhere> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PerfilUsuarioQueryWhere
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QWhereClause> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterWhereClause> idBetween(
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

extension PerfilUsuarioQueryFilter
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QFilterCondition> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alturaCmEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'alturaCm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alturaCmGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alturaCm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alturaCmLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alturaCm',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alturaCmBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alturaCm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition> edadEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'edad', value: value),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  edadGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'edad',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  edadLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'edad',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition> edadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'edad',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'genero',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'genero',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'genero',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'genero', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  generoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'genero', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition> idBetween(
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
}

extension PerfilUsuarioQueryObject
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QFilterCondition> {}

extension PerfilUsuarioQueryLinks
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QFilterCondition> {}

extension PerfilUsuarioQuerySortBy
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QSortBy> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByAlturaCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alturaCm', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAlturaCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alturaCm', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByEdad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edad', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByEdadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edad', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByGenero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genero', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByGeneroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genero', Sort.desc);
    });
  }
}

extension PerfilUsuarioQuerySortThenBy
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QSortThenBy> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByAlturaCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alturaCm', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAlturaCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alturaCm', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByEdad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edad', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByEdadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edad', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByGenero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genero', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByGeneroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genero', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension PerfilUsuarioQueryWhereDistinct
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByAlturaCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alturaCm');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByEdad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edad');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByGenero({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genero', caseSensitive: caseSensitive);
    });
  }
}

extension PerfilUsuarioQueryProperty
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QQueryProperty> {
  QueryBuilder<PerfilUsuario, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PerfilUsuario, double, QQueryOperations> alturaCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alturaCm');
    });
  }

  QueryBuilder<PerfilUsuario, int, QQueryOperations> edadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edad');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations> generoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genero');
    });
  }
}
