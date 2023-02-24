// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'box_decoration_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BoxDecorationProps {
  BorderProps? get borderProps => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BoxDecorationPropsCopyWith<BoxDecorationProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoxDecorationPropsCopyWith<$Res> {
  factory $BoxDecorationPropsCopyWith(
          BoxDecorationProps value, $Res Function(BoxDecorationProps) then) =
      _$BoxDecorationPropsCopyWithImpl<$Res, BoxDecorationProps>;
  @useResult
  $Res call({BorderProps? borderProps});

  $BorderPropsCopyWith<$Res>? get borderProps;
}

/// @nodoc
class _$BoxDecorationPropsCopyWithImpl<$Res, $Val extends BoxDecorationProps>
    implements $BoxDecorationPropsCopyWith<$Res> {
  _$BoxDecorationPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? borderProps = freezed,
  }) {
    return _then(_value.copyWith(
      borderProps: freezed == borderProps
          ? _value.borderProps
          : borderProps // ignore: cast_nullable_to_non_nullable
              as BorderProps?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BorderPropsCopyWith<$Res>? get borderProps {
    if (_value.borderProps == null) {
      return null;
    }

    return $BorderPropsCopyWith<$Res>(_value.borderProps!, (value) {
      return _then(_value.copyWith(borderProps: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BoxDecorationPropsCopyWith<$Res>
    implements $BoxDecorationPropsCopyWith<$Res> {
  factory _$$_BoxDecorationPropsCopyWith(_$_BoxDecorationProps value,
          $Res Function(_$_BoxDecorationProps) then) =
      __$$_BoxDecorationPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BorderProps? borderProps});

  @override
  $BorderPropsCopyWith<$Res>? get borderProps;
}

/// @nodoc
class __$$_BoxDecorationPropsCopyWithImpl<$Res>
    extends _$BoxDecorationPropsCopyWithImpl<$Res, _$_BoxDecorationProps>
    implements _$$_BoxDecorationPropsCopyWith<$Res> {
  __$$_BoxDecorationPropsCopyWithImpl(
      _$_BoxDecorationProps _value, $Res Function(_$_BoxDecorationProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? borderProps = freezed,
  }) {
    return _then(_$_BoxDecorationProps(
      borderProps: freezed == borderProps
          ? _value.borderProps
          : borderProps // ignore: cast_nullable_to_non_nullable
              as BorderProps?,
    ));
  }
}

/// @nodoc

class _$_BoxDecorationProps
    with DiagnosticableTreeMixin
    implements _BoxDecorationProps {
  const _$_BoxDecorationProps({this.borderProps});

  @override
  final BorderProps? borderProps;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BoxDecorationProps(borderProps: $borderProps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BoxDecorationProps'))
      ..add(DiagnosticsProperty('borderProps', borderProps));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BoxDecorationProps &&
            (identical(other.borderProps, borderProps) ||
                other.borderProps == borderProps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, borderProps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BoxDecorationPropsCopyWith<_$_BoxDecorationProps> get copyWith =>
      __$$_BoxDecorationPropsCopyWithImpl<_$_BoxDecorationProps>(
          this, _$identity);
}

abstract class _BoxDecorationProps implements BoxDecorationProps {
  const factory _BoxDecorationProps({final BorderProps? borderProps}) =
      _$_BoxDecorationProps;

  @override
  BorderProps? get borderProps;
  @override
  @JsonKey(ignore: true)
  _$$_BoxDecorationPropsCopyWith<_$_BoxDecorationProps> get copyWith =>
      throw _privateConstructorUsedError;
}
