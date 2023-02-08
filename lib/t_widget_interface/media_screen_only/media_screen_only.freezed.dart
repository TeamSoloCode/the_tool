// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'media_screen_only.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

T_MediaScreenOnlyProps _$T_MediaScreenOnlyPropsFromJson(
    Map<String, dynamic> json) {
  return _T_MediaScreenOnlyProps.fromJson(json);
}

/// @nodoc
mixin _$T_MediaScreenOnlyProps {
  num? get maxWidth => throw _privateConstructorUsedError;
  num? get minWidth => throw _privateConstructorUsedError;
  num? get maxHeight => throw _privateConstructorUsedError;
  num? get minHeight => throw _privateConstructorUsedError;
  String? get orientation => throw _privateConstructorUsedError;
  LayoutProps? get style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $T_MediaScreenOnlyPropsCopyWith<T_MediaScreenOnlyProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $T_MediaScreenOnlyPropsCopyWith<$Res> {
  factory $T_MediaScreenOnlyPropsCopyWith(T_MediaScreenOnlyProps value,
          $Res Function(T_MediaScreenOnlyProps) then) =
      _$T_MediaScreenOnlyPropsCopyWithImpl<$Res>;
  $Res call(
      {num? maxWidth,
      num? minWidth,
      num? maxHeight,
      num? minHeight,
      String? orientation,
      LayoutProps? style});

  $LayoutPropsCopyWith<$Res>? get style;
}

/// @nodoc
class _$T_MediaScreenOnlyPropsCopyWithImpl<$Res>
    implements $T_MediaScreenOnlyPropsCopyWith<$Res> {
  _$T_MediaScreenOnlyPropsCopyWithImpl(this._value, this._then);

  final T_MediaScreenOnlyProps _value;
  // ignore: unused_field
  final $Res Function(T_MediaScreenOnlyProps) _then;

  @override
  $Res call({
    Object? maxWidth = freezed,
    Object? minWidth = freezed,
    Object? maxHeight = freezed,
    Object? minHeight = freezed,
    Object? orientation = freezed,
    Object? style = freezed,
  }) {
    return _then(_value.copyWith(
      maxWidth: maxWidth == freezed
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      minWidth: minWidth == freezed
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      maxHeight: maxHeight == freezed
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      minHeight: minHeight == freezed
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String?,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
    ));
  }

  @override
  $LayoutPropsCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value));
    });
  }
}

/// @nodoc
abstract class _$$_T_MediaScreenOnlyPropsCopyWith<$Res>
    implements $T_MediaScreenOnlyPropsCopyWith<$Res> {
  factory _$$_T_MediaScreenOnlyPropsCopyWith(_$_T_MediaScreenOnlyProps value,
          $Res Function(_$_T_MediaScreenOnlyProps) then) =
      __$$_T_MediaScreenOnlyPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {num? maxWidth,
      num? minWidth,
      num? maxHeight,
      num? minHeight,
      String? orientation,
      LayoutProps? style});

  @override
  $LayoutPropsCopyWith<$Res>? get style;
}

/// @nodoc
class __$$_T_MediaScreenOnlyPropsCopyWithImpl<$Res>
    extends _$T_MediaScreenOnlyPropsCopyWithImpl<$Res>
    implements _$$_T_MediaScreenOnlyPropsCopyWith<$Res> {
  __$$_T_MediaScreenOnlyPropsCopyWithImpl(_$_T_MediaScreenOnlyProps _value,
      $Res Function(_$_T_MediaScreenOnlyProps) _then)
      : super(_value, (v) => _then(v as _$_T_MediaScreenOnlyProps));

  @override
  _$_T_MediaScreenOnlyProps get _value =>
      super._value as _$_T_MediaScreenOnlyProps;

  @override
  $Res call({
    Object? maxWidth = freezed,
    Object? minWidth = freezed,
    Object? maxHeight = freezed,
    Object? minHeight = freezed,
    Object? orientation = freezed,
    Object? style = freezed,
  }) {
    return _then(_$_T_MediaScreenOnlyProps(
      maxWidth: maxWidth == freezed
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      minWidth: minWidth == freezed
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      maxHeight: maxHeight == freezed
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      minHeight: minHeight == freezed
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String?,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_T_MediaScreenOnlyProps implements _T_MediaScreenOnlyProps {
  const _$_T_MediaScreenOnlyProps(
      {this.maxWidth,
      this.minWidth,
      this.maxHeight,
      this.minHeight,
      this.orientation,
      this.style});

  factory _$_T_MediaScreenOnlyProps.fromJson(Map<String, dynamic> json) =>
      _$$_T_MediaScreenOnlyPropsFromJson(json);

  @override
  final num? maxWidth;
  @override
  final num? minWidth;
  @override
  final num? maxHeight;
  @override
  final num? minHeight;
  @override
  final String? orientation;
  @override
  final LayoutProps? style;

  @JsonKey(ignore: true)
  @override
  _$$_T_MediaScreenOnlyPropsCopyWith<_$_T_MediaScreenOnlyProps> get copyWith =>
      __$$_T_MediaScreenOnlyPropsCopyWithImpl<_$_T_MediaScreenOnlyProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_T_MediaScreenOnlyPropsToJson(
      this,
    );
  }
}

abstract class _T_MediaScreenOnlyProps implements T_MediaScreenOnlyProps {
  const factory _T_MediaScreenOnlyProps(
      {final num? maxWidth,
      final num? minWidth,
      final num? maxHeight,
      final num? minHeight,
      final String? orientation,
      final LayoutProps? style}) = _$_T_MediaScreenOnlyProps;

  factory _T_MediaScreenOnlyProps.fromJson(Map<String, dynamic> json) =
      _$_T_MediaScreenOnlyProps.fromJson;

  @override
  num? get maxWidth;
  @override
  num? get minWidth;
  @override
  num? get maxHeight;
  @override
  num? get minHeight;
  @override
  String? get orientation;
  @override
  LayoutProps? get style;
  @override
  @JsonKey(ignore: true)
  _$$_T_MediaScreenOnlyPropsCopyWith<_$_T_MediaScreenOnlyProps> get copyWith =>
      throw _privateConstructorUsedError;
}
