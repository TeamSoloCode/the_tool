// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_item_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BottomNavigationItemProps _$$_BottomNavigationItemPropsFromJson(
        Map<String, dynamic> json) =>
    _$_BottomNavigationItemProps(
      label: json['label'] as String?,
      icon: json['icon'] == null
          ? null
          : LayoutProps.fromJson(json['icon'] as Map<String, dynamic>),
      activeIcon: json['activeIcon'] == null
          ? null
          : LayoutProps.fromJson(json['activeIcon'] as Map<String, dynamic>),
      path: json['path'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
    );

Map<String, dynamic> _$$_BottomNavigationItemPropsToJson(
        _$_BottomNavigationItemProps instance) =>
    <String, dynamic>{
      'label': instance.label,
      'icon': instance.icon?.toJson(),
      'activeIcon': instance.activeIcon?.toJson(),
      'path': instance.path,
      'backgroundColor': instance.backgroundColor,
    };
