// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_column_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataColumnPropsImpl _$$DataColumnPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$DataColumnPropsImpl(
      label: json['label'] as String,
      tooltip: json['tooltip'] as String?,
      fieldData: json['fieldData'] as String?,
      numeric: json['numeric'] as bool? ?? false,
      onSort: json['onSort'] as String?,
      fixedWidth: json['fixedWidth'],
    );

Map<String, dynamic> _$$DataColumnPropsImplToJson(
        _$DataColumnPropsImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'tooltip': instance.tooltip,
      'fieldData': instance.fieldData,
      'numeric': instance.numeric,
      'onSort': instance.onSort,
      'fixedWidth': instance.fixedWidth,
    };
