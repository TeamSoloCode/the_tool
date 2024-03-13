// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppRouteConfigImpl _$$AppRouteConfigImplFromJson(Map<String, dynamic> json) =>
    _$AppRouteConfigImpl(
      path: json['path'] as String?,
      name: json['name'] as String?,
      route: json['route'] as String?,
      guards: (json['guards'] as List<dynamic>?)
          ?.map((e) => RouteGuardConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppRouteConfigImplToJson(
        _$AppRouteConfigImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'route': instance.route,
      'guards': instance.guards?.map((e) => e.toJson()).toList(),
    };
