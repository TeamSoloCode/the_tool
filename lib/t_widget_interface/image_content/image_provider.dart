import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_provider.freezed.dart';
part 'image_provider.g.dart';

@freezed
class ImageProviderProps with _$ImageProviderProps {
  const factory ImageProviderProps({
    String? type,
    Map<String, dynamic>? headers,
    String? url,
    String? asset,
    int? scale,
    String? fit,
  }) = _ImageProviderProps;

  factory ImageProviderProps.fromJson(Map<String, Object?> json) =>
      _$ImageProviderPropsFromJson(json);
}
