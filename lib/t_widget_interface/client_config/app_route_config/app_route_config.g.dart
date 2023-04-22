// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppRouteConfig _$$_AppRouteConfigFromJson(Map<String, dynamic> json) =>
    _$_AppRouteConfig(
      path: json['path'] as String?,
      name: json['name'] as String?,
      route: json['route'] as String?,
      guards: (json['guards'] as List<dynamic>?)
          ?.map((e) => RouteGuardConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AppRouteConfigToJson(_$_AppRouteConfig instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'route': instance.route,
      'guards': instance.guards?.map((e) => e.toJson()).toList(),
    };
