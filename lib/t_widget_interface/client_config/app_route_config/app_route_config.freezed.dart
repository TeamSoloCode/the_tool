// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_route_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppRouteConfig _$AppRouteConfigFromJson(Map<String, dynamic> json) {
  return _AppRouteConfig.fromJson(json);
}

/// @nodoc
mixin _$AppRouteConfig {
  String? get path => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get route => throw _privateConstructorUsedError;
  List<RouteGuardConfig>? get guards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppRouteConfigCopyWith<AppRouteConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppRouteConfigCopyWith<$Res> {
  factory $AppRouteConfigCopyWith(
          AppRouteConfig value, $Res Function(AppRouteConfig) then) =
      _$AppRouteConfigCopyWithImpl<$Res, AppRouteConfig>;
  @useResult
  $Res call(
      {String? path,
      String? name,
      String? route,
      List<RouteGuardConfig>? guards});
}

/// @nodoc
class _$AppRouteConfigCopyWithImpl<$Res, $Val extends AppRouteConfig>
    implements $AppRouteConfigCopyWith<$Res> {
  _$AppRouteConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? name = freezed,
    Object? route = freezed,
    Object? guards = freezed,
  }) {
    return _then(_value.copyWith(
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      guards: freezed == guards
          ? _value.guards
          : guards // ignore: cast_nullable_to_non_nullable
              as List<RouteGuardConfig>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppRouteConfigCopyWith<$Res>
    implements $AppRouteConfigCopyWith<$Res> {
  factory _$$_AppRouteConfigCopyWith(
          _$_AppRouteConfig value, $Res Function(_$_AppRouteConfig) then) =
      __$$_AppRouteConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? path,
      String? name,
      String? route,
      List<RouteGuardConfig>? guards});
}

/// @nodoc
class __$$_AppRouteConfigCopyWithImpl<$Res>
    extends _$AppRouteConfigCopyWithImpl<$Res, _$_AppRouteConfig>
    implements _$$_AppRouteConfigCopyWith<$Res> {
  __$$_AppRouteConfigCopyWithImpl(
      _$_AppRouteConfig _value, $Res Function(_$_AppRouteConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? name = freezed,
    Object? route = freezed,
    Object? guards = freezed,
  }) {
    return _then(_$_AppRouteConfig(
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      guards: freezed == guards
          ? _value._guards
          : guards // ignore: cast_nullable_to_non_nullable
              as List<RouteGuardConfig>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppRouteConfig implements _AppRouteConfig {
  const _$_AppRouteConfig(
      {this.path, this.name, this.route, final List<RouteGuardConfig>? guards})
      : _guards = guards;

  factory _$_AppRouteConfig.fromJson(Map<String, dynamic> json) =>
      _$$_AppRouteConfigFromJson(json);

  @override
  final String? path;
  @override
  final String? name;
  @override
  final String? route;
  final List<RouteGuardConfig>? _guards;
  @override
  List<RouteGuardConfig>? get guards {
    final value = _guards;
    if (value == null) return null;
    if (_guards is EqualUnmodifiableListView) return _guards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppRouteConfigCopyWith<_$_AppRouteConfig> get copyWith =>
      __$$_AppRouteConfigCopyWithImpl<_$_AppRouteConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppRouteConfigToJson(
      this,
    );
  }
}

abstract class _AppRouteConfig implements AppRouteConfig {
  const factory _AppRouteConfig(
      {final String? path,
      final String? name,
      final String? route,
      final List<RouteGuardConfig>? guards}) = _$_AppRouteConfig;

  factory _AppRouteConfig.fromJson(Map<String, dynamic> json) =
      _$_AppRouteConfig.fromJson;

  @override
  String? get path;
  @override
  String? get name;
  @override
  String? get route;
  @override
  List<RouteGuardConfig>? get guards;
  @override
  @JsonKey(ignore: true)
  _$$_AppRouteConfigCopyWith<_$_AppRouteConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
