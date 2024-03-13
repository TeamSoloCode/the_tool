// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shape_border_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TShapeBorderProps _$TShapeBorderPropsFromJson(Map<String, dynamic> json) {
  return _TShapeBorderProps.fromJson(json);
}

/// @nodoc
mixin _$TShapeBorderProps {
  String? get type => throw _privateConstructorUsedError;
  TBorderSideProps? get side => throw _privateConstructorUsedError;
  Map<String, dynamic>? get borderRadius => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TShapeBorderPropsCopyWith<TShapeBorderProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TShapeBorderPropsCopyWith<$Res> {
  factory $TShapeBorderPropsCopyWith(
          TShapeBorderProps value, $Res Function(TShapeBorderProps) then) =
      _$TShapeBorderPropsCopyWithImpl<$Res, TShapeBorderProps>;
  @useResult
  $Res call(
      {String? type,
      TBorderSideProps? side,
      Map<String, dynamic>? borderRadius});

  $TBorderSidePropsCopyWith<$Res>? get side;
}

/// @nodoc
class _$TShapeBorderPropsCopyWithImpl<$Res, $Val extends TShapeBorderProps>
    implements $TShapeBorderPropsCopyWith<$Res> {
  _$TShapeBorderPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? side = freezed,
    Object? borderRadius = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      side: freezed == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as TBorderSideProps?,
      borderRadius: freezed == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TBorderSidePropsCopyWith<$Res>? get side {
    if (_value.side == null) {
      return null;
    }

    return $TBorderSidePropsCopyWith<$Res>(_value.side!, (value) {
      return _then(_value.copyWith(side: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TShapeBorderPropsImplCopyWith<$Res>
    implements $TShapeBorderPropsCopyWith<$Res> {
  factory _$$TShapeBorderPropsImplCopyWith(_$TShapeBorderPropsImpl value,
          $Res Function(_$TShapeBorderPropsImpl) then) =
      __$$TShapeBorderPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      TBorderSideProps? side,
      Map<String, dynamic>? borderRadius});

  @override
  $TBorderSidePropsCopyWith<$Res>? get side;
}

/// @nodoc
class __$$TShapeBorderPropsImplCopyWithImpl<$Res>
    extends _$TShapeBorderPropsCopyWithImpl<$Res, _$TShapeBorderPropsImpl>
    implements _$$TShapeBorderPropsImplCopyWith<$Res> {
  __$$TShapeBorderPropsImplCopyWithImpl(_$TShapeBorderPropsImpl _value,
      $Res Function(_$TShapeBorderPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? side = freezed,
    Object? borderRadius = freezed,
  }) {
    return _then(_$TShapeBorderPropsImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      side: freezed == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as TBorderSideProps?,
      borderRadius: freezed == borderRadius
          ? _value._borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TShapeBorderPropsImpl implements _TShapeBorderProps {
  const _$TShapeBorderPropsImpl(
      {this.type, this.side, final Map<String, dynamic>? borderRadius})
      : _borderRadius = borderRadius;

  factory _$TShapeBorderPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TShapeBorderPropsImplFromJson(json);

  @override
  final String? type;
  @override
  final TBorderSideProps? side;
  final Map<String, dynamic>? _borderRadius;
  @override
  Map<String, dynamic>? get borderRadius {
    final value = _borderRadius;
    if (value == null) return null;
    if (_borderRadius is EqualUnmodifiableMapView) return _borderRadius;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TShapeBorderPropsImplCopyWith<_$TShapeBorderPropsImpl> get copyWith =>
      __$$TShapeBorderPropsImplCopyWithImpl<_$TShapeBorderPropsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TShapeBorderPropsImplToJson(
      this,
    );
  }
}

abstract class _TShapeBorderProps implements TShapeBorderProps {
  const factory _TShapeBorderProps(
      {final String? type,
      final TBorderSideProps? side,
      final Map<String, dynamic>? borderRadius}) = _$TShapeBorderPropsImpl;

  factory _TShapeBorderProps.fromJson(Map<String, dynamic> json) =
      _$TShapeBorderPropsImpl.fromJson;

  @override
  String? get type;
  @override
  TBorderSideProps? get side;
  @override
  Map<String, dynamic>? get borderRadius;
  @override
  @JsonKey(ignore: true)
  _$$TShapeBorderPropsImplCopyWith<_$TShapeBorderPropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
