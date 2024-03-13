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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientConfig _$ClientConfigFromJson(Map<String, dynamic> json) {
  return _ClientConfig.fromJson(json);
}

/// @nodoc
mixin _$ClientConfig {
  String? get initialPage => throw _privateConstructorUsedError;
  String? get pageAPI => throw _privateConstructorUsedError;
  String? get beAPI => throw _privateConstructorUsedError;
  List<AppRouteConfig>? get routes => throw _privateConstructorUsedError;
  String? get notFoundPagePath => throw _privateConstructorUsedError;
  String? get uploadFileHost => throw _privateConstructorUsedError;
  Map<String, dynamic>? get socketioHost => throw _privateConstructorUsedError;

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
      String? pageAPI,
      String? beAPI,
      List<AppRouteConfig>? routes,
      String? notFoundPagePath,
      String? uploadFileHost,
      Map<String, dynamic>? socketioHost});
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
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
    Object? routes = freezed,
    Object? notFoundPagePath = freezed,
    Object? uploadFileHost = freezed,
    Object? socketioHost = freezed,
  }) {
    return _then(_value.copyWith(
      initialPage: freezed == initialPage
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
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
      socketioHost: freezed == socketioHost
          ? _value.socketioHost
          : socketioHost // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientConfigImplCopyWith<$Res>
    implements $ClientConfigCopyWith<$Res> {
  factory _$$ClientConfigImplCopyWith(
          _$ClientConfigImpl value, $Res Function(_$ClientConfigImpl) then) =
      __$$ClientConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? initialPage,
      String? pageAPI,
      String? beAPI,
      List<AppRouteConfig>? routes,
      String? notFoundPagePath,
      String? uploadFileHost,
      Map<String, dynamic>? socketioHost});
}

/// @nodoc
class __$$ClientConfigImplCopyWithImpl<$Res>
    extends _$ClientConfigCopyWithImpl<$Res, _$ClientConfigImpl>
    implements _$$ClientConfigImplCopyWith<$Res> {
  __$$ClientConfigImplCopyWithImpl(
      _$ClientConfigImpl _value, $Res Function(_$ClientConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialPage = freezed,
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
    Object? routes = freezed,
    Object? notFoundPagePath = freezed,
    Object? uploadFileHost = freezed,
    Object? socketioHost = freezed,
  }) {
    return _then(_$ClientConfigImpl(
      initialPage: freezed == initialPage
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
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
      socketioHost: freezed == socketioHost
          ? _value._socketioHost
          : socketioHost // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientConfigImpl implements _ClientConfig {
  const _$ClientConfigImpl(
      {this.initialPage,
      this.pageAPI,
      this.beAPI,
      final List<AppRouteConfig>? routes,
      this.notFoundPagePath,
      this.uploadFileHost,
      final Map<String, dynamic>? socketioHost})
      : _routes = routes,
        _socketioHost = socketioHost;

  factory _$ClientConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientConfigImplFromJson(json);

  @override
  final String? initialPage;
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
  final Map<String, dynamic>? _socketioHost;
  @override
  Map<String, dynamic>? get socketioHost {
    final value = _socketioHost;
    if (value == null) return null;
    if (_socketioHost is EqualUnmodifiableMapView) return _socketioHost;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientConfigImplCopyWith<_$ClientConfigImpl> get copyWith =>
      __$$ClientConfigImplCopyWithImpl<_$ClientConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientConfigImplToJson(
      this,
    );
  }
}

abstract class _ClientConfig implements ClientConfig {
  const factory _ClientConfig(
      {final String? initialPage,
      final String? pageAPI,
      final String? beAPI,
      final List<AppRouteConfig>? routes,
      final String? notFoundPagePath,
      final String? uploadFileHost,
      final Map<String, dynamic>? socketioHost}) = _$ClientConfigImpl;

  factory _ClientConfig.fromJson(Map<String, dynamic> json) =
      _$ClientConfigImpl.fromJson;

  @override
  String? get initialPage;
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
  Map<String, dynamic>? get socketioHost;
  @override
  @JsonKey(ignore: true)
  _$$ClientConfigImplCopyWith<_$ClientConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
