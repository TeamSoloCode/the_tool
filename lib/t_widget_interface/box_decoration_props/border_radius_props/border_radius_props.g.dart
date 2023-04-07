// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_radius_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BorderRadiusProps _$$_BorderRadiusPropsFromJson(Map<String, dynamic> json) =>
    _$_BorderRadiusProps(
      colors: json['colors'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      type: json['type'] as String?,
      radius: (json['radius'] as num?)?.toDouble(),
      left: (json['left'] as num?)?.toDouble(),
      right: (json['right'] as num?)?.toDouble(),
      bottomLeft: json['bottomLeft'],
      bottomRight: json['bottomRight'],
      topLeft: json['topLeft'],
      topRight: json['topRight'],
      bottom: (json['bottom'] as num?)?.toDouble(),
      top: (json['top'] as num?)?.toDouble(),
      blurRadius: json['blurRadius'] as int?,
      colorBoxShadow: json['colorBoxShadow'] as String?,
      offset: json['offset'] as int?,
      spreadRadius: json['spreadRadius'] as int?,
    );

Map<String, dynamic> _$$_BorderRadiusPropsToJson(
        _$_BorderRadiusProps instance) =>
    <String, dynamic>{
      'colors': instance.colors,
      'width': instance.width,
      'type': instance.type,
      'radius': instance.radius,
      'left': instance.left,
      'right': instance.right,
      'bottomLeft': instance.bottomLeft,
      'bottomRight': instance.bottomRight,
      'topLeft': instance.topLeft,
      'topRight': instance.topRight,
      'bottom': instance.bottom,
      'top': instance.top,
      'blurRadius': instance.blurRadius,
      'colorBoxShadow': instance.colorBoxShadow,
      'offset': instance.offset,
      'spreadRadius': instance.spreadRadius,
    };
