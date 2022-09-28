// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_row_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataRowProps _$$_DataRowPropsFromJson(Map<String, dynamic> json) =>
    _$_DataRowProps(
      selected: json['selected'] as bool? ?? false,
      onSelectChanged: json['onSelectChanged'] as String?,
      onLongPress: json['onLongPress'] as String?,
      color: json['color'] as String?,
      cells: (json['cells'] as List<dynamic>)
          .map((e) => DataCellProps.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DataRowPropsToJson(_$_DataRowProps instance) =>
    <String, dynamic>{
      'selected': instance.selected,
      'onSelectChanged': instance.onSelectChanged,
      'onLongPress': instance.onLongPress,
      'color': instance.color,
      'cells': instance.cells,
    };
