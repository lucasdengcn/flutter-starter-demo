import 'package:json_annotation/json_annotation.dart';

part 'chart_data.g.dart';

@JsonSerializable()
class ChartData {
  final String label;
  final double value;
  final String? color;

  ChartData({required this.label, required this.value, this.color});

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChartDataToJson(this);
}

@JsonSerializable()
class ChartDataSet {
  final String title;
  final List<ChartData> data;
  final String type; // 'line', 'bar', 'pie'

  ChartDataSet({required this.title, required this.data, required this.type});

  factory ChartDataSet.fromJson(Map<String, dynamic> json) =>
      _$ChartDataSetFromJson(json);
  Map<String, dynamic> toJson() => _$ChartDataSetToJson(this);
}
