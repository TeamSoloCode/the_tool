// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_builder_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_T_LayoutBuilderProps _$$_T_LayoutBuilderPropsFromJson(
        Map<String, dynamic> json) =>
    _$_T_LayoutBuilderProps(
      layouts: (json['layouts'] as List<dynamic>?)
          ?.map((e) =>
              T_LayoutBuilderItemProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultLayoutIndex: json['defaultLayoutIndex'] as int?,
    );

Map<String, dynamic> _$$_T_LayoutBuilderPropsToJson(
        _$_T_LayoutBuilderProps instance) =>
    <String, dynamic>{
      'layouts': instance.layouts,
      'defaultLayoutIndex': instance.defaultLayoutIndex,
    };
