// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingrediente_receta.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIngredienteRecetaCollection on Isar {
  IsarCollection<IngredienteReceta> get ingredientesReceta => this.collection();
}

const IngredienteRecetaSchema = CollectionSchema(
  name: r'IngredienteReceta',
  id: -9076123329338597482,
  properties: {
    r'cantidadGramos': PropertySchema(
      id: 0,
      name: r'cantidadGramos',
      type: IsarType.double,
    ),
    r'grupo': PropertySchema(
      id: 1,
      name: r'grupo',
      type: IsarType.string,
      enumMap: _IngredienteRecetagrupoEnumValueMap,
    ),
  },

  estimateSize: _ingredienteRecetaEstimateSize,
  serialize: _ingredienteRecetaSerialize,
  deserialize: _ingredienteRecetaDeserialize,
  deserializeProp: _ingredienteRecetaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'alimento': LinkSchema(
      id: 3163585339664807566,
      name: r'alimento',
      target: r'Alimento',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _ingredienteRecetaGetId,
  getLinks: _ingredienteRecetaGetLinks,
  attach: _ingredienteRecetaAttach,
  version: '3.3.2',
);

int _ingredienteRecetaEstimateSize(
  IngredienteReceta object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.grupo.name.length * 3;
  return bytesCount;
}

void _ingredienteRecetaSerialize(
  IngredienteReceta object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadGramos);
  writer.writeString(offsets[1], object.grupo.name);
}

IngredienteReceta _ingredienteRecetaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IngredienteReceta(
    cantidadGramos: reader.readDouble(offsets[0]),
    grupo:
        _IngredienteRecetagrupoValueEnumMap[reader.readStringOrNull(
          offsets[1],
        )] ??
        GrupoComponenteReceta.principal,
    id: id,
  );
  return object;
}

P _ingredienteRecetaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (_IngredienteRecetagrupoValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              GrupoComponenteReceta.principal)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IngredienteRecetagrupoEnumValueMap = {
  r'principal': r'principal',
  r'vegetal': r'vegetal',
  r'anadido': r'anadido',
};
const _IngredienteRecetagrupoValueEnumMap = {
  r'principal': GrupoComponenteReceta.principal,
  r'vegetal': GrupoComponenteReceta.vegetal,
  r'anadido': GrupoComponenteReceta.anadido,
};

Id _ingredienteRecetaGetId(IngredienteReceta object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ingredienteRecetaGetLinks(
  IngredienteReceta object,
) {
  return [object.alimento];
}

void _ingredienteRecetaAttach(
  IsarCollection<dynamic> col,
  Id id,
  IngredienteReceta object,
) {
  object.id = id;
  object.alimento.attach(col, col.isar.collection<Alimento>(), r'alimento', id);
}

extension IngredienteRecetaQueryWhereSort
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QWhere> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IngredienteRecetaQueryWhere
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QWhereClause> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhereClause>
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

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterWhereClause>
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

extension IngredienteRecetaQueryFilter
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QFilterCondition> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  cantidadGramosEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cantidadGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  cantidadGramosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cantidadGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  cantidadGramosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cantidadGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  cantidadGramosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cantidadGramos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoEqualTo(GrupoComponenteReceta value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoGreaterThan(
    GrupoComponenteReceta value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoLessThan(
    GrupoComponenteReceta value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoBetween(
    GrupoComponenteReceta lower,
    GrupoComponenteReceta upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grupo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'grupo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'grupo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'grupo', value: ''),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  grupoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'grupo', value: ''),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
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

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
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

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
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
}

extension IngredienteRecetaQueryObject
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QFilterCondition> {}

extension IngredienteRecetaQueryLinks
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QFilterCondition> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  alimento(FilterQuery<Alimento> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'alimento');
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterFilterCondition>
  alimentoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'alimento', 0, true, 0, true);
    });
  }
}

extension IngredienteRecetaQuerySortBy
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QSortBy> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  sortByCantidadGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadGramos', Sort.asc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  sortByCantidadGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadGramos', Sort.desc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  sortByGrupo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupo', Sort.asc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  sortByGrupoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupo', Sort.desc);
    });
  }
}

extension IngredienteRecetaQuerySortThenBy
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QSortThenBy> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  thenByCantidadGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadGramos', Sort.asc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  thenByCantidadGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadGramos', Sort.desc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  thenByGrupo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupo', Sort.asc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  thenByGrupoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupo', Sort.desc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension IngredienteRecetaQueryWhereDistinct
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QDistinct> {
  QueryBuilder<IngredienteReceta, IngredienteReceta, QDistinct>
  distinctByCantidadGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadGramos');
    });
  }

  QueryBuilder<IngredienteReceta, IngredienteReceta, QDistinct>
  distinctByGrupo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grupo', caseSensitive: caseSensitive);
    });
  }
}

extension IngredienteRecetaQueryProperty
    on QueryBuilder<IngredienteReceta, IngredienteReceta, QQueryProperty> {
  QueryBuilder<IngredienteReceta, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IngredienteReceta, double, QQueryOperations>
  cantidadGramosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadGramos');
    });
  }

  QueryBuilder<IngredienteReceta, GrupoComponenteReceta, QQueryOperations>
  grupoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grupo');
    });
  }
}
