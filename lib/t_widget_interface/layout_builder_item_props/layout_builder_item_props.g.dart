// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_builder_item_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$T_LayoutBuilderItemPropsImpl _$$T_LayoutBuilderItemPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$T_LayoutBuilderItemPropsImpl(
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      maxHeight: json['maxHeight'],
      minHeight: json['minHeight'],
      maxWidth: json['maxWidth'],
      minWidth: json['minWidth'],
      className: json['className'],
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$$T_LayoutBuilderItemPropsImplToJson(
        _$T_LayoutBuilderItemPropsImpl instance) =>
    <String, dynamic>{
      'child': instance.child?.toJson(),
      'maxHeight': instance.maxHeight,
      'minHeight': instance.minHeight,
      'maxWidth': instance.maxWidth,
      'minWidth': instance.minWidth,
      'className': instance.className,
      'isDefault': instance.isDefault,
    };
