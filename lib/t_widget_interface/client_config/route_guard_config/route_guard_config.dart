import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_guard_config.freezed.dart';
part 'route_guard_config.g.dart';

@Freezed(equal: false, toStringOverride: false)
class RouteGuardConfig with _$RouteGuardConfig {
  const factory RouteGuardConfig({
    String? redirectTo,
    String? authFunction,
  }) = _RouteGuardConfig;

  factory RouteGuardConfig.fromJson(Map<String, Object?> json) =>
      _$RouteGuardConfigFromJson(json);
}
