// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_screen_only.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_T_MediaScreenOnlyProps _$$_T_MediaScreenOnlyPropsFromJson(
        Map<String, dynamic> json) =>
    _$_T_MediaScreenOnlyProps(
      maxWidth: json['maxWidth'] as num?,
      minWidth: json['minWidth'] as num?,
      maxHeight: json['maxHeight'] as num?,
      minHeight: json['minHeight'] as num?,
      orientation: json['orientation'] as String?,
      style: json['style'] == null
          ? null
          : LayoutProps.fromJson(json['style'] as Map<String, dynamic>),
      className: json['className'],
    );

Map<String, dynamic> _$$_T_MediaScreenOnlyPropsToJson(
        _$_T_MediaScreenOnlyProps instance) =>
    <String, dynamic>{
      'maxWidth': instance.maxWidth,
      'minWidth': instance.minWidth,
      'maxHeight': instance.maxHeight,
      'minHeight': instance.minHeight,
      'orientation': instance.orientation,
      'style': instance.style?.toJson(),
      'className': instance.className,
    };
