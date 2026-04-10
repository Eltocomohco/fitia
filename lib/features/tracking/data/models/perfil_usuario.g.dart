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
    r'adherenciaDietaSemanal': PropertySchema(
      id: 0,
      name: r'adherenciaDietaSemanal',
      type: IsarType.long,
    ),
    r'adherenciaEntrenoSemanal': PropertySchema(
      id: 1,
      name: r'adherenciaEntrenoSemanal',
      type: IsarType.long,
    ),
    r'alimentosQueSientanMal': PropertySchema(
      id: 2,
      name: r'alimentosQueSientanMal',
      type: IsarType.string,
    ),
    r'alturaCm': PropertySchema(
      id: 3,
      name: r'alturaCm',
      type: IsarType.double,
    ),
    r'digestion': PropertySchema(
      id: 4,
      name: r'digestion',
      type: IsarType.string,
    ),
    r'edad': PropertySchema(id: 5, name: r'edad', type: IsarType.long),
    r'estadoEmocionalComida': PropertySchema(
      id: 6,
      name: r'estadoEmocionalComida',
      type: IsarType.string,
    ),
    r'genero': PropertySchema(id: 7, name: r'genero', type: IsarType.string),
    r'hambreHabitual': PropertySchema(
      id: 8,
      name: r'hambreHabitual',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(id: 9, name: r'nombre', type: IsarType.string),
    r'objetivoPrincipal': PropertySchema(
      id: 10,
      name: r'objetivoPrincipal',
      type: IsarType.string,
    ),
    r'pasosDiarios': PropertySchema(
      id: 11,
      name: r'pasosDiarios',
      type: IsarType.long,
    ),
    r'pesoObjetivoKg': PropertySchema(
      id: 12,
      name: r'pesoObjetivoKg',
      type: IsarType.double,
    ),
    r'pesoObjetivoPlazoSemanas': PropertySchema(
      id: 13,
      name: r'pesoObjetivoPlazoSemanas',
      type: IsarType.long,
    ),
    r'preferenciasComida': PropertySchema(
      id: 14,
      name: r'preferenciasComida',
      type: IsarType.string,
    ),
    r'saciedadCena': PropertySchema(
      id: 15,
      name: r'saciedadCena',
      type: IsarType.string,
    ),
    r'saciedadComida': PropertySchema(
      id: 16,
      name: r'saciedadComida',
      type: IsarType.string,
    ),
    r'saciedadComidas': PropertySchema(
      id: 17,
      name: r'saciedadComidas',
      type: IsarType.string,
    ),
    r'saciedadDesayuno': PropertySchema(
      id: 18,
      name: r'saciedadDesayuno',
      type: IsarType.string,
    ),
    r'suenoFinMinutos': PropertySchema(
      id: 19,
      name: r'suenoFinMinutos',
      type: IsarType.long,
    ),
    r'suenoInicioMinutos': PropertySchema(
      id: 20,
      name: r'suenoInicioMinutos',
      type: IsarType.long,
    ),
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
  bytesCount += 3 + object.alimentosQueSientanMal.length * 3;
  bytesCount += 3 + object.digestion.length * 3;
  bytesCount += 3 + object.estadoEmocionalComida.length * 3;
  bytesCount += 3 + object.genero.length * 3;
  bytesCount += 3 + object.hambreHabitual.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.objetivoPrincipal.length * 3;
  bytesCount += 3 + object.preferenciasComida.length * 3;
  bytesCount += 3 + object.saciedadCena.length * 3;
  bytesCount += 3 + object.saciedadComida.length * 3;
  bytesCount += 3 + object.saciedadComidas.length * 3;
  bytesCount += 3 + object.saciedadDesayuno.length * 3;
  return bytesCount;
}

