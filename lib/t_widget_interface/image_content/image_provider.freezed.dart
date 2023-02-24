// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$ImageProviderPropsCopyWithImpl<$Res, ImageProviderProps>;
  @useResult
  $Res call(
      {String? type,
      Map<String, dynamic>? headers,
      String? url,
      String? asset,
      int? scale,
      String? fit});
}

/// @nodoc
class _$ImageProviderPropsCopyWithImpl<$Res, $Val extends ImageProviderProps>
    implements $ImageProviderPropsCopyWith<$Res> {
  _$ImageProviderPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as int?,
      fit: freezed == fit
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageProviderPropsCopyWith<$Res>
    implements $ImageProviderPropsCopyWith<$Res> {
  factory _$$_ImageProviderPropsCopyWith(_$_ImageProviderProps value,
          $Res Function(_$_ImageProviderProps) then) =
      __$$_ImageProviderPropsCopyWithImpl<$Res>;
  @override
  @useResult
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
    extends _$ImageProviderPropsCopyWithImpl<$Res, _$_ImageProviderProps>
    implements _$$_ImageProviderPropsCopyWith<$Res> {
  __$$_ImageProviderPropsCopyWithImpl(
      _$_ImageProviderProps _value, $Res Function(_$_ImageProviderProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as int?,
      fit: freezed == fit
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageProviderProps implements _ImageProviderProps {
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
    if (_headers is EqualUnmodifiableMapView) return _headers;
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageProviderPropsCopyWith<_$_ImageProviderProps> get copyWith =>
      __$$_ImageProviderPropsCopyWithImpl<_$_ImageProviderProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageProviderPropsToJson(
      this,
    );
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
