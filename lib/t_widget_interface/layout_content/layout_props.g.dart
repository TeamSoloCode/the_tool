// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LayoutProps _$$_LayoutPropsFromJson(Map<String, dynamic> json) =>
    _$_LayoutProps(
      type: json['type'] as String?,
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
      className: json['className'],
      height: json['height'],
      width: json['width'],
      maxWith: json['maxWith'],
      maxHeight: json['maxHeight'],
      minWith: json['minWith'],
      minHeight: json['minHeight'],
      flex: json['flex'] as int?,
      componentProps: json['componentProps'] as Map<String, dynamic>?,
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
      appBar: json['appBar'] == null
          ? null
          : AppBarProps.fromJson(json['appBar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LayoutPropsToJson(_$_LayoutProps instance) =>
    <String, dynamic>{
      'type': instance.type,
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
      'className': instance.className,
      'height': instance.height,
      'width': instance.width,
      'maxWith': instance.maxWith,
      'maxHeight': instance.maxHeight,
      'minWith': instance.minWith,
      'minHeight': instance.minHeight,
      'flex': instance.flex,
      'componentProps': instance.componentProps,
      'child': instance.child,
      'content': instance.content,
      'children': instance.children,
      'bottomNav': instance.bottomNav,
      'appBar': instance.appBar,
    };
