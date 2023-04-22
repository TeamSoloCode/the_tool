import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/client_config/route_guard_config/route_guard_config.dart';

part 'app_route_config.freezed.dart';
part 'app_route_config.g.dart';

@Freezed(equal: false, toStringOverride: false)
class AppRouteConfig with _$AppRouteConfig {
  const factory AppRouteConfig({
    String? path,
    String? name,
    String? route,
    List<RouteGuardConfig>? guards,
  }) = _AppRouteConfig;

  factory AppRouteConfig.fromJson(Map<String, Object?> json) =>
      _$AppRouteConfigFromJson(json);
}