void _perfilUsuarioSerialize(
  PerfilUsuario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.adherenciaDietaSemanal);
  writer.writeLong(offsets[1], object.adherenciaEntrenoSemanal);
  writer.writeString(offsets[2], object.alimentosQueSientanMal);
  writer.writeDouble(offsets[3], object.alturaCm);
  writer.writeString(offsets[4], object.digestion);
  writer.writeLong(offsets[5], object.edad);
  writer.writeString(offsets[6], object.estadoEmocionalComida);
  writer.writeString(offsets[7], object.genero);
  writer.writeString(offsets[8], object.hambreHabitual);
  writer.writeString(offsets[9], object.nombre);
  writer.writeString(offsets[10], object.objetivoPrincipal);
  writer.writeLong(offsets[11], object.pasosDiarios);
  writer.writeDouble(offsets[12], object.pesoObjetivoKg);
  writer.writeLong(offsets[13], object.pesoObjetivoPlazoSemanas);
  writer.writeString(offsets[14], object.preferenciasComida);
  writer.writeString(offsets[15], object.saciedadCena);
  writer.writeString(offsets[16], object.saciedadComida);
  writer.writeString(offsets[17], object.saciedadComidas);
  writer.writeString(offsets[18], object.saciedadDesayuno);
  writer.writeLong(offsets[19], object.suenoFinMinutos);
  writer.writeLong(offsets[20], object.suenoInicioMinutos);
}

