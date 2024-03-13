// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageProviderPropsImpl _$$ImageProviderPropsImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageProviderPropsImpl(
      type: json['type'] as String?,
      headers: json['headers'] as Map<String, dynamic>?,
      url: json['url'] as String?,
      asset: json['asset'] as String?,
      scale: json['scale'] as int?,
      fit: json['fit'] as String?,
    );

Map<String, dynamic> _$$ImageProviderPropsImplToJson(
        _$ImageProviderPropsImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'headers': instance.headers,
      'url': instance.url,
      'asset': instance.asset,
      'scale': instance.scale,
      'fit': instance.fit,
    };
