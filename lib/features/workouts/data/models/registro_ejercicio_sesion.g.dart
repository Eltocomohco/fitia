// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_ejercicio_sesion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroEjercicioSesionCollection on Isar {
  IsarCollection<RegistroEjercicioSesion> get registrosEjercicioSesion =>
      this.collection();
}

const RegistroEjercicioSesionSchema = CollectionSchema(
  name: r'RegistroEjercicioSesion',
  id: -1971051789207092540,
  properties: {
    r'orden': PropertySchema(id: 0, name: r'orden', type: IsarType.long),
    r'sensacion': PropertySchema(
      id: 1,
      name: r'sensacion',
      type: IsarType.string,
      enumMap: _RegistroEjercicioSesionsensacionEnumValueMap,
    ),
  },

  estimateSize: _registroEjercicioSesionEstimateSize,
  serialize: _registroEjercicioSesionSerialize,
  deserialize: _registroEjercicioSesionDeserialize,
  deserializeProp: _registroEjercicioSesionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'sesion': LinkSchema(
      id: -767472604282161204,
      name: r'sesion',
      target: r'SesionEntrenamiento',
      single: true,
    ),
    r'ejercicio': LinkSchema(
      id: 4568781065568764568,
      name: r'ejercicio',
      target: r'Ejercicio',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _registroEjercicioSesionGetId,
  getLinks: _registroEjercicioSesionGetLinks,
  attach: _registroEjercicioSesionAttach,
  version: '3.3.2',
);

int _registroEjercicioSesionEstimateSize(
  RegistroEjercicioSesion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sensacion.name.length * 3;
  return bytesCount;
}

void _registroEjercicioSesionSerialize(
  RegistroEjercicioSesion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.orden);
  writer.writeString(offsets[1], object.sensacion.name);
}

RegistroEjercicioSesion _registroEjercicioSesionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroEjercicioSesion(
    id: id,
    orden: reader.readLong(offsets[0]),
    sensacion:
        _RegistroEjercicioSesionsensacionValueEnumMap[reader.readStringOrNull(
          offsets[1],
        )] ??
        SensacionEjercicio.normal,
  );
  return object;
}

P _registroEjercicioSesionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (_RegistroEjercicioSesionsensacionValueEnumMap[reader
                  .readStringOrNull(offset)] ??
              SensacionEjercicio.normal)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RegistroEjercicioSesionsensacionEnumValueMap = {
  r'muyMala': r'muyMala',
  r'mala': r'mala',
  r'normal': r'normal',
  r'buena': r'buena',
  r'excelente': r'excelente',
};
const _RegistroEjercicioSesionsensacionValueEnumMap = {
  r'muyMala': SensacionEjercicio.muyMala,
  r'mala': SensacionEjercicio.mala,
  r'normal': SensacionEjercicio.normal,
  r'buena': SensacionEjercicio.buena,
  r'excelente': SensacionEjercicio.excelente,
};

Id _registroEjercicioSesionGetId(RegistroEjercicioSesion object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroEjercicioSesionGetLinks(
  RegistroEjercicioSesion object,
) {
  return [object.sesion, object.ejercicio];
}

void _registroEjercicioSesionAttach(
  IsarCollection<dynamic> col,
  Id id,
  RegistroEjercicioSesion object,
) {
  object.id = id;
  object.sesion.attach(
    col,
    col.isar.collection<SesionEntrenamiento>(),
    r'sesion',
    id,
  );
  object.ejercicio.attach(
    col,
    col.isar.collection<Ejercicio>(),
    r'ejercicio',
    id,
  );
}

extension RegistroEjercicioSesionQueryWhereSort
    on QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QWhere> {
  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RegistroEjercicioSesionQueryWhere
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QWhereClause
        > {
  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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

extension RegistroEjercicioSesionQueryFilter
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QFilterCondition
        > {
  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ordenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orden', value: value),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ordenGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'orden',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ordenLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'orden',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ordenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'orden',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionEqualTo(SensacionEjercicio value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionGreaterThan(
    SensacionEjercicio value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionLessThan(
    SensacionEjercicio value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionBetween(
    SensacionEjercicio lower,
    SensacionEjercicio upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sensacion',
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
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sensacion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sensacion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sensacion', value: ''),
      );
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sensacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sensacion', value: ''),
      );
    });
  }
}

extension RegistroEjercicioSesionQueryObject
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QFilterCondition
        > {}

extension RegistroEjercicioSesionQueryLinks
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QFilterCondition
        > {
  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sesion(FilterQuery<SesionEntrenamiento> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sesion');
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  sesionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sesion', 0, true, 0, true);
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ejercicio(FilterQuery<Ejercicio> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ejercicio');
    });
  }

  QueryBuilder<
    RegistroEjercicioSesion,
    RegistroEjercicioSesion,
    QAfterFilterCondition
  >
  ejercicioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ejercicio', 0, true, 0, true);
    });
  }
}

extension RegistroEjercicioSesionQuerySortBy
    on QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QSortBy> {
  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  sortByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  sortByOrdenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  sortBySensacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  sortBySensacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.desc);
    });
  }
}

extension RegistroEjercicioSesionQuerySortThenBy
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QSortThenBy
        > {
  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenByOrdenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orden', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenBySensacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QAfterSortBy>
  thenBySensacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.desc);
    });
  }
}

extension RegistroEjercicioSesionQueryWhereDistinct
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QDistinct
        > {
  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QDistinct>
  distinctByOrden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orden');
    });
  }

  QueryBuilder<RegistroEjercicioSesion, RegistroEjercicioSesion, QDistinct>
  distinctBySensacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensacion', caseSensitive: caseSensitive);
    });
  }
}

extension RegistroEjercicioSesionQueryProperty
    on
        QueryBuilder<
          RegistroEjercicioSesion,
          RegistroEjercicioSesion,
          QQueryProperty
        > {
  QueryBuilder<RegistroEjercicioSesion, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroEjercicioSesion, int, QQueryOperations> ordenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orden');
    });
  }

  QueryBuilder<RegistroEjercicioSesion, SensacionEjercicio, QQueryOperations>
  sensacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensacion');
    });
  }
}
