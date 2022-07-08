// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LayoutProps _$$_LayoutPropsFromJson(Map<String, dynamic> json) =>
    _$_LayoutProps(
      color: json['color'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      text: json['text'] as String?,
      hidden: json['hidden'],
      icon: json['icon'] as String?,
      buttonType: json['buttonType'] as String?,
      mainAxisAlignment: json['mainAxisAlignment'] as String?,
      path: json['path'] as String?,
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => LayoutProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      bottomNav: json['bottomNav'] == null
          ? null
          : BottomNavigationProps.fromJson(
              json['bottomNav'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LayoutPropsToJson(_$_LayoutProps instance) =>
    <String, dynamic>{
      'color': instance.color,
      'backgroundColor': instance.backgroundColor,
      'text': instance.text,
      'hidden': instance.hidden,
      'icon': instance.icon,
      'buttonType': instance.buttonType,
      'mainAxisAlignment': instance.mainAxisAlignment,
      'path': instance.path,
      'child': instance.child,
      'children': instance.children,
      'bottomNav': instance.bottomNav,
    };