PerfilUsuario _perfilUsuarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PerfilUsuario(
    adherenciaDietaSemanal: reader.readLongOrNull(offsets[0]) ?? 0,
    adherenciaEntrenoSemanal: reader.readLongOrNull(offsets[1]) ?? 0,
    alimentosQueSientanMal: reader.readStringOrNull(offsets[2]) ?? '',
    alturaCm: reader.readDoubleOrNull(offsets[3]) ?? 176.0,
    digestion: reader.readStringOrNull(offsets[4]) ?? '',
    edad: reader.readLongOrNull(offsets[5]) ?? 34,
    estadoEmocionalComida: reader.readStringOrNull(offsets[6]) ?? '',
    genero: reader.readStringOrNull(offsets[7]) ?? '',
    hambreHabitual: reader.readStringOrNull(offsets[8]) ?? '',
    id: id,
    nombre: reader.readStringOrNull(offsets[9]) ?? '',
    objetivoPrincipal: reader.readStringOrNull(offsets[10]) ?? '',
    pasosDiarios: reader.readLongOrNull(offsets[11]) ?? 0,
    pesoObjetivoKg: reader.readDoubleOrNull(offsets[12]),
    pesoObjetivoPlazoSemanas: reader.readLongOrNull(offsets[13]),
    preferenciasComida: reader.readStringOrNull(offsets[14]) ?? '',
    saciedadCena: reader.readStringOrNull(offsets[15]) ?? '',
    saciedadComida: reader.readStringOrNull(offsets[16]) ?? '',
    saciedadComidas: reader.readStringOrNull(offsets[17]) ?? '',
    saciedadDesayuno: reader.readStringOrNull(offsets[18]) ?? '',
    suenoFinMinutos: reader.readLongOrNull(offsets[19]),
    suenoInicioMinutos: reader.readLongOrNull(offsets[20]),
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
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 176.0) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 34) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 16:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 17:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 18:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
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
  adherenciaDietaSemanalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'adherenciaDietaSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaDietaSemanalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'adherenciaDietaSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaDietaSemanalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'adherenciaDietaSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaDietaSemanalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'adherenciaDietaSemanal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaEntrenoSemanalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'adherenciaEntrenoSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaEntrenoSemanalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'adherenciaEntrenoSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaEntrenoSemanalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'adherenciaEntrenoSemanal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  adherenciaEntrenoSemanalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'adherenciaEntrenoSemanal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alimentosQueSientanMal',
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
  alimentosQueSientanMalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'alimentosQueSientanMal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'alimentosQueSientanMal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alimentosQueSientanMal', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  alimentosQueSientanMalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'alimentosQueSientanMal',
          value: '',
        ),
      );
    });
  }

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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'digestion',
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
  digestionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'digestion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'digestion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'digestion', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  digestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'digestion', value: ''),
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
  estadoEmocionalComidaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estadoEmocionalComida',
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
  estadoEmocionalComidaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'estadoEmocionalComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'estadoEmocionalComida',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estadoEmocionalComida', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  estadoEmocionalComidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'estadoEmocionalComida',
          value: '',
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hambreHabitual',
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
  hambreHabitualStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'hambreHabitual',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'hambreHabitual',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hambreHabitual', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  hambreHabitualIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'hambreHabitual', value: ''),
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'objetivoPrincipal',
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
  objetivoPrincipalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'objetivoPrincipal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'objetivoPrincipal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'objetivoPrincipal', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  objetivoPrincipalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'objetivoPrincipal', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pasosDiariosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pasosDiarios', value: value),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pasosDiariosGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pasosDiarios',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pasosDiariosLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pasosDiarios',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pasosDiariosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pasosDiarios',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pesoObjetivoKg'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pesoObjetivoKg'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pesoObjetivoKg',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pesoObjetivoKg',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pesoObjetivoPlazoSemanas'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pesoObjetivoPlazoSemanas'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pesoObjetivoPlazoSemanas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pesoObjetivoPlazoSemanas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pesoObjetivoPlazoSemanas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  pesoObjetivoPlazoSemanasBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pesoObjetivoPlazoSemanas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'preferenciasComida',
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
  preferenciasComidaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'preferenciasComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'preferenciasComida',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'preferenciasComida', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  preferenciasComidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'preferenciasComida', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'saciedadCena',
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
  saciedadCenaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'saciedadCena',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'saciedadCena',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'saciedadCena', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadCenaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'saciedadCena', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'saciedadComida',
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
  saciedadComidaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'saciedadComida',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'saciedadComida',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'saciedadComida', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'saciedadComida', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'saciedadComidas',
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
  saciedadComidasStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'saciedadComidas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'saciedadComidas',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'saciedadComidas', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadComidasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'saciedadComidas', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'saciedadDesayuno',
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
  saciedadDesayunoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'saciedadDesayuno',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'saciedadDesayuno',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'saciedadDesayuno', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  saciedadDesayunoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'saciedadDesayuno', value: ''),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'suenoFinMinutos'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'suenoFinMinutos'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'suenoFinMinutos', value: value),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suenoFinMinutos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suenoFinMinutos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoFinMinutosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suenoFinMinutos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'suenoInicioMinutos'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'suenoInicioMinutos'),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'suenoInicioMinutos', value: value),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suenoInicioMinutos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suenoInicioMinutos',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterFilterCondition>
  suenoInicioMinutosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suenoInicioMinutos',
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
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAdherenciaDietaSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaDietaSemanal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAdherenciaDietaSemanalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaDietaSemanal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAdherenciaEntrenoSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaEntrenoSemanal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAdherenciaEntrenoSemanalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaEntrenoSemanal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAlimentosQueSientanMal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentosQueSientanMal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByAlimentosQueSientanMalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentosQueSientanMal', Sort.desc);
    });
  }

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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByDigestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'digestion', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByDigestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'digestion', Sort.desc);
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByEstadoEmocionalComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoEmocionalComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByEstadoEmocionalComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoEmocionalComida', Sort.desc);
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByHambreHabitual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hambreHabitual', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByHambreHabitualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hambreHabitual', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByObjetivoPrincipal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoPrincipal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByObjetivoPrincipalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoPrincipal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPasosDiarios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasosDiarios', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPasosDiariosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasosDiarios', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPesoObjetivoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPesoObjetivoPlazoSemanas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoPlazoSemanas', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPesoObjetivoPlazoSemanasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoPlazoSemanas', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPreferenciasComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferenciasComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortByPreferenciasComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferenciasComida', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadCena() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadCena', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadCenaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadCena', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComida', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadComidas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComidas', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadComidasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComidas', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadDesayuno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadDesayuno', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySaciedadDesayunoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadDesayuno', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySuenoFinMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoFinMinutos', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySuenoFinMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoFinMinutos', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySuenoInicioMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoInicioMinutos', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  sortBySuenoInicioMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoInicioMinutos', Sort.desc);
    });
  }
}

