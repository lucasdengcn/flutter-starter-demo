import 'chart_model.dart';

class BarChartModel extends ChartModel {
  final List<String> xAxis;

  BarChartModel({
    required super.title,
    required super.series,
    required this.xAxis,
    required super.type,
  });

  factory BarChartModel.fromJson(Map<String, dynamic> json) {
    return BarChartModel(
      title: json['title'] as String,
      series:
          (json['series'] as List).map((e) => SeriesModel.fromJson(e)).toList(),
      xAxis: (json['xAxis'] as List).map((e) => e as String).toList(),
      type: 'bar',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'series': series.map((e) => e).toList(),
      'xAxis': xAxis,
      'type': type,
    };
  }
}
