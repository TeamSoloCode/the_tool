import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'client_config.freezed.dart';
part 'client_config.g.dart';

@freezed
class ClientConfig with _$ClientConfig {
  const factory ClientConfig({
    String? initialPage,
    List<Map<String, dynamic>>? routes,
  }) = _ClientConfig;

  factory ClientConfig.fromJson(Map<String, Object?> json) =>
      _$ClientConfigFromJson(json);
}
