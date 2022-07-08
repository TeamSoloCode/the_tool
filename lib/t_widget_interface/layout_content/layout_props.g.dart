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
      mainAxisAlignment: json['mainAxisAlignment'] as String?,
      path: json['path'] as String?,
      onClick: json['onClick'] as String?,
      buttonType: json['buttonType'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      items: json['items'],
      fieldType: json['fieldType'] as String?,
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : LayoutProps.fromJson(json['content'] as Map<String, dynamic>),
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
      'mainAxisAlignment': instance.mainAxisAlignment,
      'path': instance.path,
      'onClick': instance.onClick,
      'buttonType': instance.buttonType,
      'key': instance.key,
      'name': instance.name,
      'items': instance.items,
      'fieldType': instance.fieldType,
      'child': instance.child,
      'content': instance.content,
      'children': instance.children,
      'bottomNav': instance.bottomNav,
    };
