// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_macros_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyMacrosState {

 double get kcalConsumidas; double get kcalObjetivo; double get proteinasGramos; double get proteinasObjetivo; double get carbohidratosGramos; double get carbohidratosObjetivo; double get grasasGramos; double get grasasObjetivo; double get aguaObjetivoMl;
/// Create a copy of DailyMacrosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyMacrosStateCopyWith<DailyMacrosState> get copyWith => _$DailyMacrosStateCopyWithImpl<DailyMacrosState>(this as DailyMacrosState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyMacrosState&&(identical(other.kcalConsumidas, kcalConsumidas) || other.kcalConsumidas == kcalConsumidas)&&(identical(other.kcalObjetivo, kcalObjetivo) || other.kcalObjetivo == kcalObjetivo)&&(identical(other.proteinasGramos, proteinasGramos) || other.proteinasGramos == proteinasGramos)&&(identical(other.proteinasObjetivo, proteinasObjetivo) || other.proteinasObjetivo == proteinasObjetivo)&&(identical(other.carbohidratosGramos, carbohidratosGramos) || other.carbohidratosGramos == carbohidratosGramos)&&(identical(other.carbohidratosObjetivo, carbohidratosObjetivo) || other.carbohidratosObjetivo == carbohidratosObjetivo)&&(identical(other.grasasGramos, grasasGramos) || other.grasasGramos == grasasGramos)&&(identical(other.grasasObjetivo, grasasObjetivo) || other.grasasObjetivo == grasasObjetivo)&&(identical(other.aguaObjetivoMl, aguaObjetivoMl) || other.aguaObjetivoMl == aguaObjetivoMl));
}


@override
int get hashCode => Object.hash(runtimeType,kcalConsumidas,kcalObjetivo,proteinasGramos,proteinasObjetivo,carbohidratosGramos,carbohidratosObjetivo,grasasGramos,grasasObjetivo,aguaObjetivoMl);

@override
String toString() {
  return 'DailyMacrosState(kcalConsumidas: $kcalConsumidas, kcalObjetivo: $kcalObjetivo, proteinasGramos: $proteinasGramos, proteinasObjetivo: $proteinasObjetivo, carbohidratosGramos: $carbohidratosGramos, carbohidratosObjetivo: $carbohidratosObjetivo, grasasGramos: $grasasGramos, grasasObjetivo: $grasasObjetivo, aguaObjetivoMl: $aguaObjetivoMl)';
}


}

