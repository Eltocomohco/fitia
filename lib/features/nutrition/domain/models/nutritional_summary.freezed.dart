// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutritional_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NutritionalSummary {

 double get kcal; double get proteinas; double get carbohidratos; double get grasas;
/// Create a copy of NutritionalSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionalSummaryCopyWith<NutritionalSummary> get copyWith => _$NutritionalSummaryCopyWithImpl<NutritionalSummary>(this as NutritionalSummary, _$identity);

  /// Serializes this NutritionalSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionalSummary&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.proteinas, proteinas) || other.proteinas == proteinas)&&(identical(other.carbohidratos, carbohidratos) || other.carbohidratos == carbohidratos)&&(identical(other.grasas, grasas) || other.grasas == grasas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kcal,proteinas,carbohidratos,grasas);

@override
String toString() {
  return 'NutritionalSummary(kcal: $kcal, proteinas: $proteinas, carbohidratos: $carbohidratos, grasas: $grasas)';
}


}

/// @nodoc
abstract mixin class $NutritionalSummaryCopyWith<$Res>  {
  factory $NutritionalSummaryCopyWith(NutritionalSummary value, $Res Function(NutritionalSummary) _then) = _$NutritionalSummaryCopyWithImpl;
@useResult
$Res call({
 double kcal, double proteinas, double carbohidratos, double grasas
});




}
/// @nodoc
class _$NutritionalSummaryCopyWithImpl<$Res>
    implements $NutritionalSummaryCopyWith<$Res> {
  _$NutritionalSummaryCopyWithImpl(this._self, this._then);

  final NutritionalSummary _self;
  final $Res Function(NutritionalSummary) _then;

/// Create a copy of NutritionalSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kcal = null,Object? proteinas = null,Object? carbohidratos = null,Object? grasas = null,}) {
  return _then(_self.copyWith(
kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,proteinas: null == proteinas ? _self.proteinas : proteinas // ignore: cast_nullable_to_non_nullable
as double,carbohidratos: null == carbohidratos ? _self.carbohidratos : carbohidratos // ignore: cast_nullable_to_non_nullable
as double,grasas: null == grasas ? _self.grasas : grasas // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionalSummary].
extension NutritionalSummaryPatterns on NutritionalSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionalSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionalSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionalSummary value)  $default,){
final _that = this;
switch (_that) {
case _NutritionalSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionalSummary value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionalSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double kcal,  double proteinas,  double carbohidratos,  double grasas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionalSummary() when $default != null:
return $default(_that.kcal,_that.proteinas,_that.carbohidratos,_that.grasas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double kcal,  double proteinas,  double carbohidratos,  double grasas)  $default,) {final _that = this;
switch (_that) {
case _NutritionalSummary():
return $default(_that.kcal,_that.proteinas,_that.carbohidratos,_that.grasas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double kcal,  double proteinas,  double carbohidratos,  double grasas)?  $default,) {final _that = this;
switch (_that) {
case _NutritionalSummary() when $default != null:
return $default(_that.kcal,_that.proteinas,_that.carbohidratos,_that.grasas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionalSummary implements NutritionalSummary {
  const _NutritionalSummary({this.kcal = 0, this.proteinas = 0, this.carbohidratos = 0, this.grasas = 0});
  factory _NutritionalSummary.fromJson(Map<String, dynamic> json) => _$NutritionalSummaryFromJson(json);

@override@JsonKey() final  double kcal;
@override@JsonKey() final  double proteinas;
@override@JsonKey() final  double carbohidratos;
@override@JsonKey() final  double grasas;

/// Create a copy of NutritionalSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionalSummaryCopyWith<_NutritionalSummary> get copyWith => __$NutritionalSummaryCopyWithImpl<_NutritionalSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionalSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionalSummary&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.proteinas, proteinas) || other.proteinas == proteinas)&&(identical(other.carbohidratos, carbohidratos) || other.carbohidratos == carbohidratos)&&(identical(other.grasas, grasas) || other.grasas == grasas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kcal,proteinas,carbohidratos,grasas);

@override
String toString() {
  return 'NutritionalSummary(kcal: $kcal, proteinas: $proteinas, carbohidratos: $carbohidratos, grasas: $grasas)';
}


}

/// @nodoc
abstract mixin class _$NutritionalSummaryCopyWith<$Res> implements $NutritionalSummaryCopyWith<$Res> {
  factory _$NutritionalSummaryCopyWith(_NutritionalSummary value, $Res Function(_NutritionalSummary) _then) = __$NutritionalSummaryCopyWithImpl;
@override @useResult
$Res call({
 double kcal, double proteinas, double carbohidratos, double grasas
});




}
/// @nodoc
class __$NutritionalSummaryCopyWithImpl<$Res>
    implements _$NutritionalSummaryCopyWith<$Res> {
  __$NutritionalSummaryCopyWithImpl(this._self, this._then);

  final _NutritionalSummary _self;
  final $Res Function(_NutritionalSummary) _then;

/// Create a copy of NutritionalSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kcal = null,Object? proteinas = null,Object? carbohidratos = null,Object? grasas = null,}) {
  return _then(_NutritionalSummary(
kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as double,proteinas: null == proteinas ? _self.proteinas : proteinas // ignore: cast_nullable_to_non_nullable
as double,carbohidratos: null == carbohidratos ? _self.carbohidratos : carbohidratos // ignore: cast_nullable_to_non_nullable
as double,grasas: null == grasas ? _self.grasas : grasas // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
