// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_guard_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteGuardConfig _$RouteGuardConfigFromJson(Map<String, dynamic> json) {
  return _RouteGuardConfig.fromJson(json);
}

/// @nodoc
mixin _$RouteGuardConfig {
  String? get redirectTo => throw _privateConstructorUsedError;
  String? get authFunction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteGuardConfigCopyWith<RouteGuardConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteGuardConfigCopyWith<$Res> {
  factory $RouteGuardConfigCopyWith(
          RouteGuardConfig value, $Res Function(RouteGuardConfig) then) =
      _$RouteGuardConfigCopyWithImpl<$Res, RouteGuardConfig>;
  @useResult
  $Res call({String? redirectTo, String? authFunction});
}

/// @nodoc
class _$RouteGuardConfigCopyWithImpl<$Res, $Val extends RouteGuardConfig>
    implements $RouteGuardConfigCopyWith<$Res> {
  _$RouteGuardConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redirectTo = freezed,
    Object? authFunction = freezed,
  }) {
    return _then(_value.copyWith(
      redirectTo: freezed == redirectTo
          ? _value.redirectTo
          : redirectTo // ignore: cast_nullable_to_non_nullable
              as String?,
      authFunction: freezed == authFunction
          ? _value.authFunction
          : authFunction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteGuardConfigImplCopyWith<$Res>
    implements $RouteGuardConfigCopyWith<$Res> {
  factory _$$RouteGuardConfigImplCopyWith(_$RouteGuardConfigImpl value,
          $Res Function(_$RouteGuardConfigImpl) then) =
      __$$RouteGuardConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? redirectTo, String? authFunction});
}

/// @nodoc
class __$$RouteGuardConfigImplCopyWithImpl<$Res>
    extends _$RouteGuardConfigCopyWithImpl<$Res, _$RouteGuardConfigImpl>
    implements _$$RouteGuardConfigImplCopyWith<$Res> {
  __$$RouteGuardConfigImplCopyWithImpl(_$RouteGuardConfigImpl _value,
      $Res Function(_$RouteGuardConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redirectTo = freezed,
    Object? authFunction = freezed,
  }) {
    return _then(_$RouteGuardConfigImpl(
      redirectTo: freezed == redirectTo
          ? _value.redirectTo
          : redirectTo // ignore: cast_nullable_to_non_nullable
              as String?,
      authFunction: freezed == authFunction
          ? _value.authFunction
          : authFunction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteGuardConfigImpl implements _RouteGuardConfig {
  const _$RouteGuardConfigImpl({this.redirectTo, this.authFunction});

  factory _$RouteGuardConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteGuardConfigImplFromJson(json);

  @override
  final String? redirectTo;
  @override
  final String? authFunction;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteGuardConfigImplCopyWith<_$RouteGuardConfigImpl> get copyWith =>
      __$$RouteGuardConfigImplCopyWithImpl<_$RouteGuardConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteGuardConfigImplToJson(
      this,
    );
  }
}

abstract class _RouteGuardConfig implements RouteGuardConfig {
  const factory _RouteGuardConfig(
      {final String? redirectTo,
      final String? authFunction}) = _$RouteGuardConfigImpl;

  factory _RouteGuardConfig.fromJson(Map<String, dynamic> json) =
      _$RouteGuardConfigImpl.fromJson;

  @override
  String? get redirectTo;
  @override
  String? get authFunction;
  @override
  @JsonKey(ignore: true)
  _$$RouteGuardConfigImplCopyWith<_$RouteGuardConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
