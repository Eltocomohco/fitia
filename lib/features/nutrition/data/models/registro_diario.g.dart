// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_diario.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroDiarioCollection on Isar {
  IsarCollection<RegistroDiario> get registrosDiarios => this.collection();
}

const RegistroDiarioSchema = CollectionSchema(
  name: r'RegistroDiario',
  id: 5617529859921218982,
  properties: {
    r'cantidadConsumidaGramos': PropertySchema(
      id: 0,
      name: r'cantidadConsumidaGramos',
      type: IsarType.double,
    ),
    r'esReceta': PropertySchema(id: 1, name: r'esReceta', type: IsarType.bool),
    r'fecha': PropertySchema(id: 2, name: r'fecha', type: IsarType.dateTime),
    r'fechaDiaKey': PropertySchema(
      id: 3,
      name: r'fechaDiaKey',
      type: IsarType.long,
    ),
    r'itemId': PropertySchema(id: 4, name: r'itemId', type: IsarType.long),
    r'tipoComida': PropertySchema(
      id: 5,
      name: r'tipoComida',
      type: IsarType.byte,
      enumMap: _RegistroDiariotipoComidaEnumValueMap,
    ),
  },

  estimateSize: _registroDiarioEstimateSize,
  serialize: _registroDiarioSerialize,
  deserialize: _registroDiarioDeserialize,
  deserializeProp: _registroDiarioDeserializeProp,
  idName: r'id',
  indexes: {
    r'fecha': IndexSchema(
      id: -5395179286312083551,
      name: r'fecha',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fecha',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'itemId': IndexSchema(
      id: -5342806140158601489,
      name: r'itemId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'itemId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'fechaDiaKey': IndexSchema(
      id: -3860554356302594530,
      name: r'fechaDiaKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fechaDiaKey',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _registroDiarioGetId,
  getLinks: _registroDiarioGetLinks,
  attach: _registroDiarioAttach,
  version: '3.3.2',
);

int _registroDiarioEstimateSize(
  RegistroDiario object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _registroDiarioSerialize(
  RegistroDiario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadConsumidaGramos);
  writer.writeBool(offsets[1], object.esReceta);
  writer.writeDateTime(offsets[2], object.fecha);
  writer.writeLong(offsets[3], object.fechaDiaKey);
  writer.writeLong(offsets[4], object.itemId);
  writer.writeByte(offsets[5], object.tipoComida.index);
}

RegistroDiario _registroDiarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroDiario(
    cantidadConsumidaGramos: reader.readDouble(offsets[0]),
    esReceta: reader.readBool(offsets[1]),
    fecha: reader.readDateTime(offsets[2]),
    id: id,
    itemId: reader.readLong(offsets[4]),
    tipoComida:
        _RegistroDiariotipoComidaValueEnumMap[reader.readByteOrNull(
          offsets[5],
        )] ??
        TipoComida.desayuno,
  );
  return object;
}

P _registroDiarioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (_RegistroDiariotipoComidaValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              TipoComida.desayuno)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RegistroDiariotipoComidaEnumValueMap = {
  'desayuno': 0,
  'comida': 1,
  'cena': 2,
  'snack': 3,
};
const _RegistroDiariotipoComidaValueEnumMap = {
  0: TipoComida.desayuno,
  1: TipoComida.comida,
  2: TipoComida.cena,
  3: TipoComida.snack,
};

Id _registroDiarioGetId(RegistroDiario object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroDiarioGetLinks(RegistroDiario object) {
  return [];
}

void _registroDiarioAttach(
  IsarCollection<dynamic> col,
  Id id,
  RegistroDiario object,
) {
  object.id = id;
}

extension RegistroDiarioQueryWhereSort
    on QueryBuilder<RegistroDiario, RegistroDiario, QWhere> {
  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhere> anyItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'itemId'),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhere> anyFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fechaDiaKey'),
      );
    });
  }
}

