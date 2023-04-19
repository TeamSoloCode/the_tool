// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bar_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppBarProps _$$_AppBarPropsFromJson(Map<String, dynamic> json) =>
    _$_AppBarProps(
      content: json['content'] == null
          ? null
          : LayoutProps.fromJson(json['content'] as Map<String, dynamic>),
      custom: json['custom'] == null
          ? null
          : LayoutProps.fromJson(json['custom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AppBarPropsToJson(_$_AppBarProps instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
      'custom': instance.custom?.toJson(),
    };
