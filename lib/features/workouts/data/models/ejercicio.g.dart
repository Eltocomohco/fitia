// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ejercicio.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEjercicioCollection on Isar {
  IsarCollection<Ejercicio> get ejercicios => this.collection();
}

const EjercicioSchema = CollectionSchema(
  name: r'Ejercicio',
  id: -9210230272693599240,
  properties: {
    r'descripcionBreve': PropertySchema(
      id: 0,
      name: r'descripcionBreve',
      type: IsarType.string,
    ),
    r'grupoMuscular': PropertySchema(
      id: 1,
      name: r'grupoMuscular',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(id: 2, name: r'nombre', type: IsarType.string),
    r'tiempoDescansoBaseSegundos': PropertySchema(
      id: 3,
      name: r'tiempoDescansoBaseSegundos',
      type: IsarType.long,
    ),
    r'tipoEjercicio': PropertySchema(
      id: 4,
      name: r'tipoEjercicio',
      type: IsarType.string,
      enumMap: _EjerciciotipoEjercicioEnumValueMap,
    ),
  },

  estimateSize: _ejercicioEstimateSize,
  serialize: _ejercicioSerialize,
  deserialize: _ejercicioDeserialize,
  deserializeProp: _ejercicioDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _ejercicioGetId,
  getLinks: _ejercicioGetLinks,
  attach: _ejercicioAttach,
  version: '3.3.2',
);

int _ejercicioEstimateSize(
  Ejercicio object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descripcionBreve;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.grupoMuscular.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.tipoEjercicio.name.length * 3;
  return bytesCount;
}

void _ejercicioSerialize(
  Ejercicio object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.descripcionBreve);
  writer.writeString(offsets[1], object.grupoMuscular);
  writer.writeString(offsets[2], object.nombre);
  writer.writeLong(offsets[3], object.tiempoDescansoBaseSegundos);
  writer.writeString(offsets[4], object.tipoEjercicio.name);
}

Ejercicio _ejercicioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Ejercicio(
    descripcionBreve: reader.readStringOrNull(offsets[0]),
    grupoMuscular: reader.readString(offsets[1]),
    id: id,
    nombre: reader.readString(offsets[2]),
    tiempoDescansoBaseSegundos: reader.readLong(offsets[3]),
    tipoEjercicio:
        _EjerciciotipoEjercicioValueEnumMap[reader.readStringOrNull(
          offsets[4],
        )] ??
        TipoEjercicio.fuerza,
  );
  return object;
}

P _ejercicioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (_EjerciciotipoEjercicioValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              TipoEjercicio.fuerza)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EjerciciotipoEjercicioEnumValueMap = {
  r'movilidad': r'movilidad',
  r'fuerza': r'fuerza',
  r'estiramiento': r'estiramiento',
};
const _EjerciciotipoEjercicioValueEnumMap = {
  r'movilidad': TipoEjercicio.movilidad,
  r'fuerza': TipoEjercicio.fuerza,
  r'estiramiento': TipoEjercicio.estiramiento,
};

Id _ejercicioGetId(Ejercicio object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ejercicioGetLinks(Ejercicio object) {
  return [];
}

void _ejercicioAttach(IsarCollection<dynamic> col, Id id, Ejercicio object) {
  object.id = id;
}

extension EjercicioQueryWhereSort
    on QueryBuilder<Ejercicio, Ejercicio, QWhere> {
  QueryBuilder<Ejercicio, Ejercicio, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EjercicioQueryWhere
    on QueryBuilder<Ejercicio, Ejercicio, QWhereClause> {
  QueryBuilder<Ejercicio, Ejercicio, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterWhereClause> idBetween(
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

extension EjercicioQueryFilter
    on QueryBuilder<Ejercicio, Ejercicio, QFilterCondition> {
  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'descripcionBreve'),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'descripcionBreve'),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'descripcionBreve',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'descripcionBreve',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'descripcionBreve',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'descripcionBreve', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  descripcionBreveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'descripcionBreve', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'grupoMuscular',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'grupoMuscular',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'grupoMuscular',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'grupoMuscular', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  grupoMuscularIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'grupoMuscular', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreGreaterThan(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreContains(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tiempoDescansoBaseSegundosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tiempoDescansoBaseSegundos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tiempoDescansoBaseSegundosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tiempoDescansoBaseSegundos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tiempoDescansoBaseSegundosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tiempoDescansoBaseSegundos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tiempoDescansoBaseSegundosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tiempoDescansoBaseSegundos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioEqualTo(TipoEjercicio value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioGreaterThan(
    TipoEjercicio value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioLessThan(
    TipoEjercicio value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioBetween(
    TipoEjercicio lower,
    TipoEjercicio upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipoEjercicio',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tipoEjercicio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tipoEjercicio',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipoEjercicio', value: ''),
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterFilterCondition>
  tipoEjercicioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tipoEjercicio', value: ''),
      );
    });
  }
}

extension EjercicioQueryObject
    on QueryBuilder<Ejercicio, Ejercicio, QFilterCondition> {}

extension EjercicioQueryLinks
    on QueryBuilder<Ejercicio, Ejercicio, QFilterCondition> {}

extension EjercicioQuerySortBy on QueryBuilder<Ejercicio, Ejercicio, QSortBy> {
  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByDescripcionBreve() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcionBreve', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  sortByDescripcionBreveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcionBreve', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByGrupoMuscular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoMuscular', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByGrupoMuscularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoMuscular', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  sortByTiempoDescansoBaseSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoDescansoBaseSegundos', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  sortByTiempoDescansoBaseSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoDescansoBaseSegundos', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByTipoEjercicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEjercicio', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> sortByTipoEjercicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEjercicio', Sort.desc);
    });
  }
}

extension EjercicioQuerySortThenBy
    on QueryBuilder<Ejercicio, Ejercicio, QSortThenBy> {
  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByDescripcionBreve() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcionBreve', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  thenByDescripcionBreveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcionBreve', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByGrupoMuscular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoMuscular', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByGrupoMuscularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoMuscular', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  thenByTiempoDescansoBaseSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoDescansoBaseSegundos', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy>
  thenByTiempoDescansoBaseSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoDescansoBaseSegundos', Sort.desc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByTipoEjercicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEjercicio', Sort.asc);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QAfterSortBy> thenByTipoEjercicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoEjercicio', Sort.desc);
    });
  }
}

extension EjercicioQueryWhereDistinct
    on QueryBuilder<Ejercicio, Ejercicio, QDistinct> {
  QueryBuilder<Ejercicio, Ejercicio, QDistinct> distinctByDescripcionBreve({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'descripcionBreve',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QDistinct> distinctByGrupoMuscular({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'grupoMuscular',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QDistinct>
  distinctByTiempoDescansoBaseSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoDescansoBaseSegundos');
    });
  }

  QueryBuilder<Ejercicio, Ejercicio, QDistinct> distinctByTipoEjercicio({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tipoEjercicio',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension EjercicioQueryProperty
    on QueryBuilder<Ejercicio, Ejercicio, QQueryProperty> {
  QueryBuilder<Ejercicio, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Ejercicio, String?, QQueryOperations>
  descripcionBreveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcionBreve');
    });
  }

  QueryBuilder<Ejercicio, String, QQueryOperations> grupoMuscularProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grupoMuscular');
    });
  }

  QueryBuilder<Ejercicio, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<Ejercicio, int, QQueryOperations>
  tiempoDescansoBaseSegundosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoDescansoBaseSegundos');
    });
  }

  QueryBuilder<Ejercicio, TipoEjercicio, QQueryOperations>
  tipoEjercicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoEjercicio');
    });
  }
}
