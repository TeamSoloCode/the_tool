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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  dynamic get fixedWidth => throw _privateConstructorUsedError;

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
      String? onSort,
      dynamic fixedWidth});
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
    Object? fixedWidth = freezed,
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
      fixedWidth: freezed == fixedWidth
          ? _value.fixedWidth
          : fixedWidth // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataColumnPropsImplCopyWith<$Res>
    implements $DataColumnPropsCopyWith<$Res> {
  factory _$$DataColumnPropsImplCopyWith(_$DataColumnPropsImpl value,
          $Res Function(_$DataColumnPropsImpl) then) =
      __$$DataColumnPropsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      String? tooltip,
      String? fieldData,
      bool numeric,
      String? onSort,
      dynamic fixedWidth});
}

/// @nodoc
class __$$DataColumnPropsImplCopyWithImpl<$Res>
    extends _$DataColumnPropsCopyWithImpl<$Res, _$DataColumnPropsImpl>
    implements _$$DataColumnPropsImplCopyWith<$Res> {
  __$$DataColumnPropsImplCopyWithImpl(
      _$DataColumnPropsImpl _value, $Res Function(_$DataColumnPropsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? tooltip = freezed,
    Object? fieldData = freezed,
    Object? numeric = null,
    Object? onSort = freezed,
    Object? fixedWidth = freezed,
  }) {
    return _then(_$DataColumnPropsImpl(
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
      fixedWidth: freezed == fixedWidth
          ? _value.fixedWidth
          : fixedWidth // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataColumnPropsImpl implements _DataColumnProps {
  _$DataColumnPropsImpl(
      {required this.label,
      this.tooltip,
      this.fieldData,
      this.numeric = false,
      this.onSort,
      this.fixedWidth});

  factory _$DataColumnPropsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataColumnPropsImplFromJson(json);

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
  @override
  final dynamic fixedWidth;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataColumnPropsImplCopyWith<_$DataColumnPropsImpl> get copyWith =>
      __$$DataColumnPropsImplCopyWithImpl<_$DataColumnPropsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataColumnPropsImplToJson(
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
      final String? onSort,
      final dynamic fixedWidth}) = _$DataColumnPropsImpl;

  factory _DataColumnProps.fromJson(Map<String, dynamic> json) =
      _$DataColumnPropsImpl.fromJson;

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
  dynamic get fixedWidth;
  @override
  @JsonKey(ignore: true)
  _$$DataColumnPropsImplCopyWith<_$DataColumnPropsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
