// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_column_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataColumnProps _$$_DataColumnPropsFromJson(Map<String, dynamic> json) =>
    _$_DataColumnProps(
      label: json['label'] as String,
      tooltip: json['tooltip'] as String?,
      numeric: json['numeric'] as bool? ?? false,
      onSort: json['onSort'] as String?,
    );

Map<String, dynamic> _$$_DataColumnPropsToJson(_$_DataColumnProps instance) =>
    <String, dynamic>{
      'label': instance.label,
      'tooltip': instance.tooltip,
      'numeric': instance.numeric,
      'onSort': instance.onSort,
    };
