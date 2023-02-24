// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'box_shadow_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BoxShadowProps _$BoxShadowPropsFromJson(Map<String, dynamic> json) {
  return _BoxShadowProps.fromJson(json);
}

/// @nodoc
mixin _$BoxShadowProps {
  String? get color => throw _privateConstructorUsedError;
  int? get blurRadius => throw _privateConstructorUsedError;
  String? get blurStyle => throw _privateConstructorUsedError;
  String? get colorBoxShadow => throw _privateConstructorUsedError;
  Map<String, double>? get offset => throw _privateConstructorUsedError;
  int? get spreadRadius => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoxShadowPropsCopyWith<BoxShadowProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoxShadowPropsCopyWith<$Res> {
  factory $BoxShadowPropsCopyWith(
          BoxShadowProps value, $Res Function(BoxShadowProps) then) =
      _$BoxShadowPropsCopyWithImpl<$Res, BoxShadowProps>;
  @useResult
  $Res call(
      {String? color,
      int? blurRadius,
      String? blurStyle,
      String? colorBoxShadow,
      Map<String, double>? offset,
      int? spreadRadius});
}

/// @nodoc
class _$BoxShadowPropsCopyWithImpl<$Res, $Val extends BoxShadowProps>
    implements $BoxShadowPropsCopyWith<$Res> {
  _$BoxShadowPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? blurRadius = freezed,
    Object? blurStyle = freezed,
    Object? colorBoxShadow = freezed,
    Object? offset = freezed,
    Object? spreadRadius = freezed,
  }) {
    return _then(_value.copyWith(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      blurRadius: freezed == blurRadius
          ? _value.blurRadius
          : blurRadius // ignore: cast_nullable_to_non_nullable
              as int?,
      blurStyle: freezed == blurStyle
          ? _value.blurStyle
          : blurStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      colorBoxShadow: freezed == colorBoxShadow
          ? _value.colorBoxShadow
          : colorBoxShadow // ignore: cast_nullable_to_non_nullable
              as String?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      spreadRadius: freezed == spreadRadius
          ? _value.spreadRadius
          : spreadRadius // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BoxShadowPropsCopyWith<$Res>
    implements $BoxShadowPropsCopyWith<$Res> {
  factory _$$_BoxShadowPropsCopyWith(
          _$_BoxShadowProps value, $Res Function(_$_BoxShadowProps) then) =
      __$$_BoxShadowPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? color,
      int? blurRadius,
      String? blurStyle,
      String? colorBoxShadow,
      Map<String, double>? offset,
      int? spreadRadius});
}

/// @nodoc
class __$$_BoxShadowPropsCopyWithImpl<$Res>
    extends _$BoxShadowPropsCopyWithImpl<$Res, _$_BoxShadowProps>
    implements _$$_BoxShadowPropsCopyWith<$Res> {
  __$$_BoxShadowPropsCopyWithImpl(
      _$_BoxShadowProps _value, $Res Function(_$_BoxShadowProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? blurRadius = freezed,
    Object? blurStyle = freezed,
    Object? colorBoxShadow = freezed,
    Object? offset = freezed,
    Object? spreadRadius = freezed,
  }) {
    return _then(_$_BoxShadowProps(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      blurRadius: freezed == blurRadius
          ? _value.blurRadius
          : blurRadius // ignore: cast_nullable_to_non_nullable
              as int?,
      blurStyle: freezed == blurStyle
          ? _value.blurStyle
          : blurStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      colorBoxShadow: freezed == colorBoxShadow
          ? _value.colorBoxShadow
          : colorBoxShadow // ignore: cast_nullable_to_non_nullable
              as String?,
      offset: freezed == offset
          ? _value._offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      spreadRadius: freezed == spreadRadius
          ? _value.spreadRadius
          : spreadRadius // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BoxShadowProps implements _BoxShadowProps {
  _$_BoxShadowProps(
      {this.color,
      this.blurRadius,
      this.blurStyle,
      this.colorBoxShadow,
      final Map<String, double>? offset,
      this.spreadRadius})
      : _offset = offset;

  factory _$_BoxShadowProps.fromJson(Map<String, dynamic> json) =>
      _$$_BoxShadowPropsFromJson(json);

  @override
  final String? color;
  @override
  final int? blurRadius;
  @override
  final String? blurStyle;
  @override
  final String? colorBoxShadow;
  final Map<String, double>? _offset;
  @override
  Map<String, double>? get offset {
    final value = _offset;
    if (value == null) return null;
    if (_offset is EqualUnmodifiableMapView) return _offset;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? spreadRadius;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BoxShadowPropsCopyWith<_$_BoxShadowProps> get copyWith =>
      __$$_BoxShadowPropsCopyWithImpl<_$_BoxShadowProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BoxShadowPropsToJson(
      this,
    );
  }
}

abstract class _BoxShadowProps implements BoxShadowProps {
  factory _BoxShadowProps(
      {final String? color,
      final int? blurRadius,
      final String? blurStyle,
      final String? colorBoxShadow,
      final Map<String, double>? offset,
      final int? spreadRadius}) = _$_BoxShadowProps;

  factory _BoxShadowProps.fromJson(Map<String, dynamic> json) =
      _$_BoxShadowProps.fromJson;

  @override
  String? get color;
  @override
  int? get blurRadius;
  @override
  String? get blurStyle;
  @override
  String? get colorBoxShadow;
  @override
  Map<String, double>? get offset;
  @override
  int? get spreadRadius;
  @override
  @JsonKey(ignore: true)
  _$$_BoxShadowPropsCopyWith<_$_BoxShadowProps> get copyWith =>
      throw _privateConstructorUsedError;
}
