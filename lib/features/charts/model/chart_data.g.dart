// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartData _$ChartDataFromJson(Map<String, dynamic> json) => ChartData(
  label: json['label'] as String,
  value: (json['value'] as num).toDouble(),
  color: json['color'] as String?,
);

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
  'label': instance.label,
  'value': instance.value,
  'color': instance.color,
};

ChartDataSet _$ChartDataSetFromJson(Map<String, dynamic> json) => ChartDataSet(
  title: json['title'] as String,
  data:
      (json['data'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
  type: json['type'] as String,
);

Map<String, dynamic> _$ChartDataSetToJson(ChartDataSet instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
      'type': instance.type,
    };
