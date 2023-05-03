// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BorderProps _$$_BorderPropsFromJson(Map<String, dynamic> json) =>
    _$_BorderProps(
      type: json['type'] as String?,
      width: json['width'] as int?,
      color: json['color'] as String?,
      style: json['style'] as String?,
      left: json['left'] as Map<String, dynamic>?,
      right: json['right'] as Map<String, dynamic>?,
      bottom: json['bottom'] as Map<String, dynamic>?,
      top: json['top'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_BorderPropsToJson(_$_BorderProps instance) =>
    <String, dynamic>{
      'type': instance.type,
      'width': instance.width,
      'color': instance.color,
      'style': instance.style,
      'left': instance.left,
      'right': instance.right,
      'bottom': instance.bottom,
      'top': instance.top,
    };
