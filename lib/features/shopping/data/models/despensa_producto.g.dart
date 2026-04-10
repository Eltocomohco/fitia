// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despensa_producto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDespensaProductoCollection on Isar {
  IsarCollection<DespensaProducto> get despensaProductos => this.collection();
}

const DespensaProductoSchema = CollectionSchema(
  name: r'DespensaProducto',
  id: -4374923962848157870,
  properties: {
    r'alimentoId': PropertySchema(
      id: 0,
      name: r'alimentoId',
      type: IsarType.long,
    ),
    r'cantidad': PropertySchema(id: 1, name: r'cantidad', type: IsarType.long),
    r'gramosPorUnidad': PropertySchema(
      id: 2,
      name: r'gramosPorUnidad',
      type: IsarType.double,
    ),
    r'nombreAlimento': PropertySchema(
      id: 3,
      name: r'nombreAlimento',
      type: IsarType.string,
    ),
    r'nombreProducto': PropertySchema(
      id: 4,
      name: r'nombreProducto',
      type: IsarType.string,
    ),
  },

  estimateSize: _despensaProductoEstimateSize,
  serialize: _despensaProductoSerialize,
  deserialize: _despensaProductoDeserialize,
  deserializeProp: _despensaProductoDeserializeProp,
  idName: r'id',
  indexes: {
    r'alimentoId': IndexSchema(
      id: 7341092329966121779,
      name: r'alimentoId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'alimentoId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'nombreAlimento': IndexSchema(
      id: 5882859062393186403,
      name: r'nombreAlimento',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nombreAlimento',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _despensaProductoGetId,
  getLinks: _despensaProductoGetLinks,
  attach: _despensaProductoAttach,
  version: '3.3.2',
);

int _despensaProductoEstimateSize(
  DespensaProducto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombreAlimento.length * 3;
  bytesCount += 3 + object.nombreProducto.length * 3;
  return bytesCount;
}

void _despensaProductoSerialize(
  DespensaProducto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.alimentoId);
  writer.writeLong(offsets[1], object.cantidad);
  writer.writeDouble(offsets[2], object.gramosPorUnidad);
  writer.writeString(offsets[3], object.nombreAlimento);
  writer.writeString(offsets[4], object.nombreProducto);
}

DespensaProducto _despensaProductoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DespensaProducto(
    alimentoId: reader.readLong(offsets[0]),
    cantidad: reader.readLongOrNull(offsets[1]) ?? 1,
    gramosPorUnidad: reader.readDouble(offsets[2]),
    id: id,
    nombreAlimento: reader.readString(offsets[3]),
    nombreProducto: reader.readString(offsets[4]),
  );
  return object;
}

P _despensaProductoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _despensaProductoGetId(DespensaProducto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _despensaProductoGetLinks(DespensaProducto object) {
  return [];
}

void _despensaProductoAttach(
  IsarCollection<dynamic> col,
  Id id,
  DespensaProducto object,
) {
  object.id = id;
}

extension DespensaProductoQueryWhereSort
    on QueryBuilder<DespensaProducto, DespensaProducto, QWhere> {
  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhere>
  anyAlimentoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'alimentoId'),
      );
    });
  }
}

