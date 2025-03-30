import 'chart_model.dart';

class LineChartModel extends ChartModel {
  final List<String> xAxis;

  LineChartModel({
    required super.title,
    required super.series,
    required this.xAxis,
    required super.type,
  });

  factory LineChartModel.fromJson(Map<String, dynamic> json) {
    return LineChartModel(
      title: json['title'] as String,
      series:
          (json['series'] as List).map((e) => SeriesModel.fromJson(e)).toList(),
      xAxis: (json['xAxis'] as List).map((e) => e as String).toList(),
      type: 'line',
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
