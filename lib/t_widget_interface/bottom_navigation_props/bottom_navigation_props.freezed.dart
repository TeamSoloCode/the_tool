// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bottom_navigation_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BottomNavigationProps _$BottomNavigationPropsFromJson(
    Map<String, dynamic> json) {
  return _BottomNavigationProps.fromJson(json);
}

/// @nodoc
mixin _$BottomNavigationProps {
  String? get selectedItemColor => throw _privateConstructorUsedError;
  String? get navType => throw _privateConstructorUsedError;
  List<BottomNavigationItemProps>? get items =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BottomNavigationPropsCopyWith<BottomNavigationProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationPropsCopyWith<$Res> {
  factory $BottomNavigationPropsCopyWith(BottomNavigationProps value,
          $Res Function(BottomNavigationProps) then) =
      _$BottomNavigationPropsCopyWithImpl<$Res>;
  $Res call(
      {String? selectedItemColor,
      String? navType,
      List<BottomNavigationItemProps>? items});
}

/// @nodoc
class _$BottomNavigationPropsCopyWithImpl<$Res>
    implements $BottomNavigationPropsCopyWith<$Res> {
  _$BottomNavigationPropsCopyWithImpl(this._value, this._then);

  final BottomNavigationProps _value;
  // ignore: unused_field
  final $Res Function(BottomNavigationProps) _then;

  @override
  $Res call({
    Object? selectedItemColor = freezed,
    Object? navType = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      selectedItemColor: selectedItemColor == freezed
          ? _value.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      navType: navType == freezed
          ? _value.navType
          : navType // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BottomNavigationItemProps>?,
    ));
  }
}

/// @nodoc
abstract class _$$_BottomNavigationPropsCopyWith<$Res>
    implements $BottomNavigationPropsCopyWith<$Res> {
  factory _$$_BottomNavigationPropsCopyWith(_$_BottomNavigationProps value,
          $Res Function(_$_BottomNavigationProps) then) =
      __$$_BottomNavigationPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? selectedItemColor,
      String? navType,
      List<BottomNavigationItemProps>? items});
}

/// @nodoc
class __$$_BottomNavigationPropsCopyWithImpl<$Res>
    extends _$BottomNavigationPropsCopyWithImpl<$Res>
    implements _$$_BottomNavigationPropsCopyWith<$Res> {
  __$$_BottomNavigationPropsCopyWithImpl(_$_BottomNavigationProps _value,
      $Res Function(_$_BottomNavigationProps) _then)
      : super(_value, (v) => _then(v as _$_BottomNavigationProps));

  @override
  _$_BottomNavigationProps get _value =>
      super._value as _$_BottomNavigationProps;

  @override
  $Res call({
    Object? selectedItemColor = freezed,
    Object? navType = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_BottomNavigationProps(
      selectedItemColor: selectedItemColor == freezed
          ? _value.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      navType: navType == freezed
          ? _value.navType
          : navType // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BottomNavigationItemProps>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BottomNavigationProps implements _BottomNavigationProps {
  const _$_BottomNavigationProps(
      {this.selectedItemColor,
      this.navType,
      final List<BottomNavigationItemProps>? items})
      : _items = items;

  factory _$_BottomNavigationProps.fromJson(Map<String, dynamic> json) =>
      _$$_BottomNavigationPropsFromJson(json);

  @override
  final String? selectedItemColor;
  @override
  final String? navType;
  final List<BottomNavigationItemProps>? _items;
  @override
  List<BottomNavigationItemProps>? get items {
    final value = _items;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(ignore: true)
  @override
  _$$_BottomNavigationPropsCopyWith<_$_BottomNavigationProps> get copyWith =>
      __$$_BottomNavigationPropsCopyWithImpl<_$_BottomNavigationProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BottomNavigationPropsToJson(this);
  }
}

abstract class _BottomNavigationProps implements BottomNavigationProps {
  const factory _BottomNavigationProps(
      {final String? selectedItemColor,
      final String? navType,
      final List<BottomNavigationItemProps>? items}) = _$_BottomNavigationProps;

  factory _BottomNavigationProps.fromJson(Map<String, dynamic> json) =
      _$_BottomNavigationProps.fromJson;

  @override
  String? get selectedItemColor;
  @override
  String? get navType;
  @override
  List<BottomNavigationItemProps>? get items;
  @override
  @JsonKey(ignore: true)
  _$$_BottomNavigationPropsCopyWith<_$_BottomNavigationProps> get copyWith =>
      throw _privateConstructorUsedError;
}
