// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientConfigImpl _$$ClientConfigImplFromJson(Map<String, dynamic> json) =>
    _$ClientConfigImpl(
      initialPage: json['initialPage'] as String?,
      pageAPI: json['pageAPI'] as String?,
      beAPI: json['beAPI'] as String?,
      routes: (json['routes'] as List<dynamic>?)
          ?.map((e) => AppRouteConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      notFoundPagePath: json['notFoundPagePath'] as String?,
      uploadFileHost: json['uploadFileHost'] as String?,
      socketioHost: json['socketioHost'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ClientConfigImplToJson(_$ClientConfigImpl instance) =>
    <String, dynamic>{
      'initialPage': instance.initialPage,
      'pageAPI': instance.pageAPI,
      'beAPI': instance.beAPI,
      'routes': instance.routes?.map((e) => e.toJson()).toList(),
      'notFoundPagePath': instance.notFoundPagePath,
      'uploadFileHost': instance.uploadFileHost,
      'socketioHost': instance.socketioHost,
    };
