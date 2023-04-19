// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_T_DrawerProps _$$_T_DrawerPropsFromJson(Map<String, dynamic> json) =>
    _$_T_DrawerProps(
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      backgroundColor: json['backgroundColor'] as String?,
      width: json['width'],
      elevation: (json['elevation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_T_DrawerPropsToJson(_$_T_DrawerProps instance) =>
    <String, dynamic>{
      'child': instance.child?.toJson(),
      'backgroundColor': instance.backgroundColor,
      'width': instance.width,
      'elevation': instance.elevation,
    };
