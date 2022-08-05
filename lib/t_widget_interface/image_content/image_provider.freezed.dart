// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageProviderProps _$ImageProviderPropsFromJson(Map<String, dynamic> json) {
  return _ImageProviderProps.fromJson(json);
}

/// @nodoc
mixin _$ImageProviderProps {
  String? get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get headers => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get asset => throw _privateConstructorUsedError;
  int? get scale => throw _privateConstructorUsedError;
  String? get fit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageProviderPropsCopyWith<ImageProviderProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageProviderPropsCopyWith<$Res> {
  factory $ImageProviderPropsCopyWith(
          ImageProviderProps value, $Res Function(ImageProviderProps) then) =
      _$ImageProviderPropsCopyWithImpl<$Res>;
  $Res call(
      {String? type,
      Map<String, dynamic>? headers,
      String? url,
      String? asset,
      int? scale,
      String? fit});
}

/// @nodoc
class _$ImageProviderPropsCopyWithImpl<$Res>
    implements $ImageProviderPropsCopyWith<$Res> {
  _$ImageProviderPropsCopyWithImpl(this._value, this._then);

  final ImageProviderProps _value;
  // ignore: unused_field
  final $Res Function(ImageProviderProps) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? headers = freezed,
    Object? url = freezed,
    Object? asset = freezed,
    Object? scale = freezed,
    Object? fit = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: headers == freezed
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as int?,
      fit: fit == freezed
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ImageProviderPropsCopyWith<$Res>
    implements $ImageProviderPropsCopyWith<$Res> {
  factory _$$_ImageProviderPropsCopyWith(_$_ImageProviderProps value,
          $Res Function(_$_ImageProviderProps) then) =
      __$$_ImageProviderPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? type,
      Map<String, dynamic>? headers,
      String? url,
      String? asset,
      int? scale,
      String? fit});
}

/// @nodoc
class __$$_ImageProviderPropsCopyWithImpl<$Res>
    extends _$ImageProviderPropsCopyWithImpl<$Res>
    implements _$$_ImageProviderPropsCopyWith<$Res> {
  __$$_ImageProviderPropsCopyWithImpl(
      _$_ImageProviderProps _value, $Res Function(_$_ImageProviderProps) _then)
      : super(_value, (v) => _then(v as _$_ImageProviderProps));

  @override
  _$_ImageProviderProps get _value => super._value as _$_ImageProviderProps;

  @override
  $Res call({
    Object? type = freezed,
    Object? headers = freezed,
    Object? url = freezed,
    Object? asset = freezed,
    Object? scale = freezed,
    Object? fit = freezed,
  }) {
    return _then(_$_ImageProviderProps(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: headers == freezed
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as int?,
      fit: fit == freezed
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageProviderProps
    with DiagnosticableTreeMixin
    implements _ImageProviderProps {
  const _$_ImageProviderProps(
      {this.type,
      final Map<String, dynamic>? headers,
      this.url,
      this.asset,
      this.scale,
      this.fit})
      : _headers = headers;

  factory _$_ImageProviderProps.fromJson(Map<String, dynamic> json) =>
      _$$_ImageProviderPropsFromJson(json);

  @override
  final String? type;
  final Map<String, dynamic>? _headers;
  @override
  Map<String, dynamic>? get headers {
    final value = _headers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? url;
  @override
  final String? asset;
  @override
  final int? scale;
  @override
  final String? fit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageProviderProps(type: $type, headers: $headers, url: $url, asset: $asset, scale: $scale, fit: $fit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageProviderProps'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('headers', headers))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('asset', asset))
      ..add(DiagnosticsProperty('scale', scale))
      ..add(DiagnosticsProperty('fit', fit));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageProviderProps &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.asset, asset) &&
            const DeepCollectionEquality().equals(other.scale, scale) &&
            const DeepCollectionEquality().equals(other.fit, fit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(asset),
      const DeepCollectionEquality().hash(scale),
      const DeepCollectionEquality().hash(fit));

  @JsonKey(ignore: true)
  @override
  _$$_ImageProviderPropsCopyWith<_$_ImageProviderProps> get copyWith =>
      __$$_ImageProviderPropsCopyWithImpl<_$_ImageProviderProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageProviderPropsToJson(this);
  }
}

abstract class _ImageProviderProps implements ImageProviderProps {
  const factory _ImageProviderProps(
      {final String? type,
      final Map<String, dynamic>? headers,
      final String? url,
      final String? asset,
      final int? scale,
      final String? fit}) = _$_ImageProviderProps;

  factory _ImageProviderProps.fromJson(Map<String, dynamic> json) =
      _$_ImageProviderProps.fromJson;

  @override
  String? get type;
  @override
  Map<String, dynamic>? get headers;
  @override
  String? get url;
  @override
  String? get asset;
  @override
  int? get scale;
  @override
  String? get fit;
  @override
  @JsonKey(ignore: true)
  _$$_ImageProviderPropsCopyWith<_$_ImageProviderProps> get copyWith =>
      throw _privateConstructorUsedError;
}
