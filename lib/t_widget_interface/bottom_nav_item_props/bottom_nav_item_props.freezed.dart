// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_nav_item_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BottomNavigationItemProps _$BottomNavigationItemPropsFromJson(
    Map<String, dynamic> json) {
  return _BottomNavigationItemProps.fromJson(json);
}

/// @nodoc
mixin _$BottomNavigationItemProps {
  String? get label => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get backgroundColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BottomNavigationItemPropsCopyWith<BottomNavigationItemProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationItemPropsCopyWith<$Res> {
  factory $BottomNavigationItemPropsCopyWith(BottomNavigationItemProps value,
          $Res Function(BottomNavigationItemProps) then) =
      _$BottomNavigationItemPropsCopyWithImpl<$Res, BottomNavigationItemProps>;
  @useResult
  $Res call(
      {String? label, String? icon, String? path, String? backgroundColor});
}

/// @nodoc
class _$BottomNavigationItemPropsCopyWithImpl<$Res,
        $Val extends BottomNavigationItemProps>
    implements $BottomNavigationItemPropsCopyWith<$Res> {
  _$BottomNavigationItemPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? icon = freezed,
    Object? path = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_value.copyWith(
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BottomNavigationItemPropsCopyWith<$Res>
    implements $BottomNavigationItemPropsCopyWith<$Res> {
  factory _$$_BottomNavigationItemPropsCopyWith(
          _$_BottomNavigationItemProps value,
          $Res Function(_$_BottomNavigationItemProps) then) =
      __$$_BottomNavigationItemPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? label, String? icon, String? path, String? backgroundColor});
}

/// @nodoc
class __$$_BottomNavigationItemPropsCopyWithImpl<$Res>
    extends _$BottomNavigationItemPropsCopyWithImpl<$Res,
        _$_BottomNavigationItemProps>
    implements _$$_BottomNavigationItemPropsCopyWith<$Res> {
  __$$_BottomNavigationItemPropsCopyWithImpl(
      _$_BottomNavigationItemProps _value,
      $Res Function(_$_BottomNavigationItemProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? icon = freezed,
    Object? path = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_$_BottomNavigationItemProps(
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BottomNavigationItemProps implements _BottomNavigationItemProps {
  const _$_BottomNavigationItemProps(
      {this.label, this.icon, this.path, this.backgroundColor});

  factory _$_BottomNavigationItemProps.fromJson(Map<String, dynamic> json) =>
      _$$_BottomNavigationItemPropsFromJson(json);

  @override
  final String? label;
  @override
  final String? icon;
  @override
  final String? path;
  @override
  final String? backgroundColor;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BottomNavigationItemPropsCopyWith<_$_BottomNavigationItemProps>
      get copyWith => __$$_BottomNavigationItemPropsCopyWithImpl<
          _$_BottomNavigationItemProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BottomNavigationItemPropsToJson(
      this,
    );
  }
}

abstract class _BottomNavigationItemProps implements BottomNavigationItemProps {
  const factory _BottomNavigationItemProps(
      {final String? label,
      final String? icon,
      final String? path,
      final String? backgroundColor}) = _$_BottomNavigationItemProps;

  factory _BottomNavigationItemProps.fromJson(Map<String, dynamic> json) =
      _$_BottomNavigationItemProps.fromJson;

  @override
  String? get label;
  @override
  String? get icon;
  @override
  String? get path;
  @override
  String? get backgroundColor;
  @override
  @JsonKey(ignore: true)
  _$$_BottomNavigationItemPropsCopyWith<_$_BottomNavigationItemProps>
      get copyWith => throw _privateConstructorUsedError;
}
