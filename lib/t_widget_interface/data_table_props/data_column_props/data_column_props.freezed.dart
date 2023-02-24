// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_column_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataColumnProps _$DataColumnPropsFromJson(Map<String, dynamic> json) {
  return _DataColumnProps.fromJson(json);
}

/// @nodoc
mixin _$DataColumnProps {
  String get label => throw _privateConstructorUsedError;
  String? get tooltip => throw _privateConstructorUsedError;
  String? get fieldData => throw _privateConstructorUsedError;
  bool get numeric => throw _privateConstructorUsedError;
  String? get onSort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataColumnPropsCopyWith<DataColumnProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataColumnPropsCopyWith<$Res> {
  factory $DataColumnPropsCopyWith(
          DataColumnProps value, $Res Function(DataColumnProps) then) =
      _$DataColumnPropsCopyWithImpl<$Res, DataColumnProps>;
  @useResult
  $Res call(
      {String label,
      String? tooltip,
      String? fieldData,
      bool numeric,
      String? onSort});
}

/// @nodoc
class _$DataColumnPropsCopyWithImpl<$Res, $Val extends DataColumnProps>
    implements $DataColumnPropsCopyWith<$Res> {
  _$DataColumnPropsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? tooltip = freezed,
    Object? fieldData = freezed,
    Object? numeric = null,
    Object? onSort = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldData: freezed == fieldData
          ? _value.fieldData
          : fieldData // ignore: cast_nullable_to_non_nullable
              as String?,
      numeric: null == numeric
          ? _value.numeric
          : numeric // ignore: cast_nullable_to_non_nullable
              as bool,
      onSort: freezed == onSort
          ? _value.onSort
          : onSort // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataColumnPropsCopyWith<$Res>
    implements $DataColumnPropsCopyWith<$Res> {
  factory _$$_DataColumnPropsCopyWith(
          _$_DataColumnProps value, $Res Function(_$_DataColumnProps) then) =
      __$$_DataColumnPropsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      String? tooltip,
      String? fieldData,
      bool numeric,
      String? onSort});
}

/// @nodoc
class __$$_DataColumnPropsCopyWithImpl<$Res>
    extends _$DataColumnPropsCopyWithImpl<$Res, _$_DataColumnProps>
    implements _$$_DataColumnPropsCopyWith<$Res> {
  __$$_DataColumnPropsCopyWithImpl(
      _$_DataColumnProps _value, $Res Function(_$_DataColumnProps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? tooltip = freezed,
    Object? fieldData = freezed,
    Object? numeric = null,
    Object? onSort = freezed,
  }) {
    return _then(_$_DataColumnProps(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: freezed == tooltip
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldData: freezed == fieldData
          ? _value.fieldData
          : fieldData // ignore: cast_nullable_to_non_nullable
              as String?,
      numeric: null == numeric
          ? _value.numeric
          : numeric // ignore: cast_nullable_to_non_nullable
              as bool,
      onSort: freezed == onSort
          ? _value.onSort
          : onSort // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataColumnProps implements _DataColumnProps {
  _$_DataColumnProps(
      {required this.label,
      this.tooltip,
      this.fieldData,
      this.numeric = false,
      this.onSort});

  factory _$_DataColumnProps.fromJson(Map<String, dynamic> json) =>
      _$$_DataColumnPropsFromJson(json);

  @override
  final String label;
  @override
  final String? tooltip;
  @override
  final String? fieldData;
  @override
  @JsonKey()
  final bool numeric;
  @override
  final String? onSort;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataColumnPropsCopyWith<_$_DataColumnProps> get copyWith =>
      __$$_DataColumnPropsCopyWithImpl<_$_DataColumnProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataColumnPropsToJson(
      this,
    );
  }
}

abstract class _DataColumnProps implements DataColumnProps {
  factory _DataColumnProps(
      {required final String label,
      final String? tooltip,
      final String? fieldData,
      final bool numeric,
      final String? onSort}) = _$_DataColumnProps;

  factory _DataColumnProps.fromJson(Map<String, dynamic> json) =
      _$_DataColumnProps.fromJson;

  @override
  String get label;
  @override
  String? get tooltip;
  @override
  String? get fieldData;
  @override
  bool get numeric;
  @override
  String? get onSort;
  @override
  @JsonKey(ignore: true)
  _$$_DataColumnPropsCopyWith<_$_DataColumnProps> get copyWith =>
      throw _privateConstructorUsedError;
}
