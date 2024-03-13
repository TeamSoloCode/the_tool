// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_row_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DataRowProps _$DataRowPropsFromJson(Map<String, dynamic> json) {
  return _DataRowProps.fromJson(json);
}

/// @nodoc
mixin _$DataRowProps {
  bool get selected => throw _privateConstructorUsedError;
  String? get onSelectChanged => throw _privateConstructorUsedError;
  String? get onLongPress => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  List<DataCellProps> get cells => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataRowPropsCopyWith<DataRowProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataRowPropsCopyWith<$Res> {
  factory $DataRowPropsCopyWith(
          DataRowProps value, $Res Function(DataRowProps) then) =
      _$DataRowPropsCopyWithImpl<$Res, DataRowProps>;
  @useResult
  $Res call(
      {bool selected,
      String? onSelectChanged,
      String? onLongPress,
      String? color,
      List<DataCellProps> cells});
}

/// @nodoc
class _$DataRowPropsCopyWithImpl<$Res, $Val extends DataRowProps>
    implements $DataRowPropsCopyWith<$Res> {
  _$DataRowPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = null,
    Object? onSelectChanged = freezed,
    Object? onLongPress = freezed,
    Object? color = freezed,
    Object? cells = null,
  }) {
    return _then(_value.copyWith(
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectChanged: freezed == onSelectChanged
          ? _value.onSelectChanged
          : onSelectChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onLongPress: freezed == onLongPress
          ? _value.onLongPress
          : onLongPress // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      cells: null == cells
          ? _value.cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<DataCellProps>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataRowPropsImplCopyWith<$Res>
    implements $DataRowPropsCopyWith<$Res> {
  factory _$$DataRowPropsImplCopyWith(
          _$DataRowPropsImpl value, $Res Function(_$DataRowPropsImpl) then) =
      __$$DataRowPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool selected,
      String? onSelectChanged,
      String? onLongPress,
      String? color,
      List<DataCellProps> cells});
}

/// @nodoc
class __$$DataRowPropsImplCopyWithImpl<$Res>
    extends _$DataRowPropsCopyWithImpl<$Res, _$DataRowPropsImpl>
    implements _$$DataRowPropsImplCopyWith<$Res> {
  __$$DataRowPropsImplCopyWithImpl(
      _$DataRowPropsImpl _value, $Res Function(_$DataRowPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = null,
    Object? onSelectChanged = freezed,
    Object? onLongPress = freezed,
    Object? color = freezed,
    Object? cells = null,
  }) {
    return _then(_$DataRowPropsImpl(
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectChanged: freezed == onSelectChanged
          ? _value.onSelectChanged
          : onSelectChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onLongPress: freezed == onLongPress
          ? _value.onLongPress
          : onLongPress // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      cells: null == cells
          ? _value._cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<DataCellProps>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataRowPropsImpl implements _DataRowProps {
  _$DataRowPropsImpl(
      {this.selected = false,
      this.onSelectChanged,
      this.onLongPress,
      this.color,
      required final List<DataCellProps> cells})
      : _cells = cells;

  factory _$DataRowPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataRowPropsImplFromJson(json);

  @override
  @JsonKey()
  final bool selected;
  @override
  final String? onSelectChanged;
  @override
  final String? onLongPress;
  @override
  final String? color;
  final List<DataCellProps> _cells;
  @override
  List<DataCellProps> get cells {
    if (_cells is EqualUnmodifiableListView) return _cells;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cells);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataRowPropsImplCopyWith<_$DataRowPropsImpl> get copyWith =>
      __$$DataRowPropsImplCopyWithImpl<_$DataRowPropsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataRowPropsImplToJson(
      this,
    );
  }
}

abstract class _DataRowProps implements DataRowProps {
  factory _DataRowProps(
      {final bool selected,
      final String? onSelectChanged,
      final String? onLongPress,
      final String? color,
      required final List<DataCellProps> cells}) = _$DataRowPropsImpl;

  factory _DataRowProps.fromJson(Map<String, dynamic> json) =
      _$DataRowPropsImpl.fromJson;

  @override
  bool get selected;
  @override
  String? get onSelectChanged;
  @override
  String? get onLongPress;
  @override
  String? get color;
  @override
  List<DataCellProps> get cells;
  @override
  @JsonKey(ignore: true)
  _$$DataRowPropsImplCopyWith<_$DataRowPropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
