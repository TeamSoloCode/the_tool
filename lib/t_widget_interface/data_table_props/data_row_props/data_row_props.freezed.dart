// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_row_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$DataRowPropsCopyWithImpl<$Res>;
  $Res call(
      {bool selected,
      String? onSelectChanged,
      String? onLongPress,
      String? color,
      List<DataCellProps> cells});
}

/// @nodoc
class _$DataRowPropsCopyWithImpl<$Res> implements $DataRowPropsCopyWith<$Res> {
  _$DataRowPropsCopyWithImpl(this._value, this._then);

  final DataRowProps _value;
  // ignore: unused_field
  final $Res Function(DataRowProps) _then;

  @override
  $Res call({
    Object? selected = freezed,
    Object? onSelectChanged = freezed,
    Object? onLongPress = freezed,
    Object? color = freezed,
    Object? cells = freezed,
  }) {
    return _then(_value.copyWith(
      selected: selected == freezed
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectChanged: onSelectChanged == freezed
          ? _value.onSelectChanged
          : onSelectChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onLongPress: onLongPress == freezed
          ? _value.onLongPress
          : onLongPress // ignore: cast_nullable_to_non_nullable
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      cells: cells == freezed
          ? _value.cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<DataCellProps>,
    ));
  }
}

/// @nodoc
abstract class _$$_DataRowPropsCopyWith<$Res>
    implements $DataRowPropsCopyWith<$Res> {
  factory _$$_DataRowPropsCopyWith(
          _$_DataRowProps value, $Res Function(_$_DataRowProps) then) =
      __$$_DataRowPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool selected,
      String? onSelectChanged,
      String? onLongPress,
      String? color,
      List<DataCellProps> cells});
}

/// @nodoc
class __$$_DataRowPropsCopyWithImpl<$Res>
    extends _$DataRowPropsCopyWithImpl<$Res>
    implements _$$_DataRowPropsCopyWith<$Res> {
  __$$_DataRowPropsCopyWithImpl(
      _$_DataRowProps _value, $Res Function(_$_DataRowProps) _then)
      : super(_value, (v) => _then(v as _$_DataRowProps));

  @override
  _$_DataRowProps get _value => super._value as _$_DataRowProps;

  @override
  $Res call({
    Object? selected = freezed,
    Object? onSelectChanged = freezed,
    Object? onLongPress = freezed,
    Object? color = freezed,
    Object? cells = freezed,
  }) {
    return _then(_$_DataRowProps(
      selected: selected == freezed
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      onSelectChanged: onSelectChanged == freezed
          ? _value.onSelectChanged
          : onSelectChanged // ignore: cast_nullable_to_non_nullable
              as String?,
      onLongPress: onLongPress == freezed
          ? _value.onLongPress
          : onLongPress // ignore: cast_nullable_to_non_nullable
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      cells: cells == freezed
          ? _value._cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<DataCellProps>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataRowProps implements _DataRowProps {
  _$_DataRowProps(
      {this.selected = false,
      this.onSelectChanged,
      this.onLongPress,
      this.color,
      required final List<DataCellProps> cells})
      : _cells = cells;

  factory _$_DataRowProps.fromJson(Map<String, dynamic> json) =>
      _$$_DataRowPropsFromJson(json);

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
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cells);
  }

  @JsonKey(ignore: true)
  @override
  _$$_DataRowPropsCopyWith<_$_DataRowProps> get copyWith =>
      __$$_DataRowPropsCopyWithImpl<_$_DataRowProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataRowPropsToJson(
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
      required final List<DataCellProps> cells}) = _$_DataRowProps;

  factory _DataRowProps.fromJson(Map<String, dynamic> json) =
      _$_DataRowProps.fromJson;

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
  _$$_DataRowPropsCopyWith<_$_DataRowProps> get copyWith =>
      throw _privateConstructorUsedError;
}