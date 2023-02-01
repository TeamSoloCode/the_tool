// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'layout_builder_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

T_LayoutBuilderProps _$T_LayoutBuilderPropsFromJson(Map<String, dynamic> json) {
  return _T_LayoutBuilderProps.fromJson(json);
}

/// @nodoc
mixin _$T_LayoutBuilderProps {
  List<T_LayoutBuilderItemProps>? get layouts =>
      throw _privateConstructorUsedError;
  int? get defaultLayoutIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $T_LayoutBuilderPropsCopyWith<T_LayoutBuilderProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $T_LayoutBuilderPropsCopyWith<$Res> {
  factory $T_LayoutBuilderPropsCopyWith(T_LayoutBuilderProps value,
          $Res Function(T_LayoutBuilderProps) then) =
      _$T_LayoutBuilderPropsCopyWithImpl<$Res>;
  $Res call({List<T_LayoutBuilderItemProps>? layouts, int? defaultLayoutIndex});
}

/// @nodoc
class _$T_LayoutBuilderPropsCopyWithImpl<$Res>
    implements $T_LayoutBuilderPropsCopyWith<$Res> {
  _$T_LayoutBuilderPropsCopyWithImpl(this._value, this._then);

  final T_LayoutBuilderProps _value;
  // ignore: unused_field
  final $Res Function(T_LayoutBuilderProps) _then;

  @override
  $Res call({
    Object? layouts = freezed,
    Object? defaultLayoutIndex = freezed,
  }) {
    return _then(_value.copyWith(
      layouts: layouts == freezed
          ? _value.layouts
          : layouts // ignore: cast_nullable_to_non_nullable
              as List<T_LayoutBuilderItemProps>?,
      defaultLayoutIndex: defaultLayoutIndex == freezed
          ? _value.defaultLayoutIndex
          : defaultLayoutIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_T_LayoutBuilderPropsCopyWith<$Res>
    implements $T_LayoutBuilderPropsCopyWith<$Res> {
  factory _$$_T_LayoutBuilderPropsCopyWith(_$_T_LayoutBuilderProps value,
          $Res Function(_$_T_LayoutBuilderProps) then) =
      __$$_T_LayoutBuilderPropsCopyWithImpl<$Res>;
  @override
  $Res call({List<T_LayoutBuilderItemProps>? layouts, int? defaultLayoutIndex});
}

/// @nodoc
class __$$_T_LayoutBuilderPropsCopyWithImpl<$Res>
    extends _$T_LayoutBuilderPropsCopyWithImpl<$Res>
    implements _$$_T_LayoutBuilderPropsCopyWith<$Res> {
  __$$_T_LayoutBuilderPropsCopyWithImpl(_$_T_LayoutBuilderProps _value,
      $Res Function(_$_T_LayoutBuilderProps) _then)
      : super(_value, (v) => _then(v as _$_T_LayoutBuilderProps));

  @override
  _$_T_LayoutBuilderProps get _value => super._value as _$_T_LayoutBuilderProps;

  @override
  $Res call({
    Object? layouts = freezed,
    Object? defaultLayoutIndex = freezed,
  }) {
    return _then(_$_T_LayoutBuilderProps(
      layouts: layouts == freezed
          ? _value._layouts
          : layouts // ignore: cast_nullable_to_non_nullable
              as List<T_LayoutBuilderItemProps>?,
      defaultLayoutIndex: defaultLayoutIndex == freezed
          ? _value.defaultLayoutIndex
          : defaultLayoutIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_T_LayoutBuilderProps implements _T_LayoutBuilderProps {
  const _$_T_LayoutBuilderProps(
      {final List<T_LayoutBuilderItemProps>? layouts, this.defaultLayoutIndex})
      : _layouts = layouts;

  factory _$_T_LayoutBuilderProps.fromJson(Map<String, dynamic> json) =>
      _$$_T_LayoutBuilderPropsFromJson(json);

  final List<T_LayoutBuilderItemProps>? _layouts;
  @override
  List<T_LayoutBuilderItemProps>? get layouts {
    final value = _layouts;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? defaultLayoutIndex;

  @JsonKey(ignore: true)
  @override
  _$$_T_LayoutBuilderPropsCopyWith<_$_T_LayoutBuilderProps> get copyWith =>
      __$$_T_LayoutBuilderPropsCopyWithImpl<_$_T_LayoutBuilderProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_T_LayoutBuilderPropsToJson(
      this,
    );
  }
}

abstract class _T_LayoutBuilderProps implements T_LayoutBuilderProps {
  const factory _T_LayoutBuilderProps(
      {final List<T_LayoutBuilderItemProps>? layouts,
      final int? defaultLayoutIndex}) = _$_T_LayoutBuilderProps;

  factory _T_LayoutBuilderProps.fromJson(Map<String, dynamic> json) =
      _$_T_LayoutBuilderProps.fromJson;

  @override
  List<T_LayoutBuilderItemProps>? get layouts;
  @override
  int? get defaultLayoutIndex;
  @override
  @JsonKey(ignore: true)
  _$$_T_LayoutBuilderPropsCopyWith<_$_T_LayoutBuilderProps> get copyWith =>
      throw _privateConstructorUsedError;
}
