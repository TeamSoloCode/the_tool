// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape_border_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TShapeBorderPropsImpl _$$TShapeBorderPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$TShapeBorderPropsImpl(
      type: json['type'] as String?,
      side: json['side'] == null
          ? null
          : TBorderSideProps.fromJson(json['side'] as Map<String, dynamic>),
      borderRadius: json['borderRadius'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TShapeBorderPropsImplToJson(
        _$TShapeBorderPropsImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'side': instance.side?.toJson(),
      'borderRadius': instance.borderRadius,
    };
