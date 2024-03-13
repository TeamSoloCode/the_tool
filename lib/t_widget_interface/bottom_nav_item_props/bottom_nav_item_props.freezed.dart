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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BottomNavigationItemProps _$BottomNavigationItemPropsFromJson(
    Map<String, dynamic> json) {
  return _BottomNavigationItemProps.fromJson(json);
}

/// @nodoc
mixin _$BottomNavigationItemProps {
  String? get label => throw _privateConstructorUsedError;
  LayoutProps? get icon => throw _privateConstructorUsedError;
  LayoutProps? get activeIcon => throw _privateConstructorUsedError;
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
      {String? label,
      LayoutProps? icon,
      LayoutProps? activeIcon,
      String? path,
      String? backgroundColor});

  $LayoutPropsCopyWith<$Res>? get icon;
  $LayoutPropsCopyWith<$Res>? get activeIcon;
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
    Object? activeIcon = freezed,
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
              as LayoutProps?,
      activeIcon: freezed == activeIcon
          ? _value.activeIcon
          : activeIcon // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
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

  @override
  @pragma('vm:prefer-inline')
  $LayoutPropsCopyWith<$Res>? get icon {
    if (_value.icon == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.icon!, (value) {
      return _then(_value.copyWith(icon: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LayoutPropsCopyWith<$Res>? get activeIcon {
    if (_value.activeIcon == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.activeIcon!, (value) {
      return _then(_value.copyWith(activeIcon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BottomNavigationItemPropsImplCopyWith<$Res>
    implements $BottomNavigationItemPropsCopyWith<$Res> {
  factory _$$BottomNavigationItemPropsImplCopyWith(
          _$BottomNavigationItemPropsImpl value,
          $Res Function(_$BottomNavigationItemPropsImpl) then) =
      __$$BottomNavigationItemPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? label,
      LayoutProps? icon,
      LayoutProps? activeIcon,
      String? path,
      String? backgroundColor});

  @override
  $LayoutPropsCopyWith<$Res>? get icon;
  @override
  $LayoutPropsCopyWith<$Res>? get activeIcon;
}

/// @nodoc
class __$$BottomNavigationItemPropsImplCopyWithImpl<$Res>
    extends _$BottomNavigationItemPropsCopyWithImpl<$Res,
        _$BottomNavigationItemPropsImpl>
    implements _$$BottomNavigationItemPropsImplCopyWith<$Res> {
  __$$BottomNavigationItemPropsImplCopyWithImpl(
      _$BottomNavigationItemPropsImpl _value,
      $Res Function(_$BottomNavigationItemPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? icon = freezed,
    Object? activeIcon = freezed,
    Object? path = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_$BottomNavigationItemPropsImpl(
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
      activeIcon: freezed == activeIcon
          ? _value.activeIcon
          : activeIcon // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
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
class _$BottomNavigationItemPropsImpl implements _BottomNavigationItemProps {
  const _$BottomNavigationItemPropsImpl(
      {this.label,
      this.icon,
      this.activeIcon,
      this.path,
      this.backgroundColor});

  factory _$BottomNavigationItemPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BottomNavigationItemPropsImplFromJson(json);

  @override
  final String? label;
  @override
  final LayoutProps? icon;
  @override
  final LayoutProps? activeIcon;
  @override
  final String? path;
  @override
  final String? backgroundColor;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BottomNavigationItemPropsImplCopyWith<_$BottomNavigationItemPropsImpl>
      get copyWith => __$$BottomNavigationItemPropsImplCopyWithImpl<
          _$BottomNavigationItemPropsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BottomNavigationItemPropsImplToJson(
      this,
    );
  }
}

abstract class _BottomNavigationItemProps implements BottomNavigationItemProps {
  const factory _BottomNavigationItemProps(
      {final String? label,
      final LayoutProps? icon,
      final LayoutProps? activeIcon,
      final String? path,
      final String? backgroundColor}) = _$BottomNavigationItemPropsImpl;

  factory _BottomNavigationItemProps.fromJson(Map<String, dynamic> json) =
      _$BottomNavigationItemPropsImpl.fromJson;

  @override
  String? get label;
  @override
  LayoutProps? get icon;
  @override
  LayoutProps? get activeIcon;
  @override
  String? get path;
  @override
  String? get backgroundColor;
  @override
  @JsonKey(ignore: true)
  _$$BottomNavigationItemPropsImplCopyWith<_$BottomNavigationItemPropsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
