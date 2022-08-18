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
      fontSize: (json['fontSize'] as num?)?.toDouble(),
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
      maxWidth: json['maxWidth'],
      maxHeight: json['maxHeight'],
      minWidth: json['minWidth'],
      minHeight: json['minHeight'],
      margin: json['margin'],
      borderTop: (json['borderTop'] as num?)?.toDouble(),
      borderBottom: (json['borderBottom'] as num?)?.toDouble(),
      borderRight: (json['borderRight'] as num?)?.toDouble(),
      borderLeft: (json['borderLeft'] as num?)?.toDouble(),
      flex: json['flex'] as int?,
      fit: json['fit'] as String?,
      sliverListType: json['sliverListType'] as String?,
      itemExtent: (json['itemExtent'] as num?)?.toDouble(),
      componentProps: json['componentProps'] as Map<String, dynamic>?,
      computedComponentProps:
          json['computedComponentProps'] as Map<String, dynamic>?,
      components: (json['components'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k,
            e == null ? null : LayoutProps.fromJson(e as Map<String, dynamic>)),
      ),
      component: json['component'] as String?,
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
      image: json['image'] == null
          ? null
          : ImageProviderProps.fromJson(json['image'] as Map<String, dynamic>),
      boxBorder: json['boxBorder'] == null
          ? null
          : BorderProps.fromJson(json['boxBorder'] as Map<String, dynamic>),
      borderRadius: json['borderRadius'] == null
          ? null
          : BorderRadiusProps.fromJson(
              json['borderRadius'] as Map<String, dynamic>),
      boxShadow: json['boxShadow'] == null
          ? null
          : BoxShadowProps.fromJson(json['boxShadow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LayoutPropsToJson(_$_LayoutProps instance) =>
    <String, dynamic>{
      'type': instance.type,
      'color': instance.color,
      'backgroundColor': instance.backgroundColor,
      'text': instance.text,
      'fontSize': instance.fontSize,
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
      'maxWidth': instance.maxWidth,
      'maxHeight': instance.maxHeight,
      'minWidth': instance.minWidth,
      'minHeight': instance.minHeight,
      'margin': instance.margin,
      'borderTop': instance.borderTop,
      'borderBottom': instance.borderBottom,
      'borderRight': instance.borderRight,
      'borderLeft': instance.borderLeft,
      'flex': instance.flex,
      'fit': instance.fit,
      'sliverListType': instance.sliverListType,
      'itemExtent': instance.itemExtent,
      'componentProps': instance.componentProps,
      'computedComponentProps': instance.computedComponentProps,
      'components': instance.components,
      'component': instance.component,
      'child': instance.child,
      'content': instance.content,
      'children': instance.children,
      'bottomNav': instance.bottomNav,
      'appBar': instance.appBar,
      'image': instance.image,
      'boxBorder': instance.boxBorder,
      'borderRadius': instance.borderRadius,
      'boxShadow': instance.boxShadow,
    };
