// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$DataColumnPropsCopyWithImpl<$Res>;
  $Res call({String label, String? tooltip, bool numeric, String? onSort});
}

/// @nodoc
class _$DataColumnPropsCopyWithImpl<$Res>
    implements $DataColumnPropsCopyWith<$Res> {
  _$DataColumnPropsCopyWithImpl(this._value, this._then);

  final DataColumnProps _value;
  // ignore: unused_field
  final $Res Function(DataColumnProps) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? tooltip = freezed,
    Object? numeric = freezed,
    Object? onSort = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: tooltip == freezed
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
      numeric: numeric == freezed
          ? _value.numeric
          : numeric // ignore: cast_nullable_to_non_nullable
              as bool,
      onSort: onSort == freezed
          ? _value.onSort
          : onSort // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_DataColumnPropsCopyWith<$Res>
    implements $DataColumnPropsCopyWith<$Res> {
  factory _$$_DataColumnPropsCopyWith(
          _$_DataColumnProps value, $Res Function(_$_DataColumnProps) then) =
      __$$_DataColumnPropsCopyWithImpl<$Res>;
  @override
  $Res call({String label, String? tooltip, bool numeric, String? onSort});
}

/// @nodoc
class __$$_DataColumnPropsCopyWithImpl<$Res>
    extends _$DataColumnPropsCopyWithImpl<$Res>
    implements _$$_DataColumnPropsCopyWith<$Res> {
  __$$_DataColumnPropsCopyWithImpl(
      _$_DataColumnProps _value, $Res Function(_$_DataColumnProps) _then)
      : super(_value, (v) => _then(v as _$_DataColumnProps));

  @override
  _$_DataColumnProps get _value => super._value as _$_DataColumnProps;

  @override
  $Res call({
    Object? label = freezed,
    Object? tooltip = freezed,
    Object? numeric = freezed,
    Object? onSort = freezed,
  }) {
    return _then(_$_DataColumnProps(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tooltip: tooltip == freezed
          ? _value.tooltip
          : tooltip // ignore: cast_nullable_to_non_nullable
              as String?,
      numeric: numeric == freezed
          ? _value.numeric
          : numeric // ignore: cast_nullable_to_non_nullable
              as bool,
      onSort: onSort == freezed
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
      {required this.label, this.tooltip, this.numeric = false, this.onSort});

  factory _$_DataColumnProps.fromJson(Map<String, dynamic> json) =>
      _$$_DataColumnPropsFromJson(json);

  @override
  final String label;
  @override
  final String? tooltip;
  @override
  @JsonKey()
  final bool numeric;
  @override
  final String? onSort;

  @JsonKey(ignore: true)
  @override
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
      final bool numeric,
      final String? onSort}) = _$_DataColumnProps;

  factory _DataColumnProps.fromJson(Map<String, dynamic> json) =
      _$_DataColumnProps.fromJson;

  @override
  String get label;
  @override
  String? get tooltip;
  @override
  bool get numeric;
  @override
  String? get onSort;
  @override
  @JsonKey(ignore: true)
  _$$_DataColumnPropsCopyWith<_$_DataColumnProps> get copyWith =>
      throw _privateConstructorUsedError;
}
