// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$T_DrawerPropsImpl _$$T_DrawerPropsImplFromJson(Map<String, dynamic> json) =>
    _$T_DrawerPropsImpl(
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      backgroundColor: json['backgroundColor'] as String?,
      width: json['width'],
      elevation: (json['elevation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$T_DrawerPropsImplToJson(_$T_DrawerPropsImpl instance) =>
    <String, dynamic>{
      'child': instance.child?.toJson(),
      'backgroundColor': instance.backgroundColor,
      'width': instance.width,
      'elevation': instance.elevation,
    };
