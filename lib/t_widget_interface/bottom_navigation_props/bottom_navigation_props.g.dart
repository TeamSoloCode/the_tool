// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_navigation_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BottomNavigationProps _$$_BottomNavigationPropsFromJson(
        Map<String, dynamic> json) =>
    _$_BottomNavigationProps(
      selectedItemColor: json['selectedItemColor'] as String?,
      navType: json['navType'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              BottomNavigationItemProps.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BottomNavigationPropsToJson(
        _$_BottomNavigationProps instance) =>
    <String, dynamic>{
      'selectedItemColor': instance.selectedItemColor,
      'navType': instance.navType,
      'backgroundColor': instance.backgroundColor,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };
