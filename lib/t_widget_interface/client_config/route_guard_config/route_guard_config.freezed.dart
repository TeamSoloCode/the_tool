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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RouteGuardConfig _$RouteGuardConfigFromJson(Map<String, dynamic> json) {
  return _RouteGuardConfig.fromJson(json);
}

/// @nodoc
mixin _$RouteGuardConfig {
  String? get authKey => throw _privateConstructorUsedError;
  String? get redirectTo => throw _privateConstructorUsedError;

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
  $Res call({String? authKey, String? redirectTo});
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
    Object? authKey = freezed,
    Object? redirectTo = freezed,
  }) {
    return _then(_value.copyWith(
      authKey: freezed == authKey
          ? _value.authKey
          : authKey // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectTo: freezed == redirectTo
          ? _value.redirectTo
          : redirectTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RouteGuardConfigCopyWith<$Res>
    implements $RouteGuardConfigCopyWith<$Res> {
  factory _$$_RouteGuardConfigCopyWith(
          _$_RouteGuardConfig value, $Res Function(_$_RouteGuardConfig) then) =
      __$$_RouteGuardConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? authKey, String? redirectTo});
}

/// @nodoc
class __$$_RouteGuardConfigCopyWithImpl<$Res>
    extends _$RouteGuardConfigCopyWithImpl<$Res, _$_RouteGuardConfig>
    implements _$$_RouteGuardConfigCopyWith<$Res> {
  __$$_RouteGuardConfigCopyWithImpl(
      _$_RouteGuardConfig _value, $Res Function(_$_RouteGuardConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authKey = freezed,
    Object? redirectTo = freezed,
  }) {
    return _then(_$_RouteGuardConfig(
      authKey: freezed == authKey
          ? _value.authKey
          : authKey // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectTo: freezed == redirectTo
          ? _value.redirectTo
          : redirectTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RouteGuardConfig implements _RouteGuardConfig {
  const _$_RouteGuardConfig({this.authKey, this.redirectTo});

  factory _$_RouteGuardConfig.fromJson(Map<String, dynamic> json) =>
      _$$_RouteGuardConfigFromJson(json);

  @override
  final String? authKey;
  @override
  final String? redirectTo;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RouteGuardConfigCopyWith<_$_RouteGuardConfig> get copyWith =>
      __$$_RouteGuardConfigCopyWithImpl<_$_RouteGuardConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RouteGuardConfigToJson(
      this,
    );
  }
}

abstract class _RouteGuardConfig implements RouteGuardConfig {
  const factory _RouteGuardConfig(
      {final String? authKey, final String? redirectTo}) = _$_RouteGuardConfig;

  factory _RouteGuardConfig.fromJson(Map<String, dynamic> json) =
      _$_RouteGuardConfig.fromJson;

  @override
  String? get authKey;
  @override
  String? get redirectTo;
  @override
  @JsonKey(ignore: true)
  _$$_RouteGuardConfigCopyWith<_$_RouteGuardConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
