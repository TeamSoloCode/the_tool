import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route_config.freezed.dart';
part 'app_route_config.g.dart';

@Freezed(equal: false, toStringOverride: false)
class AppRouteConfig with _$AppRouteConfig {
  const factory AppRouteConfig({
    String? path,
    String? name,
    String? route,
  }) = _AppRouteConfig;

  factory AppRouteConfig.fromJson(Map<String, Object?> json) =>
      _$AppRouteConfigFromJson(json);
}
