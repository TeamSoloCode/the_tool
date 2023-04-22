import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/client_config/app_route_config/app_route_config.dart';

part 'client_config.freezed.dart';
part 'client_config.g.dart';

@Freezed(equal: false, toStringOverride: false)
class ClientConfig with _$ClientConfig {
  const factory ClientConfig({
    String? initialPage,
    String? themePath,
    String? pageAPI,
    String? beAPI,
    List<AppRouteConfig>? routes,
    String? notFoundPagePath,
  }) = _ClientConfig;

  factory ClientConfig.fromJson(Map<String, Object?> json) =>
      _$ClientConfigFromJson(json);
}
