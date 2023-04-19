// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cell_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataCellProps _$$_DataCellPropsFromJson(Map<String, dynamic> json) =>
    _$_DataCellProps(
      child: LayoutProps.fromJson(json['child'] as Map<String, dynamic>),
      placeholder: json['placeholder'] as bool? ?? false,
      showEditIcon: json['showEditIcon'] as bool? ?? false,
      onTap: json['onTap'] as String?,
      onLongPress: json['onLongPress'] as String?,
      onTapDown: json['onTapDown'] as String?,
      onDoubleTap: json['onDoubleTap'] as String?,
      onTapCancel: json['onTapCancel'] as String?,
    );

Map<String, dynamic> _$$_DataCellPropsToJson(_$_DataCellProps instance) =>
    <String, dynamic>{
      'child': instance.child.toJson(),
      'placeholder': instance.placeholder,
      'showEditIcon': instance.showEditIcon,
      'onTap': instance.onTap,
      'onLongPress': instance.onLongPress,
      'onTapDown': instance.onTapDown,
      'onDoubleTap': instance.onDoubleTap,
      'onTapCancel': instance.onTapCancel,
    };
