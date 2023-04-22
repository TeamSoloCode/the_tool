// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClientConfig _$$_ClientConfigFromJson(Map<String, dynamic> json) =>
    _$_ClientConfig(
      initialPage: json['initialPage'] as String?,
      themePath: json['themePath'] as String?,
      pageAPI: json['pageAPI'] as String?,
      beAPI: json['beAPI'] as String?,
      routes: (json['routes'] as List<dynamic>?)
          ?.map((e) => AppRouteConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      notFoundPagePath: json['notFoundPagePath'] as String?,
    );

Map<String, dynamic> _$$_ClientConfigToJson(_$_ClientConfig instance) =>
    <String, dynamic>{
      'initialPage': instance.initialPage,
      'themePath': instance.themePath,
      'pageAPI': instance.pageAPI,
      'beAPI': instance.beAPI,
      'routes': instance.routes?.map((e) => e.toJson()).toList(),
      'notFoundPagePath': instance.notFoundPagePath,
    };
