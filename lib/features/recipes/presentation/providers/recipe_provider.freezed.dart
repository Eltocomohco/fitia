// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeBuilderIngredient {

 Alimento get alimento; double get cantidadGramos; GrupoComponenteReceta get grupo;
/// Create a copy of RecipeBuilderIngredient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeBuilderIngredientCopyWith<RecipeBuilderIngredient> get copyWith => _$RecipeBuilderIngredientCopyWithImpl<RecipeBuilderIngredient>(this as RecipeBuilderIngredient, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeBuilderIngredient&&(identical(other.alimento, alimento) || other.alimento == alimento)&&(identical(other.cantidadGramos, cantidadGramos) || other.cantidadGramos == cantidadGramos)&&(identical(other.grupo, grupo) || other.grupo == grupo));
}


@override
int get hashCode => Object.hash(runtimeType,alimento,cantidadGramos,grupo);

@override
String toString() {
  return 'RecipeBuilderIngredient(alimento: $alimento, cantidadGramos: $cantidadGramos, grupo: $grupo)';
}


}

/// @nodoc
abstract mixin class $RecipeBuilderIngredientCopyWith<$Res>  {
  factory $RecipeBuilderIngredientCopyWith(RecipeBuilderIngredient value, $Res Function(RecipeBuilderIngredient) _then) = _$RecipeBuilderIngredientCopyWithImpl;
@useResult
$Res call({
 Alimento alimento, double cantidadGramos, GrupoComponenteReceta grupo
});




}
/// @nodoc
class _$RecipeBuilderIngredientCopyWithImpl<$Res>
    implements $RecipeBuilderIngredientCopyWith<$Res> {
  _$RecipeBuilderIngredientCopyWithImpl(this._self, this._then);

  final RecipeBuilderIngredient _self;
  final $Res Function(RecipeBuilderIngredient) _then;

/// Create a copy of RecipeBuilderIngredient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alimento = null,Object? cantidadGramos = null,Object? grupo = null,}) {
  return _then(_self.copyWith(
alimento: null == alimento ? _self.alimento : alimento // ignore: cast_nullable_to_non_nullable
as Alimento,cantidadGramos: null == cantidadGramos ? _self.cantidadGramos : cantidadGramos // ignore: cast_nullable_to_non_nullable
as double,grupo: null == grupo ? _self.grupo : grupo // ignore: cast_nullable_to_non_nullable
as GrupoComponenteReceta,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeBuilderIngredient].
extension RecipeBuilderIngredientPatterns on RecipeBuilderIngredient {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeBuilderIngredient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeBuilderIngredient() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeBuilderIngredient value)  $default,){
final _that = this;
switch (_that) {
case _RecipeBuilderIngredient():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeBuilderIngredient value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeBuilderIngredient() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Alimento alimento,  double cantidadGramos,  GrupoComponenteReceta grupo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeBuilderIngredient() when $default != null:
return $default(_that.alimento,_that.cantidadGramos,_that.grupo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Alimento alimento,  double cantidadGramos,  GrupoComponenteReceta grupo)  $default,) {final _that = this;
switch (_that) {
case _RecipeBuilderIngredient():
return $default(_that.alimento,_that.cantidadGramos,_that.grupo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Alimento alimento,  double cantidadGramos,  GrupoComponenteReceta grupo)?  $default,) {final _that = this;
switch (_that) {
case _RecipeBuilderIngredient() when $default != null:
return $default(_that.alimento,_that.cantidadGramos,_that.grupo);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeBuilderIngredient implements RecipeBuilderIngredient {
  const _RecipeBuilderIngredient({required this.alimento, required this.cantidadGramos, this.grupo = GrupoComponenteReceta.principal});
  

@override final  Alimento alimento;
@override final  double cantidadGramos;
@override@JsonKey() final  GrupoComponenteReceta grupo;

/// Create a copy of RecipeBuilderIngredient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeBuilderIngredientCopyWith<_RecipeBuilderIngredient> get copyWith => __$RecipeBuilderIngredientCopyWithImpl<_RecipeBuilderIngredient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeBuilderIngredient&&(identical(other.alimento, alimento) || other.alimento == alimento)&&(identical(other.cantidadGramos, cantidadGramos) || other.cantidadGramos == cantidadGramos)&&(identical(other.grupo, grupo) || other.grupo == grupo));
}


@override
int get hashCode => Object.hash(runtimeType,alimento,cantidadGramos,grupo);

@override
String toString() {
  return 'RecipeBuilderIngredient(alimento: $alimento, cantidadGramos: $cantidadGramos, grupo: $grupo)';
}


}

/// @nodoc
abstract mixin class _$RecipeBuilderIngredientCopyWith<$Res> implements $RecipeBuilderIngredientCopyWith<$Res> {
  factory _$RecipeBuilderIngredientCopyWith(_RecipeBuilderIngredient value, $Res Function(_RecipeBuilderIngredient) _then) = __$RecipeBuilderIngredientCopyWithImpl;
@override @useResult
$Res call({
 Alimento alimento, double cantidadGramos, GrupoComponenteReceta grupo
});




}
/// @nodoc
class __$RecipeBuilderIngredientCopyWithImpl<$Res>
    implements _$RecipeBuilderIngredientCopyWith<$Res> {
  __$RecipeBuilderIngredientCopyWithImpl(this._self, this._then);

  final _RecipeBuilderIngredient _self;
  final $Res Function(_RecipeBuilderIngredient) _then;

/// Create a copy of RecipeBuilderIngredient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alimento = null,Object? cantidadGramos = null,Object? grupo = null,}) {
  return _then(_RecipeBuilderIngredient(
alimento: null == alimento ? _self.alimento : alimento // ignore: cast_nullable_to_non_nullable
as Alimento,cantidadGramos: null == cantidadGramos ? _self.cantidadGramos : cantidadGramos // ignore: cast_nullable_to_non_nullable
as double,grupo: null == grupo ? _self.grupo : grupo // ignore: cast_nullable_to_non_nullable
as GrupoComponenteReceta,
  ));
}


}

/// @nodoc
mixin _$RecipeBuilderState {

 int? get editingRecipeId; String get nombre; int get raciones; List<RecipeBuilderIngredient> get ingredientes;
/// Create a copy of RecipeBuilderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeBuilderStateCopyWith<RecipeBuilderState> get copyWith => _$RecipeBuilderStateCopyWithImpl<RecipeBuilderState>(this as RecipeBuilderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeBuilderState&&(identical(other.editingRecipeId, editingRecipeId) || other.editingRecipeId == editingRecipeId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.raciones, raciones) || other.raciones == raciones)&&const DeepCollectionEquality().equals(other.ingredientes, ingredientes));
}


@override
int get hashCode => Object.hash(runtimeType,editingRecipeId,nombre,raciones,const DeepCollectionEquality().hash(ingredientes));

@override
String toString() {
  return 'RecipeBuilderState(editingRecipeId: $editingRecipeId, nombre: $nombre, raciones: $raciones, ingredientes: $ingredientes)';
}


}

/// @nodoc
abstract mixin class $RecipeBuilderStateCopyWith<$Res>  {
  factory $RecipeBuilderStateCopyWith(RecipeBuilderState value, $Res Function(RecipeBuilderState) _then) = _$RecipeBuilderStateCopyWithImpl;
@useResult
$Res call({
 int? editingRecipeId, String nombre, int raciones, List<RecipeBuilderIngredient> ingredientes
});




}
/// @nodoc
class _$RecipeBuilderStateCopyWithImpl<$Res>
    implements $RecipeBuilderStateCopyWith<$Res> {
  _$RecipeBuilderStateCopyWithImpl(this._self, this._then);

  final RecipeBuilderState _self;
  final $Res Function(RecipeBuilderState) _then;

/// Create a copy of RecipeBuilderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? editingRecipeId = freezed,Object? nombre = null,Object? raciones = null,Object? ingredientes = null,}) {
  return _then(_self.copyWith(
editingRecipeId: freezed == editingRecipeId ? _self.editingRecipeId : editingRecipeId // ignore: cast_nullable_to_non_nullable
as int?,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,raciones: null == raciones ? _self.raciones : raciones // ignore: cast_nullable_to_non_nullable
as int,ingredientes: null == ingredientes ? _self.ingredientes : ingredientes // ignore: cast_nullable_to_non_nullable
as List<RecipeBuilderIngredient>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeBuilderState].
extension RecipeBuilderStatePatterns on RecipeBuilderState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeBuilderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeBuilderState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeBuilderState value)  $default,){
final _that = this;
switch (_that) {
case _RecipeBuilderState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeBuilderState value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeBuilderState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? editingRecipeId,  String nombre,  int raciones,  List<RecipeBuilderIngredient> ingredientes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeBuilderState() when $default != null:
return $default(_that.editingRecipeId,_that.nombre,_that.raciones,_that.ingredientes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? editingRecipeId,  String nombre,  int raciones,  List<RecipeBuilderIngredient> ingredientes)  $default,) {final _that = this;
switch (_that) {
case _RecipeBuilderState():
return $default(_that.editingRecipeId,_that.nombre,_that.raciones,_that.ingredientes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? editingRecipeId,  String nombre,  int raciones,  List<RecipeBuilderIngredient> ingredientes)?  $default,) {final _that = this;
switch (_that) {
case _RecipeBuilderState() when $default != null:
return $default(_that.editingRecipeId,_that.nombre,_that.raciones,_that.ingredientes);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeBuilderState implements RecipeBuilderState {
  const _RecipeBuilderState({this.editingRecipeId, this.nombre = '', this.raciones = 1, final  List<RecipeBuilderIngredient> ingredientes = const <RecipeBuilderIngredient>[]}): _ingredientes = ingredientes;
  

@override final  int? editingRecipeId;
@override@JsonKey() final  String nombre;
@override@JsonKey() final  int raciones;
 final  List<RecipeBuilderIngredient> _ingredientes;
@override@JsonKey() List<RecipeBuilderIngredient> get ingredientes {
  if (_ingredientes is EqualUnmodifiableListView) return _ingredientes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredientes);
}


/// Create a copy of RecipeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeBuilderStateCopyWith<_RecipeBuilderState> get copyWith => __$RecipeBuilderStateCopyWithImpl<_RecipeBuilderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeBuilderState&&(identical(other.editingRecipeId, editingRecipeId) || other.editingRecipeId == editingRecipeId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.raciones, raciones) || other.raciones == raciones)&&const DeepCollectionEquality().equals(other._ingredientes, _ingredientes));
}


@override
int get hashCode => Object.hash(runtimeType,editingRecipeId,nombre,raciones,const DeepCollectionEquality().hash(_ingredientes));

@override
String toString() {
  return 'RecipeBuilderState(editingRecipeId: $editingRecipeId, nombre: $nombre, raciones: $raciones, ingredientes: $ingredientes)';
}


}

/// @nodoc
abstract mixin class _$RecipeBuilderStateCopyWith<$Res> implements $RecipeBuilderStateCopyWith<$Res> {
  factory _$RecipeBuilderStateCopyWith(_RecipeBuilderState value, $Res Function(_RecipeBuilderState) _then) = __$RecipeBuilderStateCopyWithImpl;
@override @useResult
$Res call({
 int? editingRecipeId, String nombre, int raciones, List<RecipeBuilderIngredient> ingredientes
});




}
/// @nodoc
class __$RecipeBuilderStateCopyWithImpl<$Res>
    implements _$RecipeBuilderStateCopyWith<$Res> {
  __$RecipeBuilderStateCopyWithImpl(this._self, this._then);

  final _RecipeBuilderState _self;
  final $Res Function(_RecipeBuilderState) _then;

/// Create a copy of RecipeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? editingRecipeId = freezed,Object? nombre = null,Object? raciones = null,Object? ingredientes = null,}) {
  return _then(_RecipeBuilderState(
editingRecipeId: freezed == editingRecipeId ? _self.editingRecipeId : editingRecipeId // ignore: cast_nullable_to_non_nullable
as int?,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,raciones: null == raciones ? _self.raciones : raciones // ignore: cast_nullable_to_non_nullable
as int,ingredientes: null == ingredientes ? _self._ingredientes : ingredientes // ignore: cast_nullable_to_non_nullable
as List<RecipeBuilderIngredient>,
  ));
}


}

// dart format on
