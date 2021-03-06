// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  List<Map<String, dynamic>>? get routes => throw _privateConstructorUsedError;
  String? get themePath => throw _privateConstructorUsedError;
  String? get pageAPI => throw _privateConstructorUsedError;
  String? get beAPI => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientConfigCopyWith<ClientConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientConfigCopyWith<$Res> {
  factory $ClientConfigCopyWith(
          ClientConfig value, $Res Function(ClientConfig) then) =
      _$ClientConfigCopyWithImpl<$Res>;
  $Res call(
      {String? initialPage,
      List<Map<String, dynamic>>? routes,
      String? themePath,
      String? pageAPI,
      String? beAPI});
}

/// @nodoc
class _$ClientConfigCopyWithImpl<$Res> implements $ClientConfigCopyWith<$Res> {
  _$ClientConfigCopyWithImpl(this._value, this._then);

  final ClientConfig _value;
  // ignore: unused_field
  final $Res Function(ClientConfig) _then;

  @override
  $Res call({
    Object? initialPage = freezed,
    Object? routes = freezed,
    Object? themePath = freezed,
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
  }) {
    return _then(_value.copyWith(
      initialPage: initialPage == freezed
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
              as String?,
      routes: routes == freezed
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      themePath: themePath == freezed
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      pageAPI: pageAPI == freezed
          ? _value.pageAPI
          : pageAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      beAPI: beAPI == freezed
          ? _value.beAPI
          : beAPI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ClientConfigCopyWith<$Res>
    implements $ClientConfigCopyWith<$Res> {
  factory _$$_ClientConfigCopyWith(
          _$_ClientConfig value, $Res Function(_$_ClientConfig) then) =
      __$$_ClientConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? initialPage,
      List<Map<String, dynamic>>? routes,
      String? themePath,
      String? pageAPI,
      String? beAPI});
}

/// @nodoc
class __$$_ClientConfigCopyWithImpl<$Res>
    extends _$ClientConfigCopyWithImpl<$Res>
    implements _$$_ClientConfigCopyWith<$Res> {
  __$$_ClientConfigCopyWithImpl(
      _$_ClientConfig _value, $Res Function(_$_ClientConfig) _then)
      : super(_value, (v) => _then(v as _$_ClientConfig));

  @override
  _$_ClientConfig get _value => super._value as _$_ClientConfig;

  @override
  $Res call({
    Object? initialPage = freezed,
    Object? routes = freezed,
    Object? themePath = freezed,
    Object? pageAPI = freezed,
    Object? beAPI = freezed,
  }) {
    return _then(_$_ClientConfig(
      initialPage: initialPage == freezed
          ? _value.initialPage
          : initialPage // ignore: cast_nullable_to_non_nullable
              as String?,
      routes: routes == freezed
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      themePath: themePath == freezed
          ? _value.themePath
          : themePath // ignore: cast_nullable_to_non_nullable
              as String?,
      pageAPI: pageAPI == freezed
          ? _value.pageAPI
          : pageAPI // ignore: cast_nullable_to_non_nullable
              as String?,
      beAPI: beAPI == freezed
          ? _value.beAPI
          : beAPI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClientConfig with DiagnosticableTreeMixin implements _ClientConfig {
  const _$_ClientConfig(
      {this.initialPage,
      final List<Map<String, dynamic>>? routes,
      this.themePath,
      this.pageAPI,
      this.beAPI})
      : _routes = routes;

  factory _$_ClientConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ClientConfigFromJson(json);

  @override
  final String? initialPage;
  final List<Map<String, dynamic>>? _routes;
  @override
  List<Map<String, dynamic>>? get routes {
    final value = _routes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? themePath;
  @override
  final String? pageAPI;
  @override
  final String? beAPI;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientConfig(initialPage: $initialPage, routes: $routes, themePath: $themePath, pageAPI: $pageAPI, beAPI: $beAPI)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientConfig'))
      ..add(DiagnosticsProperty('initialPage', initialPage))
      ..add(DiagnosticsProperty('routes', routes))
      ..add(DiagnosticsProperty('themePath', themePath))
      ..add(DiagnosticsProperty('pageAPI', pageAPI))
      ..add(DiagnosticsProperty('beAPI', beAPI));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientConfig &&
            const DeepCollectionEquality()
                .equals(other.initialPage, initialPage) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            const DeepCollectionEquality().equals(other.themePath, themePath) &&
            const DeepCollectionEquality().equals(other.pageAPI, pageAPI) &&
            const DeepCollectionEquality().equals(other.beAPI, beAPI));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(initialPage),
      const DeepCollectionEquality().hash(_routes),
      const DeepCollectionEquality().hash(themePath),
      const DeepCollectionEquality().hash(pageAPI),
      const DeepCollectionEquality().hash(beAPI));

  @JsonKey(ignore: true)
  @override
  _$$_ClientConfigCopyWith<_$_ClientConfig> get copyWith =>
      __$$_ClientConfigCopyWithImpl<_$_ClientConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientConfigToJson(this);
  }
}

abstract class _ClientConfig implements ClientConfig {
  const factory _ClientConfig(
      {final String? initialPage,
      final List<Map<String, dynamic>>? routes,
      final String? themePath,
      final String? pageAPI,
      final String? beAPI}) = _$_ClientConfig;

  factory _ClientConfig.fromJson(Map<String, dynamic> json) =
      _$_ClientConfig.fromJson;

  @override
  String? get initialPage;
  @override
  List<Map<String, dynamic>>? get routes;
  @override
  String? get themePath;
  @override
  String? get pageAPI;
  @override
  String? get beAPI;
  @override
  @JsonKey(ignore: true)
  _$$_ClientConfigCopyWith<_$_ClientConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
