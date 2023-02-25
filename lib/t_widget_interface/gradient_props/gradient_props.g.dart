// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_T_GradientProps _$$_T_GradientPropsFromJson(Map<String, dynamic> json) =>
    _$_T_GradientProps(
      type: json['type'] as String?,
      colors: json['colors'] as List<dynamic>?,
      end: json['end'],
      begin: json['begin'],
      stops: json['stops'],
    );

Map<String, dynamic> _$$_T_GradientPropsToJson(_$_T_GradientProps instance) =>
    <String, dynamic>{
      'type': instance.type,
      'colors': instance.colors,
      'end': instance.end,
      'begin': instance.begin,
      'stops': instance.stops,
    };
