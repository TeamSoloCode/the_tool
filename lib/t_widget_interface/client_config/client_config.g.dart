// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClientConfig _$$_ClientConfigFromJson(Map<String, dynamic> json) =>
    _$_ClientConfig(
      initialPage: json['initialPage'] as String?,
      routes: (json['routes'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      themePath: json['themePath'] as String?,
    );

Map<String, dynamic> _$$_ClientConfigToJson(_$_ClientConfig instance) =>
    <String, dynamic>{
      'initialPage': instance.initialPage,
      'routes': instance.routes,
      'themePath': instance.themePath,
    };
