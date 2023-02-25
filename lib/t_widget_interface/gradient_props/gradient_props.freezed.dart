// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gradient_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

T_GradientProps _$T_GradientPropsFromJson(Map<String, dynamic> json) {
  return _T_GradientProps.fromJson(json);
}

/// @nodoc
mixin _$T_GradientProps {
  String? get type => throw _privateConstructorUsedError;
  List<dynamic>? get colors => throw _privateConstructorUsedError;
  dynamic get end => throw _privateConstructorUsedError;
  dynamic get begin => throw _privateConstructorUsedError;
  dynamic get stops => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $T_GradientPropsCopyWith<T_GradientProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $T_GradientPropsCopyWith<$Res> {
  factory $T_GradientPropsCopyWith(
          T_GradientProps value, $Res Function(T_GradientProps) then) =
      _$T_GradientPropsCopyWithImpl<$Res, T_GradientProps>;
  @useResult
  $Res call(
      {String? type,
      List<dynamic>? colors,
      dynamic end,
      dynamic begin,
      dynamic stops});
}

/// @nodoc
class _$T_GradientPropsCopyWithImpl<$Res, $Val extends T_GradientProps>
    implements $T_GradientPropsCopyWith<$Res> {
  _$T_GradientPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? colors = freezed,
    Object? end = freezed,
    Object? begin = freezed,
    Object? stops = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as dynamic,
      begin: freezed == begin
          ? _value.begin
          : begin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      stops: freezed == stops
          ? _value.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_T_GradientPropsCopyWith<$Res>
    implements $T_GradientPropsCopyWith<$Res> {
  factory _$$_T_GradientPropsCopyWith(
          _$_T_GradientProps value, $Res Function(_$_T_GradientProps) then) =
      __$$_T_GradientPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      List<dynamic>? colors,
      dynamic end,
      dynamic begin,
      dynamic stops});
}

/// @nodoc
class __$$_T_GradientPropsCopyWithImpl<$Res>
    extends _$T_GradientPropsCopyWithImpl<$Res, _$_T_GradientProps>
    implements _$$_T_GradientPropsCopyWith<$Res> {
  __$$_T_GradientPropsCopyWithImpl(
      _$_T_GradientProps _value, $Res Function(_$_T_GradientProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? colors = freezed,
    Object? end = freezed,
    Object? begin = freezed,
    Object? stops = freezed,
  }) {
    return _then(_$_T_GradientProps(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as dynamic,
      begin: freezed == begin
          ? _value.begin
          : begin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      stops: freezed == stops
          ? _value.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_T_GradientProps implements _T_GradientProps {
  const _$_T_GradientProps(
      {this.type,
      final List<dynamic>? colors,
      this.end,
      this.begin,
      this.stops})
      : _colors = colors;

  factory _$_T_GradientProps.fromJson(Map<String, dynamic> json) =>
      _$$_T_GradientPropsFromJson(json);

  @override
  final String? type;
  final List<dynamic>? _colors;
  @override
  List<dynamic>? get colors {
    final value = _colors;
    if (value == null) return null;
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic end;
  @override
  final dynamic begin;
  @override
  final dynamic stops;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_T_GradientPropsCopyWith<_$_T_GradientProps> get copyWith =>
      __$$_T_GradientPropsCopyWithImpl<_$_T_GradientProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_T_GradientPropsToJson(
      this,
    );
  }
}

abstract class _T_GradientProps implements T_GradientProps {
  const factory _T_GradientProps(
      {final String? type,
      final List<dynamic>? colors,
      final dynamic end,
      final dynamic begin,
      final dynamic stops}) = _$_T_GradientProps;

  factory _T_GradientProps.fromJson(Map<String, dynamic> json) =
      _$_T_GradientProps.fromJson;

  @override
  String? get type;
  @override
  List<dynamic>? get colors;
  @override
  dynamic get end;
  @override
  dynamic get begin;
  @override
  dynamic get stops;
  @override
  @JsonKey(ignore: true)
  _$$_T_GradientPropsCopyWith<_$_T_GradientProps> get copyWith =>
      throw _privateConstructorUsedError;
}
