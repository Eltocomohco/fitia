// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_profile_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyProfileState {

 int get edad; double get alturaCm;
/// Create a copy of BodyProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyProfileStateCopyWith<BodyProfileState> get copyWith => _$BodyProfileStateCopyWithImpl<BodyProfileState>(this as BodyProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyProfileState&&(identical(other.edad, edad) || other.edad == edad)&&(identical(other.alturaCm, alturaCm) || other.alturaCm == alturaCm));
}


@override
int get hashCode => Object.hash(runtimeType,edad,alturaCm);

@override
String toString() {
  return 'BodyProfileState(edad: $edad, alturaCm: $alturaCm)';
}


}

/// @nodoc
abstract mixin class $BodyProfileStateCopyWith<$Res>  {
  factory $BodyProfileStateCopyWith(BodyProfileState value, $Res Function(BodyProfileState) _then) = _$BodyProfileStateCopyWithImpl;
@useResult
$Res call({
 int edad, double alturaCm
});




}
/// @nodoc
class _$BodyProfileStateCopyWithImpl<$Res>
    implements $BodyProfileStateCopyWith<$Res> {
  _$BodyProfileStateCopyWithImpl(this._self, this._then);

  final BodyProfileState _self;
  final $Res Function(BodyProfileState) _then;

/// Create a copy of BodyProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? edad = null,Object? alturaCm = null,}) {
  return _then(_self.copyWith(
edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,alturaCm: null == alturaCm ? _self.alturaCm : alturaCm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyProfileState].
extension BodyProfileStatePatterns on BodyProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyProfileState value)  $default,){
final _that = this;
switch (_that) {
case _BodyProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _BodyProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int edad,  double alturaCm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyProfileState() when $default != null:
return $default(_that.edad,_that.alturaCm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int edad,  double alturaCm)  $default,) {final _that = this;
switch (_that) {
case _BodyProfileState():
return $default(_that.edad,_that.alturaCm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int edad,  double alturaCm)?  $default,) {final _that = this;
switch (_that) {
case _BodyProfileState() when $default != null:
return $default(_that.edad,_that.alturaCm);case _:
  return null;

}
}

}

/// @nodoc


class _BodyProfileState implements BodyProfileState {
  const _BodyProfileState({this.edad = 34, this.alturaCm = 176.0});
  

@override@JsonKey() final  int edad;
@override@JsonKey() final  double alturaCm;

/// Create a copy of BodyProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyProfileStateCopyWith<_BodyProfileState> get copyWith => __$BodyProfileStateCopyWithImpl<_BodyProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyProfileState&&(identical(other.edad, edad) || other.edad == edad)&&(identical(other.alturaCm, alturaCm) || other.alturaCm == alturaCm));
}


@override
int get hashCode => Object.hash(runtimeType,edad,alturaCm);

@override
String toString() {
  return 'BodyProfileState(edad: $edad, alturaCm: $alturaCm)';
}


}

/// @nodoc
abstract mixin class _$BodyProfileStateCopyWith<$Res> implements $BodyProfileStateCopyWith<$Res> {
  factory _$BodyProfileStateCopyWith(_BodyProfileState value, $Res Function(_BodyProfileState) _then) = __$BodyProfileStateCopyWithImpl;
@override @useResult
$Res call({
 int edad, double alturaCm
});




}
/// @nodoc
class __$BodyProfileStateCopyWithImpl<$Res>
    implements _$BodyProfileStateCopyWith<$Res> {
  __$BodyProfileStateCopyWithImpl(this._self, this._then);

  final _BodyProfileState _self;
  final $Res Function(_BodyProfileState) _then;

/// Create a copy of BodyProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? edad = null,Object? alturaCm = null,}) {
  return _then(_BodyProfileState(
edad: null == edad ? _self.edad : edad // ignore: cast_nullable_to_non_nullable
as int,alturaCm: null == alturaCm ? _self.alturaCm : alturaCm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
