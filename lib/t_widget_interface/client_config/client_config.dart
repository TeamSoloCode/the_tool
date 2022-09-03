import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_config.freezed.dart';
part 'client_config.g.dart';

@Freezed(equal: false, toStringOverride: false)
class ClientConfig with _$ClientConfig {
  const factory ClientConfig({
    String? initialPage,
    List<Map<String, dynamic>>? routes,
    String? themePath,
    String? pageAPI,
    String? beAPI,
  }) = _ClientConfig;

  factory ClientConfig.fromJson(Map<String, Object?> json) =>
      _$ClientConfigFromJson(json);
}
