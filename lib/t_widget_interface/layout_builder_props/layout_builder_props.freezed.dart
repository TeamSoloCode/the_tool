// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_builder_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
      _$T_LayoutBuilderPropsCopyWithImpl<$Res, T_LayoutBuilderProps>;
  @useResult
  $Res call({List<T_LayoutBuilderItemProps>? layouts, int? defaultLayoutIndex});
}

/// @nodoc
class _$T_LayoutBuilderPropsCopyWithImpl<$Res,
        $Val extends T_LayoutBuilderProps>
    implements $T_LayoutBuilderPropsCopyWith<$Res> {
  _$T_LayoutBuilderPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layouts = freezed,
    Object? defaultLayoutIndex = freezed,
  }) {
    return _then(_value.copyWith(
      layouts: freezed == layouts
          ? _value.layouts
          : layouts // ignore: cast_nullable_to_non_nullable
              as List<T_LayoutBuilderItemProps>?,
      defaultLayoutIndex: freezed == defaultLayoutIndex
          ? _value.defaultLayoutIndex
          : defaultLayoutIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$T_LayoutBuilderPropsImplCopyWith<$Res>
    implements $T_LayoutBuilderPropsCopyWith<$Res> {
  factory _$$T_LayoutBuilderPropsImplCopyWith(_$T_LayoutBuilderPropsImpl value,
          $Res Function(_$T_LayoutBuilderPropsImpl) then) =
      __$$T_LayoutBuilderPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<T_LayoutBuilderItemProps>? layouts, int? defaultLayoutIndex});
}

/// @nodoc
class __$$T_LayoutBuilderPropsImplCopyWithImpl<$Res>
    extends _$T_LayoutBuilderPropsCopyWithImpl<$Res, _$T_LayoutBuilderPropsImpl>
    implements _$$T_LayoutBuilderPropsImplCopyWith<$Res> {
  __$$T_LayoutBuilderPropsImplCopyWithImpl(_$T_LayoutBuilderPropsImpl _value,
      $Res Function(_$T_LayoutBuilderPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layouts = freezed,
    Object? defaultLayoutIndex = freezed,
  }) {
    return _then(_$T_LayoutBuilderPropsImpl(
      layouts: freezed == layouts
          ? _value._layouts
          : layouts // ignore: cast_nullable_to_non_nullable
              as List<T_LayoutBuilderItemProps>?,
      defaultLayoutIndex: freezed == defaultLayoutIndex
          ? _value.defaultLayoutIndex
          : defaultLayoutIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$T_LayoutBuilderPropsImpl implements _T_LayoutBuilderProps {
  const _$T_LayoutBuilderPropsImpl(
      {final List<T_LayoutBuilderItemProps>? layouts, this.defaultLayoutIndex})
      : _layouts = layouts;

  factory _$T_LayoutBuilderPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$T_LayoutBuilderPropsImplFromJson(json);

  final List<T_LayoutBuilderItemProps>? _layouts;
  @override
  List<T_LayoutBuilderItemProps>? get layouts {
    final value = _layouts;
    if (value == null) return null;
    if (_layouts is EqualUnmodifiableListView) return _layouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? defaultLayoutIndex;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$T_LayoutBuilderPropsImplCopyWith<_$T_LayoutBuilderPropsImpl>
      get copyWith =>
          __$$T_LayoutBuilderPropsImplCopyWithImpl<_$T_LayoutBuilderPropsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$T_LayoutBuilderPropsImplToJson(
      this,
    );
  }
}

abstract class _T_LayoutBuilderProps implements T_LayoutBuilderProps {
  const factory _T_LayoutBuilderProps(
      {final List<T_LayoutBuilderItemProps>? layouts,
      final int? defaultLayoutIndex}) = _$T_LayoutBuilderPropsImpl;

  factory _T_LayoutBuilderProps.fromJson(Map<String, dynamic> json) =
      _$T_LayoutBuilderPropsImpl.fromJson;

  @override
  List<T_LayoutBuilderItemProps>? get layouts;
  @override
  int? get defaultLayoutIndex;
  @override
  @JsonKey(ignore: true)
  _$$T_LayoutBuilderPropsImplCopyWith<_$T_LayoutBuilderPropsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
