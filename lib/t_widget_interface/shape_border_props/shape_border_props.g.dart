// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape_border_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TShapeBorderProps _$$_TShapeBorderPropsFromJson(Map<String, dynamic> json) =>
    _$_TShapeBorderProps(
      type: json['type'] as String?,
      side: json['side'] == null
          ? null
          : TBorderSideProps.fromJson(json['side'] as Map<String, dynamic>),
      borderRadius: json['borderRadius'] == null
          ? null
          : BorderRadiusProps.fromJson(
              json['borderRadius'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TShapeBorderPropsToJson(
        _$_TShapeBorderProps instance) =>
    <String, dynamic>{
      'type': instance.type,
      'side': instance.side?.toJson(),
      'borderRadius': instance.borderRadius?.toJson(),
    };
