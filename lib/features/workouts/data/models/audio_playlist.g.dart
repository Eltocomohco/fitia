// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_playlist.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAudioPlaylistCollection on Isar {
  IsarCollection<AudioPlaylist> get audioPlaylists => this.collection();
}

const AudioPlaylistSchema = CollectionSchema(
  name: r'AudioPlaylist',
  id: 7361293786187665438,
  properties: {
    r'actualizadoEn': PropertySchema(
      id: 0,
      name: r'actualizadoEn',
      type: IsarType.dateTime,
    ),
    r'creadoEn': PropertySchema(
      id: 1,
      name: r'creadoEn',
      type: IsarType.dateTime,
    ),
    r'nombre': PropertySchema(id: 2, name: r'nombre', type: IsarType.string),
    r'rutasCanciones': PropertySchema(
      id: 3,
      name: r'rutasCanciones',
      type: IsarType.stringList,
    ),
  },

  estimateSize: _audioPlaylistEstimateSize,
  serialize: _audioPlaylistSerialize,
  deserialize: _audioPlaylistDeserialize,
  deserializeProp: _audioPlaylistDeserializeProp,
  idName: r'id',
  indexes: {
    r'nombre': IndexSchema(
      id: -8239814765453414572,
      name: r'nombre',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nombre',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _audioPlaylistGetId,
  getLinks: _audioPlaylistGetLinks,
  attach: _audioPlaylistAttach,
  version: '3.3.2',
);

int _audioPlaylistEstimateSize(
  AudioPlaylist object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.rutasCanciones.length * 3;
  {
    for (var i = 0; i < object.rutasCanciones.length; i++) {
      final value = object.rutasCanciones[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _audioPlaylistSerialize(
  AudioPlaylist object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.actualizadoEn);
  writer.writeDateTime(offsets[1], object.creadoEn);
  writer.writeString(offsets[2], object.nombre);
  writer.writeStringList(offsets[3], object.rutasCanciones);
}

AudioPlaylist _audioPlaylistDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AudioPlaylist(
    id: id,
    nombre: reader.readString(offsets[2]),
    rutasCanciones: reader.readStringList(offsets[3]) ?? const <String>[],
  );
  object.actualizadoEn = reader.readDateTime(offsets[0]);
  object.creadoEn = reader.readDateTime(offsets[1]);
  return object;
}

P _audioPlaylistDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? const <String>[]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _audioPlaylistGetId(AudioPlaylist object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _audioPlaylistGetLinks(AudioPlaylist object) {
  return [];
}

void _audioPlaylistAttach(
  IsarCollection<dynamic> col,
  Id id,
  AudioPlaylist object,
) {
  object.id = id;
}

extension AudioPlaylistQueryWhereSort
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QWhere> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AudioPlaylistQueryWhere
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QWhereClause> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> idBetween(
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause> nombreEqualTo(
    String nombre,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'nombre', value: [nombre]),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterWhereClause>
  nombreNotEqualTo(String nombre) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [],
                upper: [nombre],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [nombre],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [nombre],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nombre',
                lower: [],
                upper: [nombre],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AudioPlaylistQueryFilter
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QFilterCondition> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  actualizadoEnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actualizadoEn', value: value),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  actualizadoEnGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actualizadoEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  actualizadoEnLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actualizadoEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  actualizadoEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actualizadoEn',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  creadoEnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'creadoEn', value: value),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  creadoEnGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'creadoEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  creadoEnLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'creadoEn',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  creadoEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'creadoEn',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
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

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nombre', value: ''),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rutasCanciones',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'rutasCanciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'rutasCanciones',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rutasCanciones', value: ''),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'rutasCanciones', value: ''),
      );
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rutasCanciones', length, true, length, true);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rutasCanciones', 0, true, 0, true);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rutasCanciones', 0, false, 999999, true);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rutasCanciones', 0, true, length, include);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'rutasCanciones', length, include, 999999, true);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterFilterCondition>
  rutasCancionesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutasCanciones',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AudioPlaylistQueryObject
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QFilterCondition> {}

extension AudioPlaylistQueryLinks
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QFilterCondition> {}

extension AudioPlaylistQuerySortBy
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QSortBy> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  sortByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  sortByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> sortByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  sortByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension AudioPlaylistQuerySortThenBy
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QSortThenBy> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  thenByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  thenByActualizadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualizadoEn', Sort.desc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> thenByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy>
  thenByCreadoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creadoEn', Sort.desc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension AudioPlaylistQueryWhereDistinct
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QDistinct> {
  QueryBuilder<AudioPlaylist, AudioPlaylist, QDistinct>
  distinctByActualizadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualizadoEn');
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QDistinct> distinctByCreadoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creadoEn');
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QDistinct> distinctByNombre({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioPlaylist, AudioPlaylist, QDistinct>
  distinctByRutasCanciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rutasCanciones');
    });
  }
}

extension AudioPlaylistQueryProperty
    on QueryBuilder<AudioPlaylist, AudioPlaylist, QQueryProperty> {
  QueryBuilder<AudioPlaylist, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AudioPlaylist, DateTime, QQueryOperations>
  actualizadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualizadoEn');
    });
  }

  QueryBuilder<AudioPlaylist, DateTime, QQueryOperations> creadoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creadoEn');
    });
  }

  QueryBuilder<AudioPlaylist, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<AudioPlaylist, List<String>, QQueryOperations>
  rutasCancionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rutasCanciones');
    });
  }
}
