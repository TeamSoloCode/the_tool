// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_builder_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$T_LayoutBuilderPropsImpl _$$T_LayoutBuilderPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$T_LayoutBuilderPropsImpl(
      layouts: (json['layouts'] as List<dynamic>?)
          ?.map((e) =>
              T_LayoutBuilderItemProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultLayoutIndex: json['defaultLayoutIndex'] as int?,
    );

Map<String, dynamic> _$$T_LayoutBuilderPropsImplToJson(
        _$T_LayoutBuilderPropsImpl instance) =>
    <String, dynamic>{
      'layouts': instance.layouts?.map((e) => e.toJson()).toList(),
      'defaultLayoutIndex': instance.defaultLayoutIndex,
    };