extension RegistroDiarioQueryWhere
    on QueryBuilder<RegistroDiario, RegistroDiario, QWhereClause> {
  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> idBetween(
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

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> fechaEqualTo(
    DateTime fecha,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fecha', value: [fecha]),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaNotEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [],
                upper: [fecha],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [fecha],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [fecha],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fecha',
                lower: [],
                upper: [fecha],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaGreaterThan(DateTime fecha, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [fecha],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> fechaLessThan(
    DateTime fecha, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [],
          upper: [fecha],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> fechaBetween(
    DateTime lowerFecha,
    DateTime upperFecha, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fecha',
          lower: [lowerFecha],
          includeLower: includeLower,
          upper: [upperFecha],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> itemIdEqualTo(
    int itemId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'itemId', value: [itemId]),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  itemIdNotEqualTo(int itemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'itemId',
                lower: [],
                upper: [itemId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'itemId',
                lower: [itemId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'itemId',
                lower: [itemId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'itemId',
                lower: [],
                upper: [itemId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  itemIdGreaterThan(int itemId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'itemId',
          lower: [itemId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  itemIdLessThan(int itemId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'itemId',
          lower: [],
          upper: [itemId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause> itemIdBetween(
    int lowerItemId,
    int upperItemId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'itemId',
          lower: [lowerItemId],
          includeLower: includeLower,
          upper: [upperItemId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaDiaKeyEqualTo(int fechaDiaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'fechaDiaKey',
          value: [fechaDiaKey],
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaDiaKeyNotEqualTo(int fechaDiaKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [],
                upper: [fechaDiaKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [fechaDiaKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [fechaDiaKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fechaDiaKey',
                lower: [],
                upper: [fechaDiaKey],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaDiaKeyGreaterThan(int fechaDiaKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [fechaDiaKey],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaDiaKeyLessThan(int fechaDiaKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [],
          upper: [fechaDiaKey],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterWhereClause>
  fechaDiaKeyBetween(
    int lowerFechaDiaKey,
    int upperFechaDiaKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fechaDiaKey',
          lower: [lowerFechaDiaKey],
          includeLower: includeLower,
          upper: [upperFechaDiaKey],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RegistroDiarioQueryFilter
    on QueryBuilder<RegistroDiario, RegistroDiario, QFilterCondition> {
  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  cantidadConsumidaGramosEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cantidadConsumidaGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  cantidadConsumidaGramosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cantidadConsumidaGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  cantidadConsumidaGramosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cantidadConsumidaGramos',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  cantidadConsumidaGramosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cantidadConsumidaGramos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  esRecetaEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'esReceta', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fecha',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaDiaKeyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaDiaKey', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaDiaKeyGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fechaDiaKey',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaDiaKeyLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fechaDiaKey',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  fechaDiaKeyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fechaDiaKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
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

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
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

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  itemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itemId', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  itemIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  itemIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itemId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  itemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  tipoComidaEqualTo(TipoComida value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipoComida', value: value),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  tipoComidaGreaterThan(TipoComida value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipoComida',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  tipoComidaLessThan(TipoComida value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipoComida',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterFilterCondition>
  tipoComidaBetween(
    TipoComida lower,
    TipoComida upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipoComida',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RegistroDiarioQueryObject
    on QueryBuilder<RegistroDiario, RegistroDiario, QFilterCondition> {}

extension RegistroDiarioQueryLinks
    on QueryBuilder<RegistroDiario, RegistroDiario, QFilterCondition> {}

extension RegistroDiarioQuerySortBy
    on QueryBuilder<RegistroDiario, RegistroDiario, QSortBy> {
  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByCantidadConsumidaGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadConsumidaGramos', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByCantidadConsumidaGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadConsumidaGramos', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> sortByEsReceta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esReceta', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByEsRecetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esReceta', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByFechaDiaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> sortByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByTipoComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  sortByTipoComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.desc);
    });
  }
}

extension RegistroDiarioQuerySortThenBy
    on QueryBuilder<RegistroDiario, RegistroDiario, QSortThenBy> {
  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByCantidadConsumidaGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadConsumidaGramos', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByCantidadConsumidaGramosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadConsumidaGramos', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenByEsReceta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esReceta', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByEsRecetaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esReceta', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByFechaDiaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaDiaKey', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy> thenByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByTipoComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.asc);
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QAfterSortBy>
  thenByTipoComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.desc);
    });
  }
}

extension RegistroDiarioQueryWhereDistinct
    on QueryBuilder<RegistroDiario, RegistroDiario, QDistinct> {
  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct>
  distinctByCantidadConsumidaGramos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadConsumidaGramos');
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct> distinctByEsReceta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esReceta');
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct>
  distinctByFechaDiaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaDiaKey');
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct> distinctByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemId');
    });
  }

  QueryBuilder<RegistroDiario, RegistroDiario, QDistinct>
  distinctByTipoComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoComida');
    });
  }
}

extension RegistroDiarioQueryProperty
    on QueryBuilder<RegistroDiario, RegistroDiario, QQueryProperty> {
  QueryBuilder<RegistroDiario, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroDiario, double, QQueryOperations>
  cantidadConsumidaGramosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadConsumidaGramos');
    });
  }

  QueryBuilder<RegistroDiario, bool, QQueryOperations> esRecetaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esReceta');
    });
  }

  QueryBuilder<RegistroDiario, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<RegistroDiario, int, QQueryOperations> fechaDiaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaDiaKey');
    });
  }

  QueryBuilder<RegistroDiario, int, QQueryOperations> itemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemId');
    });
  }

  QueryBuilder<RegistroDiario, TipoComida, QQueryOperations>
  tipoComidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoComida');
    });
  }
}
