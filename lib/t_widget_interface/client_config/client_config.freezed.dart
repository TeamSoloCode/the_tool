// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClientConfig _$ClientConfigFromJson(Map<String, dynamic> json) {
  return _ClientConfig.fromJson(json);
}

/// @nodoc
mixin _$ClientConfig {
  String? get initialPage => throw _privateConstructorUsedError;
  String? get themePath => throw _privateConstructorUsedError;
  String? get pageAPI => throw _privateConstructorUsedError;
  String? get beAPI => throw _privateConstructorUsedError;
  List<AppRouteConfig>? get routes => throw _privateConstructorUsedError;
  String? get notFoundPagePath => throw _privateConstructorUsedError;
  String? get uploadFileHost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientConfigCopyWith<ClientConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientConfigCopyWith<$Res> {
  factory $ClientConfigCopyWith(
          ClientConfig value, $Res Function(ClientConfig) then) =
      _$ClientConfigCopyWithImpl<$Res, ClientConfig>;
  @useResult
  $Res call(
      {String? initialPage,
      String? themePath,
      String? pageAPI,
      String? beAPI,
      List<AppRouteConfig>? routes,
      String? notFoundPagePath,
      String? uploadFileHost});
}

/// @nodoc
class _$ClientConfigCopyWithImpl<$Res, $Val extends ClientConfig>
    implements $ClientConfigCopyWith<$Res> {
  _$ClientConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialPage = freezed,
    Object? themePath = freezed,
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
    Object? routes = freezed,
    Object? notFoundPagePath = freezed,
    Object? uploadFileHost = freezed,
  }) {
    return _then(_value.copyWith(
      initialPage: freezed == initialPage
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
              as String?,
      themePath: freezed == themePath
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      pageAPI: freezed == pageAPI
          ? _value.pageAPI
          : pageAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      beAPI: freezed == beAPI
          ? _value.beAPI
          : beAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      routes: freezed == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<AppRouteConfig>?,
      notFoundPagePath: freezed == notFoundPagePath
          ? _value.notFoundPagePath
          : notFoundPagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadFileHost: freezed == uploadFileHost
          ? _value.uploadFileHost
          : uploadFileHost // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClientConfigCopyWith<$Res>
    implements $ClientConfigCopyWith<$Res> {
  factory _$$_ClientConfigCopyWith(
          _$_ClientConfig value, $Res Function(_$_ClientConfig) then) =
      __$$_ClientConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? initialPage,
      String? themePath,
      String? pageAPI,
      String? beAPI,
      List<AppRouteConfig>? routes,
      String? notFoundPagePath,
      String? uploadFileHost});
}

/// @nodoc
class __$$_ClientConfigCopyWithImpl<$Res>
    extends _$ClientConfigCopyWithImpl<$Res, _$_ClientConfig>
    implements _$$_ClientConfigCopyWith<$Res> {
  __$$_ClientConfigCopyWithImpl(
      _$_ClientConfig _value, $Res Function(_$_ClientConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialPage = freezed,
    Object? themePath = freezed,
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
    Object? routes = freezed,
    Object? notFoundPagePath = freezed,
    Object? uploadFileHost = freezed,
  }) {
    return _then(_$_ClientConfig(
      initialPage: freezed == initialPage
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
              as String?,
      themePath: freezed == themePath
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      pageAPI: freezed == pageAPI
          ? _value.pageAPI
          : pageAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      beAPI: freezed == beAPI
          ? _value.beAPI
          : beAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      routes: freezed == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<AppRouteConfig>?,
      notFoundPagePath: freezed == notFoundPagePath
          ? _value.notFoundPagePath
          : notFoundPagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadFileHost: freezed == uploadFileHost
          ? _value.uploadFileHost
          : uploadFileHost // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClientConfig implements _ClientConfig {
  const _$_ClientConfig(
      {this.initialPage,
      this.themePath,
      this.pageAPI,
      this.beAPI,
      final List<AppRouteConfig>? routes,
      this.notFoundPagePath,
      this.uploadFileHost})
      : _routes = routes;

  factory _$_ClientConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ClientConfigFromJson(json);

  @override
  final String? initialPage;
  @override
  final String? themePath;
  @override
  final String? pageAPI;
  @override
  final String? beAPI;
  final List<AppRouteConfig>? _routes;
  @override
  List<AppRouteConfig>? get routes {
    final value = _routes;
    if (value == null) return null;
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? notFoundPagePath;
  @override
  final String? uploadFileHost;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClientConfigCopyWith<_$_ClientConfig> get copyWith =>
      __$$_ClientConfigCopyWithImpl<_$_ClientConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientConfigToJson(
      this,
    );
  }
}

abstract class _ClientConfig implements ClientConfig {
  const factory _ClientConfig(
      {final String? initialPage,
      final String? themePath,
      final String? pageAPI,
      final String? beAPI,
      final List<AppRouteConfig>? routes,
      final String? notFoundPagePath,
      final String? uploadFileHost}) = _$_ClientConfig;

  factory _ClientConfig.fromJson(Map<String, dynamic> json) =
      _$_ClientConfig.fromJson;

  @override
  String? get initialPage;
  @override
  String? get themePath;
  @override
  String? get pageAPI;
  @override
  String? get beAPI;
  @override
  List<AppRouteConfig>? get routes;
  @override
  String? get notFoundPagePath;
  @override
  String? get uploadFileHost;
  @override
  @JsonKey(ignore: true)
  _$$_ClientConfigCopyWith<_$_ClientConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
