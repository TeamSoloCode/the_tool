// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  String? get type => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get style => throw _privateConstructorUsedError;
  Map<String, dynamic>? get left => throw _privateConstructorUsedError;
  Map<String, dynamic>? get right => throw _privateConstructorUsedError;
  Map<String, dynamic>? get bottom => throw _privateConstructorUsedError;
  Map<String, dynamic>? get top => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BorderPropsCopyWith<BorderProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BorderPropsCopyWith<$Res> {
  factory $BorderPropsCopyWith(
          BorderProps value, $Res Function(BorderProps) then) =
      _$BorderPropsCopyWithImpl<$Res, BorderProps>;
  @useResult
  $Res call(
      {String? type,
      int? width,
      String? color,
      String? style,
      Map<String, dynamic>? left,
      Map<String, dynamic>? right,
      Map<String, dynamic>? bottom,
      Map<String, dynamic>? top});
}

/// @nodoc
class _$BorderPropsCopyWithImpl<$Res, $Val extends BorderProps>
    implements $BorderPropsCopyWith<$Res> {
  _$BorderPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? width = freezed,
    Object? color = freezed,
    Object? style = freezed,
    Object? left = freezed,
    Object? right = freezed,
    Object? bottom = freezed,
    Object? top = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      left: freezed == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      right: freezed == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bottom: freezed == bottom
          ? _value.bottom
          : bottom // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      top: freezed == top
          ? _value.top
          : top // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BorderPropsCopyWith<$Res>
    implements $BorderPropsCopyWith<$Res> {
  factory _$$_BorderPropsCopyWith(
          _$_BorderProps value, $Res Function(_$_BorderProps) then) =
      __$$_BorderPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      int? width,
      String? color,
      String? style,
      Map<String, dynamic>? left,
      Map<String, dynamic>? right,
      Map<String, dynamic>? bottom,
      Map<String, dynamic>? top});
}

/// @nodoc
class __$$_BorderPropsCopyWithImpl<$Res>
    extends _$BorderPropsCopyWithImpl<$Res, _$_BorderProps>
    implements _$$_BorderPropsCopyWith<$Res> {
  __$$_BorderPropsCopyWithImpl(
      _$_BorderProps _value, $Res Function(_$_BorderProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? width = freezed,
    Object? color = freezed,
    Object? style = freezed,
    Object? left = freezed,
    Object? right = freezed,
    Object? bottom = freezed,
    Object? top = freezed,
  }) {
    return _then(_$_BorderProps(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      left: freezed == left
          ? _value._left
          : left // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      right: freezed == right
          ? _value._right
          : right // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bottom: freezed == bottom
          ? _value._bottom
          : bottom // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      top: freezed == top
          ? _value._top
          : top // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BorderProps implements _BorderProps {
  _$_BorderProps(
      {this.type,
      this.width,
      this.color,
      this.style,
      final Map<String, dynamic>? left,
      final Map<String, dynamic>? right,
      final Map<String, dynamic>? bottom,
      final Map<String, dynamic>? top})
      : _left = left,
        _right = right,
        _bottom = bottom,
        _top = top;

  factory _$_BorderProps.fromJson(Map<String, dynamic> json) =>
      _$$_BorderPropsFromJson(json);

  @override
  final String? type;
  @override
  final int? width;
  @override
  final String? color;
  @override
  final String? style;
  final Map<String, dynamic>? _left;
  @override
  Map<String, dynamic>? get left {
    final value = _left;
    if (value == null) return null;
    if (_left is EqualUnmodifiableMapView) return _left;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _right;
  @override
  Map<String, dynamic>? get right {
    final value = _right;
    if (value == null) return null;
    if (_right is EqualUnmodifiableMapView) return _right;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _bottom;
  @override
  Map<String, dynamic>? get bottom {
    final value = _bottom;
    if (value == null) return null;
    if (_bottom is EqualUnmodifiableMapView) return _bottom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _top;
  @override
  Map<String, dynamic>? get top {
    final value = _top;
    if (value == null) return null;
    if (_top is EqualUnmodifiableMapView) return _top;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BorderPropsCopyWith<_$_BorderProps> get copyWith =>
      __$$_BorderPropsCopyWithImpl<_$_BorderProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BorderPropsToJson(
      this,
    );
  }
}

abstract class _BorderProps implements BorderProps {
  factory _BorderProps(
      {final String? type,
      final int? width,
      final String? color,
      final String? style,
      final Map<String, dynamic>? left,
      final Map<String, dynamic>? right,
      final Map<String, dynamic>? bottom,
      final Map<String, dynamic>? top}) = _$_BorderProps;

  factory _BorderProps.fromJson(Map<String, dynamic> json) =
      _$_BorderProps.fromJson;

  @override
  String? get type;
  @override
  int? get width;
  @override
  String? get color;
  @override
  String? get style;
  @override
  Map<String, dynamic>? get left;
  @override
  Map<String, dynamic>? get right;
  @override
  Map<String, dynamic>? get bottom;
  @override
  Map<String, dynamic>? get top;
  @override
  @JsonKey(ignore: true)
  _$$_BorderPropsCopyWith<_$_BorderProps> get copyWith =>
      throw _privateConstructorUsedError;
}
