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
      buttonType: json['buttonType'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      className: json['className'],
      height: json['height'],
      width: json['width'],
      maxWidth: json['maxWidth'],
      maxHeight: json['maxHeight'],
      minWidth: json['minWidth'],
      minHeight: json['minHeight'],
      margin: json['margin'],
      padding: json['padding'],
      borderTop: (json['borderTop'] as num?)?.toDouble(),
      borderBottom: (json['borderBottom'] as num?)?.toDouble(),
      borderRight: (json['borderRight'] as num?)?.toDouble(),
      borderLeft: (json['borderLeft'] as num?)?.toDouble(),
      flex: json['flex'] as int?,
      positioned: json['positioned'] as Map<String, dynamic>?,
      fit: json['fit'] as String?,
      radius: (json['radius'] as num?)?.toDouble(),
      iconSize: (json['iconSize'] as num?)?.toDouble(),
      shape: json['shape'] as String?,
      splashColor: json['splashColor'] as String?,
      alignment: json['alignment'],
      elevation: (json['elevation'] as num?)?.toDouble(),
      shadowColor: json['shadowColor'] as String?,
      heightFactor: (json['heightFactor'] as num?)?.toDouble(),
      widthFactor: (json['widthFactor'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      style: json['style'],
      opacity: (json['opacity'] as num?)?.toDouble(),
      enabled: json['enabled'],
      duration: json['duration'] as int?,
      show: json['show'],
      safeArea: json['safeArea'] as bool?,
      sliverListType: json['sliverListType'] as String?,
      itemExtent: (json['itemExtent'] as num?)?.toDouble(),
      componentProps: json['componentProps'] as Map<String, dynamic>?,
      computedComponentProps:
          json['computedComponentProps'] as Map<String, dynamic>?,
      components: (json['components'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k,
            e == null ? null : LayoutProps.fromJson(e as Map<String, dynamic>)),
      ),
      scrollable: json['scrollable'] as bool?,
      drawer: json['drawer'] == null
          ? null
          : T_DrawerProps.fromJson(json['drawer'] as Map<String, dynamic>),
      layoutBuilder: json['layoutBuilder'] == null
          ? null
          : T_LayoutBuilderProps.fromJson(
              json['layoutBuilder'] as Map<String, dynamic>),
      mediaScreenOnly: (json['mediaScreenOnly'] as List<dynamic>?)
          ?.map(
              (e) => T_MediaScreenOnlyProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      onClick: json['onClick'] as String?,
      onLongClick: json['onLongClick'] as String?,
      onDoubleClick: json['onDoubleClick'] as String?,
      onClickDown: json['onClickDown'] as String?,
      onClickUp: json['onClickUp'] as String?,
      onFocus: json['onFocus'] as String?,
      onHover: json['onHover'] as String?,
      textAlign: json['textAlign'] as String?,
      selectable: json['selectable'] as bool?,
      hintText: json['hintText'] as String?,
      labelText: json['labelText'] as String?,
      obscureText: json['obscureText'],
      defaultValue: json['defaultValue'],
      items: json['items'],
      allowClear: json['allowClear'] as bool?,
      fieldType: json['fieldType'] as String?,
      numeric: json['numeric'] as bool?,
      suffixIcon: json['suffixIcon'] == null
          ? null
          : LayoutProps.fromJson(json['suffixIcon'] as Map<String, dynamic>),
      suffixIconColor: json['suffixIconColor'] as String?,
      suffixText: json['suffixText'] as String?,
      prefixIcon: json['prefixIcon'] == null
          ? null
          : LayoutProps.fromJson(json['prefixIcon'] as Map<String, dynamic>),
      prefixIconColor: json['prefixIconColor'] as String?,
      prefixText: json['prefixText'] as String?,
      format: json['format'] as String?,
      fillColor: json['fillColor'] as String?,
      validationFunction: json['validationFunction'] as String?,
      autovalidate: json['autovalidate'] as bool?,
      validators: (json['validators'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      autovalidateMode: json['autovalidateMode'] as String?,
      columns: (json['columns'] as List<dynamic>?)
          ?.map((e) => DataColumnProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => DataRowProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      onSort: json['onSort'] as String?,
      loadDataFunction: json['loadDataFunction'] as String?,
      total: json['total'] as String?,
      onSelectChanged: json['onSelectChanged'] as String?,
      onSelectAll: json['onSelectAll'] as String?,
      selected: json['selected'],
      dividerColor: json['dividerColor'] as String?,
      head: json['head'] == null
          ? null
          : LayoutProps.fromJson(json['head'] as Map<String, dynamic>),
      body: json['body'] == null
          ? null
          : LayoutProps.fromJson(json['body'] as Map<String, dynamic>),
      leading: json['leading'] == null
          ? null
          : LayoutProps.fromJson(json['leading'] as Map<String, dynamic>),
      title: json['title'] == null
          ? null
          : LayoutProps.fromJson(json['title'] as Map<String, dynamic>),
      trailing: json['trailing'] == null
          ? null
          : LayoutProps.fromJson(json['trailing'] as Map<String, dynamic>),
      subtitle: json['subtitle'] == null
          ? null
          : LayoutProps.fromJson(json['subtitle'] as Map<String, dynamic>),
      horizontalTitleGap: (json['horizontalTitleGap'] as num?)?.toDouble(),
      component: json['component'] as String?,
      child: json['child'] == null
          ? null
          : LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : LayoutProps.fromJson(json['content'] as Map<String, dynamic>),
      itemLayout: json['itemLayout'] == null
          ? null
          : LayoutProps.fromJson(json['itemLayout'] as Map<String, dynamic>),
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
      shapeBorder: json['shapeBorder'] == null
          ? null
          : TShapeBorderProps.fromJson(
              json['shapeBorder'] as Map<String, dynamic>),
      boxShadow: json['boxShadow'] == null
          ? null
          : BoxShadowProps.fromJson(json['boxShadow'] as Map<String, dynamic>),
      gradient: json['gradient'] == null
          ? null
          : T_GradientProps.fromJson(json['gradient'] as Map<String, dynamic>),
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
      'buttonType': instance.buttonType,
      'key': instance.key,
      'name': instance.name,
      'className': instance.className,
      'height': instance.height,
      'width': instance.width,
      'maxWidth': instance.maxWidth,
      'maxHeight': instance.maxHeight,
      'minWidth': instance.minWidth,
      'minHeight': instance.minHeight,
      'margin': instance.margin,
      'padding': instance.padding,
      'borderTop': instance.borderTop,
      'borderBottom': instance.borderBottom,
      'borderRight': instance.borderRight,
      'borderLeft': instance.borderLeft,
      'flex': instance.flex,
      'positioned': instance.positioned,
      'fit': instance.fit,
      'radius': instance.radius,
      'iconSize': instance.iconSize,
      'shape': instance.shape,
      'splashColor': instance.splashColor,
      'alignment': instance.alignment,
      'elevation': instance.elevation,
      'shadowColor': instance.shadowColor,
      'heightFactor': instance.heightFactor,
      'widthFactor': instance.widthFactor,
      'weight': instance.weight,
      'style': instance.style,
      'opacity': instance.opacity,
      'enabled': instance.enabled,
      'duration': instance.duration,
      'show': instance.show,
      'safeArea': instance.safeArea,
      'sliverListType': instance.sliverListType,
      'itemExtent': instance.itemExtent,
      'componentProps': instance.componentProps,
      'computedComponentProps': instance.computedComponentProps,
      'components':
          instance.components?.map((k, e) => MapEntry(k, e?.toJson())),
      'scrollable': instance.scrollable,
      'drawer': instance.drawer?.toJson(),
      'layoutBuilder': instance.layoutBuilder?.toJson(),
      'mediaScreenOnly':
          instance.mediaScreenOnly?.map((e) => e.toJson()).toList(),
      'onClick': instance.onClick,
      'onLongClick': instance.onLongClick,
      'onDoubleClick': instance.onDoubleClick,
      'onClickDown': instance.onClickDown,
      'onClickUp': instance.onClickUp,
      'onFocus': instance.onFocus,
      'onHover': instance.onHover,
      'textAlign': instance.textAlign,
      'selectable': instance.selectable,
      'hintText': instance.hintText,
      'labelText': instance.labelText,
      'obscureText': instance.obscureText,
      'defaultValue': instance.defaultValue,
      'items': instance.items,
      'allowClear': instance.allowClear,
      'fieldType': instance.fieldType,
      'numeric': instance.numeric,
      'suffixIcon': instance.suffixIcon?.toJson(),
      'suffixIconColor': instance.suffixIconColor,
      'suffixText': instance.suffixText,
      'prefixIcon': instance.prefixIcon?.toJson(),
      'prefixIconColor': instance.prefixIconColor,
      'prefixText': instance.prefixText,
      'format': instance.format,
      'fillColor': instance.fillColor,
      'validationFunction': instance.validationFunction,
      'autovalidate': instance.autovalidate,
      'validators': instance.validators,
      'autovalidateMode': instance.autovalidateMode,
      'columns': instance.columns?.map((e) => e.toJson()).toList(),
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
      'onSort': instance.onSort,
      'loadDataFunction': instance.loadDataFunction,
      'total': instance.total,
      'onSelectChanged': instance.onSelectChanged,
      'onSelectAll': instance.onSelectAll,
      'selected': instance.selected,
      'dividerColor': instance.dividerColor,
      'head': instance.head?.toJson(),
      'body': instance.body?.toJson(),
      'leading': instance.leading?.toJson(),
      'title': instance.title?.toJson(),
      'trailing': instance.trailing?.toJson(),
      'subtitle': instance.subtitle?.toJson(),
      'horizontalTitleGap': instance.horizontalTitleGap,
      'component': instance.component,
      'child': instance.child?.toJson(),
      'content': instance.content?.toJson(),
      'itemLayout': instance.itemLayout?.toJson(),
      'children': instance.children?.map((e) => e.toJson()).toList(),
      'bottomNav': instance.bottomNav?.toJson(),
      'appBar': instance.appBar?.toJson(),
      'image': instance.image?.toJson(),
      'boxBorder': instance.boxBorder?.toJson(),
      'borderRadius': instance.borderRadius?.toJson(),
      'shapeBorder': instance.shapeBorder?.toJson(),
      'boxShadow': instance.boxShadow?.toJson(),
      'gradient': instance.gradient?.toJson(),
    };
