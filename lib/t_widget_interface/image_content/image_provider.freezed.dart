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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$ImageProviderPropsImplCopyWith<$Res>
    implements $ImageProviderPropsCopyWith<$Res> {
  factory _$$ImageProviderPropsImplCopyWith(_$ImageProviderPropsImpl value,
          $Res Function(_$ImageProviderPropsImpl) then) =
      __$$ImageProviderPropsImplCopyWithImpl<$Res>;
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
class __$$ImageProviderPropsImplCopyWithImpl<$Res>
    extends _$ImageProviderPropsCopyWithImpl<$Res, _$ImageProviderPropsImpl>
    implements _$$ImageProviderPropsImplCopyWith<$Res> {
  __$$ImageProviderPropsImplCopyWithImpl(_$ImageProviderPropsImpl _value,
      $Res Function(_$ImageProviderPropsImpl) _then)
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
    return _then(_$ImageProviderPropsImpl(
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
class _$ImageProviderPropsImpl implements _ImageProviderProps {
  const _$ImageProviderPropsImpl(
      {this.type,
      final Map<String, dynamic>? headers,
      this.url,
      this.asset,
      this.scale,
      this.fit})
      : _headers = headers;

  factory _$ImageProviderPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageProviderPropsImplFromJson(json);

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
  _$$ImageProviderPropsImplCopyWith<_$ImageProviderPropsImpl> get copyWith =>
      __$$ImageProviderPropsImplCopyWithImpl<_$ImageProviderPropsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageProviderPropsImplToJson(
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
      final String? fit}) = _$ImageProviderPropsImpl;

  factory _ImageProviderProps.fromJson(Map<String, dynamic> json) =
      _$ImageProviderPropsImpl.fromJson;

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
  _$$ImageProviderPropsImplCopyWith<_$ImageProviderPropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