/// @nodoc
abstract mixin class $DailyMacrosStateCopyWith<$Res>  {
  factory $DailyMacrosStateCopyWith(DailyMacrosState value, $Res Function(DailyMacrosState) _then) = _$DailyMacrosStateCopyWithImpl;
@useResult
$Res call({
 double kcalConsumidas, double kcalObjetivo, double proteinasGramos, double proteinasObjetivo, double carbohidratosGramos, double carbohidratosObjetivo, double grasasGramos, double grasasObjetivo, double aguaObjetivoMl
});




}
/// @nodoc
class _$DailyMacrosStateCopyWithImpl<$Res>
    implements $DailyMacrosStateCopyWith<$Res> {
  _$DailyMacrosStateCopyWithImpl(this._self, this._then);

  final DailyMacrosState _self;
  final $Res Function(DailyMacrosState) _then;

/// Create a copy of DailyMacrosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kcalConsumidas = null,Object? kcalObjetivo = null,Object? proteinasGramos = null,Object? proteinasObjetivo = null,Object? carbohidratosGramos = null,Object? carbohidratosObjetivo = null,Object? grasasGramos = null,Object? grasasObjetivo = null,Object? aguaObjetivoMl = null,}) {
  return _then(_self.copyWith(
kcalConsumidas: null == kcalConsumidas ? _self.kcalConsumidas : kcalConsumidas // ignore: cast_nullable_to_non_nullable
as double,kcalObjetivo: null == kcalObjetivo ? _self.kcalObjetivo : kcalObjetivo // ignore: cast_nullable_to_non_nullable
as double,proteinasGramos: null == proteinasGramos ? _self.proteinasGramos : proteinasGramos // ignore: cast_nullable_to_non_nullable
as double,proteinasObjetivo: null == proteinasObjetivo ? _self.proteinasObjetivo : proteinasObjetivo // ignore: cast_nullable_to_non_nullable
as double,carbohidratosGramos: null == carbohidratosGramos ? _self.carbohidratosGramos : carbohidratosGramos // ignore: cast_nullable_to_non_nullable
as double,carbohidratosObjetivo: null == carbohidratosObjetivo ? _self.carbohidratosObjetivo : carbohidratosObjetivo // ignore: cast_nullable_to_non_nullable
as double,grasasGramos: null == grasasGramos ? _self.grasasGramos : grasasGramos // ignore: cast_nullable_to_non_nullable
as double,grasasObjetivo: null == grasasObjetivo ? _self.grasasObjetivo : grasasObjetivo // ignore: cast_nullable_to_non_nullable
as double,aguaObjetivoMl: null == aguaObjetivoMl ? _self.aguaObjetivoMl : aguaObjetivoMl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyMacrosState].
extension DailyMacrosStatePatterns on DailyMacrosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyMacrosState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyMacrosState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyMacrosState value)  $default,){
final _that = this;
switch (_that) {
case _DailyMacrosState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyMacrosState value)?  $default,){
final _that = this;
switch (_that) {
case _DailyMacrosState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double kcalConsumidas,  double kcalObjetivo,  double proteinasGramos,  double proteinasObjetivo,  double carbohidratosGramos,  double carbohidratosObjetivo,  double grasasGramos,  double grasasObjetivo,  double aguaObjetivoMl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyMacrosState() when $default != null:
return $default(_that.kcalConsumidas,_that.kcalObjetivo,_that.proteinasGramos,_that.proteinasObjetivo,_that.carbohidratosGramos,_that.carbohidratosObjetivo,_that.grasasGramos,_that.grasasObjetivo,_that.aguaObjetivoMl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double kcalConsumidas,  double kcalObjetivo,  double proteinasGramos,  double proteinasObjetivo,  double carbohidratosGramos,  double carbohidratosObjetivo,  double grasasGramos,  double grasasObjetivo,  double aguaObjetivoMl)  $default,) {final _that = this;
switch (_that) {
case _DailyMacrosState():
return $default(_that.kcalConsumidas,_that.kcalObjetivo,_that.proteinasGramos,_that.proteinasObjetivo,_that.carbohidratosGramos,_that.carbohidratosObjetivo,_that.grasasGramos,_that.grasasObjetivo,_that.aguaObjetivoMl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double kcalConsumidas,  double kcalObjetivo,  double proteinasGramos,  double proteinasObjetivo,  double carbohidratosGramos,  double carbohidratosObjetivo,  double grasasGramos,  double grasasObjetivo,  double aguaObjetivoMl)?  $default,) {final _that = this;
switch (_that) {
case _DailyMacrosState() when $default != null:
return $default(_that.kcalConsumidas,_that.kcalObjetivo,_that.proteinasGramos,_that.proteinasObjetivo,_that.carbohidratosGramos,_that.carbohidratosObjetivo,_that.grasasGramos,_that.grasasObjetivo,_that.aguaObjetivoMl);case _:
  return null;

}
}

}

/// @nodoc


class _DailyMacrosState implements DailyMacrosState {
  const _DailyMacrosState({this.kcalConsumidas = 0.0, this.kcalObjetivo = 2000.0, this.proteinasGramos = 0.0, this.proteinasObjetivo = 150.0, this.carbohidratosGramos = 0.0, this.carbohidratosObjetivo = 25.0, this.grasasGramos = 0.0, this.grasasObjetivo = 140.0, this.aguaObjetivoMl = 2500.0});
  

@override@JsonKey() final  double kcalConsumidas;
@override@JsonKey() final  double kcalObjetivo;
@override@JsonKey() final  double proteinasGramos;
@override@JsonKey() final  double proteinasObjetivo;
@override@JsonKey() final  double carbohidratosGramos;
@override@JsonKey() final  double carbohidratosObjetivo;
@override@JsonKey() final  double grasasGramos;
@override@JsonKey() final  double grasasObjetivo;
@override@JsonKey() final  double aguaObjetivoMl;

/// Create a copy of DailyMacrosState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyMacrosStateCopyWith<_DailyMacrosState> get copyWith => __$DailyMacrosStateCopyWithImpl<_DailyMacrosState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyMacrosState&&(identical(other.kcalConsumidas, kcalConsumidas) || other.kcalConsumidas == kcalConsumidas)&&(identical(other.kcalObjetivo, kcalObjetivo) || other.kcalObjetivo == kcalObjetivo)&&(identical(other.proteinasGramos, proteinasGramos) || other.proteinasGramos == proteinasGramos)&&(identical(other.proteinasObjetivo, proteinasObjetivo) || other.proteinasObjetivo == proteinasObjetivo)&&(identical(other.carbohidratosGramos, carbohidratosGramos) || other.carbohidratosGramos == carbohidratosGramos)&&(identical(other.carbohidratosObjetivo, carbohidratosObjetivo) || other.carbohidratosObjetivo == carbohidratosObjetivo)&&(identical(other.grasasGramos, grasasGramos) || other.grasasGramos == grasasGramos)&&(identical(other.grasasObjetivo, grasasObjetivo) || other.grasasObjetivo == grasasObjetivo)&&(identical(other.aguaObjetivoMl, aguaObjetivoMl) || other.aguaObjetivoMl == aguaObjetivoMl));
}


@override
int get hashCode => Object.hash(runtimeType,kcalConsumidas,kcalObjetivo,proteinasGramos,proteinasObjetivo,carbohidratosGramos,carbohidratosObjetivo,grasasGramos,grasasObjetivo,aguaObjetivoMl);

@override
String toString() {
  return 'DailyMacrosState(kcalConsumidas: $kcalConsumidas, kcalObjetivo: $kcalObjetivo, proteinasGramos: $proteinasGramos, proteinasObjetivo: $proteinasObjetivo, carbohidratosGramos: $carbohidratosGramos, carbohidratosObjetivo: $carbohidratosObjetivo, grasasGramos: $grasasGramos, grasasObjetivo: $grasasObjetivo, aguaObjetivoMl: $aguaObjetivoMl)';
}


}