extension PerfilUsuarioQuerySortThenBy
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QSortThenBy> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAdherenciaDietaSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaDietaSemanal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAdherenciaDietaSemanalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaDietaSemanal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAdherenciaEntrenoSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaEntrenoSemanal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAdherenciaEntrenoSemanalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adherenciaEntrenoSemanal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAlimentosQueSientanMal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentosQueSientanMal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByAlimentosQueSientanMalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentosQueSientanMal', Sort.desc);
    });
  }

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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByDigestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'digestion', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByDigestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'digestion', Sort.desc);
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByEstadoEmocionalComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoEmocionalComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByEstadoEmocionalComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoEmocionalComida', Sort.desc);
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByHambreHabitual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hambreHabitual', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByHambreHabitualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hambreHabitual', Sort.desc);
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

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByObjetivoPrincipal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoPrincipal', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByObjetivoPrincipalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoPrincipal', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPasosDiarios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasosDiarios', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPasosDiariosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasosDiarios', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPesoObjetivoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoKg', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPesoObjetivoPlazoSemanas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoPlazoSemanas', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPesoObjetivoPlazoSemanasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoObjetivoPlazoSemanas', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPreferenciasComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferenciasComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenByPreferenciasComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferenciasComida', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadCena() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadCena', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadCenaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadCena', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComida', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComida', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadComidas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComidas', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadComidasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadComidas', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadDesayuno() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadDesayuno', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySaciedadDesayunoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saciedadDesayuno', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySuenoFinMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoFinMinutos', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySuenoFinMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoFinMinutos', Sort.desc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySuenoInicioMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoInicioMinutos', Sort.asc);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QAfterSortBy>
  thenBySuenoInicioMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suenoInicioMinutos', Sort.desc);
    });
  }
}

extension PerfilUsuarioQueryWhereDistinct
    on QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> {
  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByAdherenciaDietaSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adherenciaDietaSemanal');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByAdherenciaEntrenoSemanal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adherenciaEntrenoSemanal');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByAlimentosQueSientanMal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'alimentosQueSientanMal',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByAlturaCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alturaCm');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByDigestion({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'digestion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByEdad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edad');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByEstadoEmocionalComida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'estadoEmocionalComida',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByGenero({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByHambreHabitual({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'hambreHabitual',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByObjetivoPrincipal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'objetivoPrincipal',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByPasosDiarios() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pasosDiarios');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByPesoObjetivoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoObjetivoKg');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByPesoObjetivoPlazoSemanas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoObjetivoPlazoSemanas');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctByPreferenciasComida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'preferenciasComida',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct> distinctBySaciedadCena({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saciedadCena', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctBySaciedadComida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'saciedadComida',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctBySaciedadComidas({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'saciedadComidas',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctBySaciedadDesayuno({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'saciedadDesayuno',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctBySuenoFinMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suenoFinMinutos');
    });
  }

  QueryBuilder<PerfilUsuario, PerfilUsuario, QDistinct>
  distinctBySuenoInicioMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suenoInicioMinutos');
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

  QueryBuilder<PerfilUsuario, int, QQueryOperations>
  adherenciaDietaSemanalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adherenciaDietaSemanal');
    });
  }

  QueryBuilder<PerfilUsuario, int, QQueryOperations>
  adherenciaEntrenoSemanalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adherenciaEntrenoSemanal');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  alimentosQueSientanMalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alimentosQueSientanMal');
    });
  }

  QueryBuilder<PerfilUsuario, double, QQueryOperations> alturaCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alturaCm');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations> digestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'digestion');
    });
  }

  QueryBuilder<PerfilUsuario, int, QQueryOperations> edadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edad');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  estadoEmocionalComidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estadoEmocionalComida');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations> generoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genero');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  hambreHabitualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hambreHabitual');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  objetivoPrincipalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objetivoPrincipal');
    });
  }

  QueryBuilder<PerfilUsuario, int, QQueryOperations> pasosDiariosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pasosDiarios');
    });
  }

  QueryBuilder<PerfilUsuario, double?, QQueryOperations>
  pesoObjetivoKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoObjetivoKg');
    });
  }

  QueryBuilder<PerfilUsuario, int?, QQueryOperations>
  pesoObjetivoPlazoSemanasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoObjetivoPlazoSemanas');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  preferenciasComidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferenciasComida');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations> saciedadCenaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saciedadCena');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  saciedadComidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saciedadComida');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  saciedadComidasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saciedadComidas');
    });
  }

  QueryBuilder<PerfilUsuario, String, QQueryOperations>
  saciedadDesayunoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saciedadDesayuno');
    });
  }

  QueryBuilder<PerfilUsuario, int?, QQueryOperations>
  suenoFinMinutosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suenoFinMinutos');
    });
  }

  QueryBuilder<PerfilUsuario, int?, QQueryOperations>
  suenoInicioMinutosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suenoInicioMinutos');
    });
  }
}
