// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_navigation_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BottomNavigationProps _$BottomNavigationPropsFromJson(
    Map<String, dynamic> json) {
  return _BottomNavigationProps.fromJson(json);
}

/// @nodoc
mixin _$BottomNavigationProps {
  String? get selectedItemColor => throw _privateConstructorUsedError;
  String? get navType => throw _privateConstructorUsedError;
  String? get backgroundColor => throw _privateConstructorUsedError;
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
      _$BottomNavigationPropsCopyWithImpl<$Res, BottomNavigationProps>;
  @useResult
  $Res call(
      {String? selectedItemColor,
      String? navType,
      String? backgroundColor,
      List<BottomNavigationItemProps>? items});
}

/// @nodoc
class _$BottomNavigationPropsCopyWithImpl<$Res,
        $Val extends BottomNavigationProps>
    implements $BottomNavigationPropsCopyWith<$Res> {
  _$BottomNavigationPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItemColor = freezed,
    Object? navType = freezed,
    Object? backgroundColor = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      selectedItemColor: freezed == selectedItemColor
          ? _value.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      navType: freezed == navType
          ? _value.navType
          : navType // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BottomNavigationItemProps>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BottomNavigationPropsImplCopyWith<$Res>
    implements $BottomNavigationPropsCopyWith<$Res> {
  factory _$$BottomNavigationPropsImplCopyWith(
          _$BottomNavigationPropsImpl value,
          $Res Function(_$BottomNavigationPropsImpl) then) =
      __$$BottomNavigationPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? selectedItemColor,
      String? navType,
      String? backgroundColor,
      List<BottomNavigationItemProps>? items});
}

/// @nodoc
class __$$BottomNavigationPropsImplCopyWithImpl<$Res>
    extends _$BottomNavigationPropsCopyWithImpl<$Res,
        _$BottomNavigationPropsImpl>
    implements _$$BottomNavigationPropsImplCopyWith<$Res> {
  __$$BottomNavigationPropsImplCopyWithImpl(_$BottomNavigationPropsImpl _value,
      $Res Function(_$BottomNavigationPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItemColor = freezed,
    Object? navType = freezed,
    Object? backgroundColor = freezed,
    Object? items = freezed,
  }) {
    return _then(_$BottomNavigationPropsImpl(
      selectedItemColor: freezed == selectedItemColor
          ? _value.selectedItemColor
          : selectedItemColor // ignore: cast_nullable_to_non_nullable
              as String?,
      navType: freezed == navType
          ? _value.navType
          : navType // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BottomNavigationItemProps>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BottomNavigationPropsImpl implements _BottomNavigationProps {
  const _$BottomNavigationPropsImpl(
      {this.selectedItemColor,
      this.navType,
      this.backgroundColor,
      final List<BottomNavigationItemProps>? items})
      : _items = items;

  factory _$BottomNavigationPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BottomNavigationPropsImplFromJson(json);

  @override
  final String? selectedItemColor;
  @override
  final String? navType;
  @override
  final String? backgroundColor;
  final List<BottomNavigationItemProps>? _items;
  @override
  List<BottomNavigationItemProps>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BottomNavigationPropsImplCopyWith<_$BottomNavigationPropsImpl>
      get copyWith => __$$BottomNavigationPropsImplCopyWithImpl<
          _$BottomNavigationPropsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BottomNavigationPropsImplToJson(
      this,
    );
  }
}

abstract class _BottomNavigationProps implements BottomNavigationProps {
  const factory _BottomNavigationProps(
          {final String? selectedItemColor,
          final String? navType,
          final String? backgroundColor,
          final List<BottomNavigationItemProps>? items}) =
      _$BottomNavigationPropsImpl;

  factory _BottomNavigationProps.fromJson(Map<String, dynamic> json) =
      _$BottomNavigationPropsImpl.fromJson;

  @override
  String? get selectedItemColor;
  @override
  String? get navType;
  @override
  String? get backgroundColor;
  @override
  List<BottomNavigationItemProps>? get items;
  @override
  @JsonKey(ignore: true)
  _$$BottomNavigationPropsImplCopyWith<_$BottomNavigationPropsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
