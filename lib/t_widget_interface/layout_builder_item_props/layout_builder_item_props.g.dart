// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_builder_item_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_T_LayoutBuilderItemProps _$$_T_LayoutBuilderItemPropsFromJson(
        Map<String, dynamic> json) =>
    _$_T_LayoutBuilderItemProps(
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

Map<String, dynamic> _$$_T_LayoutBuilderItemPropsToJson(
        _$_T_LayoutBuilderItemProps instance) =>
    <String, dynamic>{
      'child': instance.child,
      'maxHeight': instance.maxHeight,
      'minHeight': instance.minHeight,
      'maxWidth': instance.maxWidth,
      'minWidth': instance.minWidth,
      'className': instance.className,
      'isDefault': instance.isDefault,
    };
