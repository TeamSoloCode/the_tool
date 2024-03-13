// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$T_GradientPropsImpl _$$T_GradientPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$T_GradientPropsImpl(
      type: json['type'] as String?,
      colors: json['colors'] as List<dynamic>?,
      end: json['end'],
      begin: json['begin'],
      stops: json['stops'],
    );

Map<String, dynamic> _$$T_GradientPropsImplToJson(
        _$T_GradientPropsImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'colors': instance.colors,
      'end': instance.end,
      'begin': instance.begin,
      'stops': instance.stops,
    };
