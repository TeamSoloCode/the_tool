// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'border_side_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TBorderSideProps _$TBorderSidePropsFromJson(Map<String, dynamic> json) {
  return _TBorderSideProps.fromJson(json);
}

/// @nodoc
mixin _$TBorderSideProps {
  String? get color => throw _privateConstructorUsedError;
  String? get style => throw _privateConstructorUsedError;
  dynamic get width => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TBorderSidePropsCopyWith<TBorderSideProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TBorderSidePropsCopyWith<$Res> {
  factory $TBorderSidePropsCopyWith(
          TBorderSideProps value, $Res Function(TBorderSideProps) then) =
      _$TBorderSidePropsCopyWithImpl<$Res, TBorderSideProps>;
  @useResult
  $Res call({String? color, String? style, dynamic width});
}

/// @nodoc
class _$TBorderSidePropsCopyWithImpl<$Res, $Val extends TBorderSideProps>
    implements $TBorderSidePropsCopyWith<$Res> {
  _$TBorderSidePropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? style = freezed,
    Object? width = freezed,
  }) {
    return _then(_value.copyWith(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TBorderSidePropsImplCopyWith<$Res>
    implements $TBorderSidePropsCopyWith<$Res> {
  factory _$$TBorderSidePropsImplCopyWith(_$TBorderSidePropsImpl value,
          $Res Function(_$TBorderSidePropsImpl) then) =
      __$$TBorderSidePropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? color, String? style, dynamic width});
}

/// @nodoc
class __$$TBorderSidePropsImplCopyWithImpl<$Res>
    extends _$TBorderSidePropsCopyWithImpl<$Res, _$TBorderSidePropsImpl>
    implements _$$TBorderSidePropsImplCopyWith<$Res> {
  __$$TBorderSidePropsImplCopyWithImpl(_$TBorderSidePropsImpl _value,
      $Res Function(_$TBorderSidePropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? style = freezed,
    Object? width = freezed,
  }) {
    return _then(_$TBorderSidePropsImpl(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TBorderSidePropsImpl implements _TBorderSideProps {
  const _$TBorderSidePropsImpl({this.color, this.style, this.width});

  factory _$TBorderSidePropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TBorderSidePropsImplFromJson(json);

  @override
  final String? color;
  @override
  final String? style;
  @override
  final dynamic width;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TBorderSidePropsImplCopyWith<_$TBorderSidePropsImpl> get copyWith =>
      __$$TBorderSidePropsImplCopyWithImpl<_$TBorderSidePropsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TBorderSidePropsImplToJson(
      this,
    );
  }
}

abstract class _TBorderSideProps implements TBorderSideProps {
  const factory _TBorderSideProps(
      {final String? color,
      final String? style,
      final dynamic width}) = _$TBorderSidePropsImpl;

  factory _TBorderSideProps.fromJson(Map<String, dynamic> json) =
      _$TBorderSidePropsImpl.fromJson;

  @override
  String? get color;
  @override
  String? get style;
  @override
  dynamic get width;
  @override
  @JsonKey(ignore: true)
  _$$TBorderSidePropsImplCopyWith<_$TBorderSidePropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