/// @nodoc
abstract mixin class _$DailyMacrosStateCopyWith<$Res> implements $DailyMacrosStateCopyWith<$Res> {
  factory _$DailyMacrosStateCopyWith(_DailyMacrosState value, $Res Function(_DailyMacrosState) _then) = __$DailyMacrosStateCopyWithImpl;
@override @useResult
$Res call({
 double kcalConsumidas, double kcalObjetivo, double proteinasGramos, double proteinasObjetivo, double carbohidratosGramos, double carbohidratosObjetivo, double grasasGramos, double grasasObjetivo, double aguaObjetivoMl
});




}
/// @nodoc
class __$DailyMacrosStateCopyWithImpl<$Res>
    implements _$DailyMacrosStateCopyWith<$Res> {
  __$DailyMacrosStateCopyWithImpl(this._self, this._then);

  final _DailyMacrosState _self;
  final $Res Function(_DailyMacrosState) _then;

/// Create a copy of DailyMacrosState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kcalConsumidas = null,Object? kcalObjetivo = null,Object? proteinasGramos = null,Object? proteinasObjetivo = null,Object? carbohidratosGramos = null,Object? carbohidratosObjetivo = null,Object? grasasGramos = null,Object? grasasObjetivo = null,Object? aguaObjetivoMl = null,}) {
  return _then(_DailyMacrosState(
kcalConsumidas: null == kcalConsumidas ? _self.kcalConsumidas : kcalConsumidas // ignore: cast_nullable_to_non_nullable
as double,kcalObjetivo: null == kcalObjetivo ? _self.kcalObjetivo : kcalObjetivo // ignore: cast_nullable_to_non_nullable
as double,proteinasGramos: null == proteinasGramos ? _self.proteinasGramos : proteinasGramos // ignore: cast_nullable_to_non_nullable
as double,proteinasObjetivo: null == proteinasObjetivo ? _self.proteinasObjetivo : proteinasObjetivo // ignore: cast_nullable_to_non_nullable
as double,carbohidratosGramos: null == carbohidratosGramos ? _self.carbohidratosGramos : carbohidratosGramos // ignore: cast_nullable_to_non_nullable
as double,carbohidratosObjetivo: null == carbohidratosObjetivo ? _self.carbohidratosObjetivo : carbohidratosObjetivo // ignore: cast_nullable_to_non_nullable
as double,grasasGramos: null == grasasGramos ? _self.grasasGramos : grasasGramos // ignore: cast_nullable_to_non_nullable
as double,grasasObjetivo: null == grasasObjetivo ? _self.grasasObjetivo : grasasObjetivo // ignore: cast_nullable_to_non_nullable
as double,aguaObjetivoMl: null == aguaObjetivoMl ? _self.aguaObjetivoMl : aguaObjetivoMl // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
