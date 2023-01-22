// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'drawer_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

T_DrawerProps _$T_DrawerPropsFromJson(Map<String, dynamic> json) {
  return _T_DrawerProps.fromJson(json);
}

/// @nodoc
mixin _$T_DrawerProps {
  LayoutProps? get child => throw _privateConstructorUsedError;
  String? get backgroundColor => throw _privateConstructorUsedError;
  dynamic get width => throw _privateConstructorUsedError;
  double? get elevation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $T_DrawerPropsCopyWith<T_DrawerProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $T_DrawerPropsCopyWith<$Res> {
  factory $T_DrawerPropsCopyWith(
          T_DrawerProps value, $Res Function(T_DrawerProps) then) =
      _$T_DrawerPropsCopyWithImpl<$Res>;
  $Res call(
      {LayoutProps? child,
      String? backgroundColor,
      dynamic width,
      double? elevation});

  $LayoutPropsCopyWith<$Res>? get child;
}

/// @nodoc
class _$T_DrawerPropsCopyWithImpl<$Res>
    implements $T_DrawerPropsCopyWith<$Res> {
  _$T_DrawerPropsCopyWithImpl(this._value, this._then);

  final T_DrawerProps _value;
  // ignore: unused_field
  final $Res Function(T_DrawerProps) _then;

  @override
  $Res call({
    Object? child = freezed,
    Object? backgroundColor = freezed,
    Object? width = freezed,
    Object? elevation = freezed,
  }) {
    return _then(_value.copyWith(
      child: child == freezed
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as dynamic,
      elevation: elevation == freezed
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  @override
  $LayoutPropsCopyWith<$Res>? get child {
    if (_value.child == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.child!, (value) {
      return _then(_value.copyWith(child: value));
    });
  }
}

/// @nodoc
abstract class _$$_T_DrawerPropsCopyWith<$Res>
    implements $T_DrawerPropsCopyWith<$Res> {
  factory _$$_T_DrawerPropsCopyWith(
          _$_T_DrawerProps value, $Res Function(_$_T_DrawerProps) then) =
      __$$_T_DrawerPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {LayoutProps? child,
      String? backgroundColor,
      dynamic width,
      double? elevation});

  @override
  $LayoutPropsCopyWith<$Res>? get child;
}

/// @nodoc
class __$$_T_DrawerPropsCopyWithImpl<$Res>
    extends _$T_DrawerPropsCopyWithImpl<$Res>
    implements _$$_T_DrawerPropsCopyWith<$Res> {
  __$$_T_DrawerPropsCopyWithImpl(
      _$_T_DrawerProps _value, $Res Function(_$_T_DrawerProps) _then)
      : super(_value, (v) => _then(v as _$_T_DrawerProps));

  @override
  _$_T_DrawerProps get _value => super._value as _$_T_DrawerProps;

  @override
  $Res call({
    Object? child = freezed,
    Object? backgroundColor = freezed,
    Object? width = freezed,
    Object? elevation = freezed,
  }) {
    return _then(_$_T_DrawerProps(
      child: child == freezed
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as dynamic,
      elevation: elevation == freezed
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_T_DrawerProps implements _T_DrawerProps {
  const _$_T_DrawerProps(
      {this.child, this.backgroundColor, this.width, this.elevation});

  factory _$_T_DrawerProps.fromJson(Map<String, dynamic> json) =>
      _$$_T_DrawerPropsFromJson(json);

  @override
  final LayoutProps? child;
  @override
  final String? backgroundColor;
  @override
  final dynamic width;
  @override
  final double? elevation;

  @JsonKey(ignore: true)
  @override
  _$$_T_DrawerPropsCopyWith<_$_T_DrawerProps> get copyWith =>
      __$$_T_DrawerPropsCopyWithImpl<_$_T_DrawerProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_T_DrawerPropsToJson(
      this,
    );
  }
}

abstract class _T_DrawerProps implements T_DrawerProps {
  const factory _T_DrawerProps(
      {final LayoutProps? child,
      final String? backgroundColor,
      final dynamic width,
      final double? elevation}) = _$_T_DrawerProps;

  factory _T_DrawerProps.fromJson(Map<String, dynamic> json) =
      _$_T_DrawerProps.fromJson;

  @override
  LayoutProps? get child;
  @override
  String? get backgroundColor;
  @override
  dynamic get width;
  @override
  double? get elevation;
  @override
  @JsonKey(ignore: true)
  _$$_T_DrawerPropsCopyWith<_$_T_DrawerProps> get copyWith =>
      throw _privateConstructorUsedError;
}
