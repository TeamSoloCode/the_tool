// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'border_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BorderProps _$BorderPropsFromJson(Map<String, dynamic> json) {
  return _BorderProps.fromJson(json);
}

/// @nodoc
mixin _$BorderProps {
  int? get width => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BorderPropsCopyWith<BorderProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BorderPropsCopyWith<$Res> {
  factory $BorderPropsCopyWith(
          BorderProps value, $Res Function(BorderProps) then) =
      _$BorderPropsCopyWithImpl<$Res>;
  $Res call({int? width, String? color, String? style});
}

/// @nodoc
class _$BorderPropsCopyWithImpl<$Res> implements $BorderPropsCopyWith<$Res> {
  _$BorderPropsCopyWithImpl(this._value, this._then);

  final BorderProps _value;
  // ignore: unused_field
  final $Res Function(BorderProps) _then;

  @override
  $Res call({
    Object? width = freezed,
    Object? color = freezed,
    Object? style = freezed,
  }) {
    return _then(_value.copyWith(
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_BorderPropsCopyWith<$Res>
    implements $BorderPropsCopyWith<$Res> {
  factory _$$_BorderPropsCopyWith(
          _$_BorderProps value, $Res Function(_$_BorderProps) then) =
      __$$_BorderPropsCopyWithImpl<$Res>;
  @override
  $Res call({int? width, String? color, String? style});
}

/// @nodoc
class __$$_BorderPropsCopyWithImpl<$Res> extends _$BorderPropsCopyWithImpl<$Res>
    implements _$$_BorderPropsCopyWith<$Res> {
  __$$_BorderPropsCopyWithImpl(
      _$_BorderProps _value, $Res Function(_$_BorderProps) _then)
      : super(_value, (v) => _then(v as _$_BorderProps));

  @override
  _$_BorderProps get _value => super._value as _$_BorderProps;

  @override
  $Res call({
    Object? width = freezed,
    Object? color = freezed,
    Object? style = freezed,
  }) {
    return _then(_$_BorderProps(
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BorderProps with DiagnosticableTreeMixin implements _BorderProps {
  _$_BorderProps({this.width, this.color, this.style});

  factory _$_BorderProps.fromJson(Map<String, dynamic> json) =>
      _$$_BorderPropsFromJson(json);

  @override
  final int? width;
  @override
  final String? color;
  @override
  final String? style;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BorderProps(width: $width, color: $color, style: $style)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BorderProps'))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('style', style));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BorderProps &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.style, style));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(style));

  @JsonKey(ignore: true)
  @override
  _$$_BorderPropsCopyWith<_$_BorderProps> get copyWith =>
      __$$_BorderPropsCopyWithImpl<_$_BorderProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BorderPropsToJson(this);
  }
}

abstract class _BorderProps implements BorderProps {
  factory _BorderProps(
      {final int? width,
      final String? color,
      final String? style}) = _$_BorderProps;

  factory _BorderProps.fromJson(Map<String, dynamic> json) =
      _$_BorderProps.fromJson;

  @override
  int? get width;
  @override
  String? get color;
  @override
  String? get style;
  @override
  @JsonKey(ignore: true)
  _$$_BorderPropsCopyWith<_$_BorderProps> get copyWith =>
      throw _privateConstructorUsedError;
}
