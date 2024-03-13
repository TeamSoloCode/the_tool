// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clickable_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

T_ClickableProps _$T_ClickablePropsFromJson(Map<String, dynamic> json) {
  return _T_ClickableProps.fromJson(json);
}

/// @nodoc
mixin _$T_ClickableProps {
  String? get onClick => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $T_ClickablePropsCopyWith<T_ClickableProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $T_ClickablePropsCopyWith<$Res> {
  factory $T_ClickablePropsCopyWith(
          T_ClickableProps value, $Res Function(T_ClickableProps) then) =
      _$T_ClickablePropsCopyWithImpl<$Res, T_ClickableProps>;
  @useResult
  $Res call({String? onClick});
}

/// @nodoc
class _$T_ClickablePropsCopyWithImpl<$Res, $Val extends T_ClickableProps>
    implements $T_ClickablePropsCopyWith<$Res> {
  _$T_ClickablePropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onClick = freezed,
  }) {
    return _then(_value.copyWith(
      onClick: freezed == onClick
          ? _value.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$T_ClickablePropsImplCopyWith<$Res>
    implements $T_ClickablePropsCopyWith<$Res> {
  factory _$$T_ClickablePropsImplCopyWith(_$T_ClickablePropsImpl value,
          $Res Function(_$T_ClickablePropsImpl) then) =
      __$$T_ClickablePropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? onClick});
}

/// @nodoc
class __$$T_ClickablePropsImplCopyWithImpl<$Res>
    extends _$T_ClickablePropsCopyWithImpl<$Res, _$T_ClickablePropsImpl>
    implements _$$T_ClickablePropsImplCopyWith<$Res> {
  __$$T_ClickablePropsImplCopyWithImpl(_$T_ClickablePropsImpl _value,
      $Res Function(_$T_ClickablePropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onClick = freezed,
  }) {
    return _then(_$T_ClickablePropsImpl(
      onClick: freezed == onClick
          ? _value.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$T_ClickablePropsImpl implements _T_ClickableProps {
  const _$T_ClickablePropsImpl({this.onClick});

  factory _$T_ClickablePropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$T_ClickablePropsImplFromJson(json);

  @override
  final String? onClick;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$T_ClickablePropsImplCopyWith<_$T_ClickablePropsImpl> get copyWith =>
      __$$T_ClickablePropsImplCopyWithImpl<_$T_ClickablePropsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$T_ClickablePropsImplToJson(
      this,
    );
  }
}

abstract class _T_ClickableProps implements T_ClickableProps {
  const factory _T_ClickableProps({final String? onClick}) =
      _$T_ClickablePropsImpl;

  factory _T_ClickableProps.fromJson(Map<String, dynamic> json) =
      _$T_ClickablePropsImpl.fromJson;

  @override
  String? get onClick;
  @override
  @JsonKey(ignore: true)
  _$$T_ClickablePropsImplCopyWith<_$T_ClickablePropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
