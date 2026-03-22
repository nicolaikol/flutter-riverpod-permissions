// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Perm {

 PermissionStatus get status;
/// Create a copy of Perm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermCopyWith<Perm> get copyWith => _$PermCopyWithImpl<Perm>(this as Perm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Perm&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'Perm(status: $status)';
}


}

/// @nodoc
abstract mixin class $PermCopyWith<$Res>  {
  factory $PermCopyWith(Perm value, $Res Function(Perm) _then) = _$PermCopyWithImpl;
@useResult
$Res call({
 PermissionStatus status
});




}
/// @nodoc
class _$PermCopyWithImpl<$Res>
    implements $PermCopyWith<$Res> {
  _$PermCopyWithImpl(this._self, this._then);

  final Perm _self;
  final $Res Function(Perm) _then;

/// Create a copy of Perm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PermissionStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [Perm].
extension PermPatterns on Perm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Perm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Perm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Perm value)  $default,){
final _that = this;
switch (_that) {
case _Perm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Perm value)?  $default,){
final _that = this;
switch (_that) {
case _Perm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PermissionStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Perm() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PermissionStatus status)  $default,) {final _that = this;
switch (_that) {
case _Perm():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PermissionStatus status)?  $default,) {final _that = this;
switch (_that) {
case _Perm() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Perm extends Perm {
  const _Perm({required this.status}): super._();
  

@override final  PermissionStatus status;

/// Create a copy of Perm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermCopyWith<_Perm> get copyWith => __$PermCopyWithImpl<_Perm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Perm&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'Perm(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PermCopyWith<$Res> implements $PermCopyWith<$Res> {
  factory _$PermCopyWith(_Perm value, $Res Function(_Perm) _then) = __$PermCopyWithImpl;
@override @useResult
$Res call({
 PermissionStatus status
});




}
/// @nodoc
class __$PermCopyWithImpl<$Res>
    implements _$PermCopyWith<$Res> {
  __$PermCopyWithImpl(this._self, this._then);

  final _Perm _self;
  final $Res Function(_Perm) _then;

/// Create a copy of Perm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_Perm(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PermissionStatus,
  ));
}


}

// dart format on