extension DespensaProductoQueryWhere
    on QueryBuilder<DespensaProducto, DespensaProducto, QWhereClause> {
  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
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

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause> idBetween(
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

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  alimentoIdEqualTo(int alimentoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'alimentoId', value: [alimentoId]),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  alimentoIdNotEqualTo(int alimentoId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'alimentoId',
                lower: [],
                upper: [alimentoId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'alimentoId',
                lower: [alimentoId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'alimentoId',
                lower: [alimentoId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'alimentoId',
                lower: [],
                upper: [alimentoId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  alimentoIdGreaterThan(int alimentoId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'alimentoId',
          lower: [alimentoId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  alimentoIdLessThan(int alimentoId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'alimentoId',
          lower: [],
          upper: [alimentoId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  alimentoIdBetween(
    int lowerAlimentoId,
    int upperAlimentoId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'alimentoId',
          lower: [lowerAlimentoId],
          includeLower: includeLower,
          upper: [upperAlimentoId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  nombreAlimentoEqualTo(String nombreAlimento) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'nombreAlimento',
          value: [nombreAlimento],
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterWhereClause>
  nombreAlimentoNotEqualTo(String nombreAlimento) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombreAlimento',
                lower: [],
                upper: [nombreAlimento],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombreAlimento',
                lower: [nombreAlimento],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombreAlimento',
                lower: [nombreAlimento],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombreAlimento',
                lower: [],
                upper: [nombreAlimento],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension DespensaProductoQueryFilter
    on QueryBuilder<DespensaProducto, DespensaProducto, QFilterCondition> {
  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  alimentoIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alimentoId', value: value),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  alimentoIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alimentoId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  alimentoIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alimentoId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  alimentoIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alimentoId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  cantidadEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cantidad', value: value),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  cantidadGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cantidad',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  cantidadLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cantidad',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  cantidadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cantidad',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  gramosPorUnidadEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gramosPorUnidad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  gramosPorUnidadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gramosPorUnidad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  gramosPorUnidadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gramosPorUnidad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  gramosPorUnidadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gramosPorUnidad',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
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

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
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

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
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

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nombreAlimento',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nombreAlimento',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nombreAlimento',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombreAlimento', value: ''),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreAlimentoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombreAlimento', value: ''),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nombreProducto',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nombreProducto',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nombreProducto',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombreProducto', value: ''),
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterFilterCondition>
  nombreProductoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombreProducto', value: ''),
      );
    });
  }
}

extension DespensaProductoQueryObject
    on QueryBuilder<DespensaProducto, DespensaProducto, QFilterCondition> {}

extension DespensaProductoQueryLinks
    on QueryBuilder<DespensaProducto, DespensaProducto, QFilterCondition> {}

extension DespensaProductoQuerySortBy
    on QueryBuilder<DespensaProducto, DespensaProducto, QSortBy> {
  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByAlimentoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentoId', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByAlimentoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentoId', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByGramosPorUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gramosPorUnidad', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByGramosPorUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gramosPorUnidad', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByNombreAlimento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreAlimento', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByNombreAlimentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreAlimento', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByNombreProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreProducto', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  sortByNombreProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreProducto', Sort.desc);
    });
  }
}

extension DespensaProductoQuerySortThenBy
    on QueryBuilder<DespensaProducto, DespensaProducto, QSortThenBy> {
  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByAlimentoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentoId', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByAlimentoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alimentoId', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByGramosPorUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gramosPorUnidad', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByGramosPorUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gramosPorUnidad', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByNombreAlimento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreAlimento', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByNombreAlimentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreAlimento', Sort.desc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByNombreProducto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreProducto', Sort.asc);
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QAfterSortBy>
  thenByNombreProductoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombreProducto', Sort.desc);
    });
  }
}

extension DespensaProductoQueryWhereDistinct
    on QueryBuilder<DespensaProducto, DespensaProducto, QDistinct> {
  QueryBuilder<DespensaProducto, DespensaProducto, QDistinct>
  distinctByAlimentoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alimentoId');
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QDistinct>
  distinctByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidad');
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QDistinct>
  distinctByGramosPorUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gramosPorUnidad');
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QDistinct>
  distinctByNombreAlimento({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'nombreAlimento',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DespensaProducto, DespensaProducto, QDistinct>
  distinctByNombreProducto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'nombreProducto',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension DespensaProductoQueryProperty
    on QueryBuilder<DespensaProducto, DespensaProducto, QQueryProperty> {
  QueryBuilder<DespensaProducto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DespensaProducto, int, QQueryOperations> alimentoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alimentoId');
    });
  }

  QueryBuilder<DespensaProducto, int, QQueryOperations> cantidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidad');
    });
  }

  QueryBuilder<DespensaProducto, double, QQueryOperations>
  gramosPorUnidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gramosPorUnidad');
    });
  }

  QueryBuilder<DespensaProducto, String, QQueryOperations>
  nombreAlimentoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombreAlimento');
    });
  }

  QueryBuilder<DespensaProducto, String, QQueryOperations>
  nombreProductoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombreProducto');
    });
  }
}
