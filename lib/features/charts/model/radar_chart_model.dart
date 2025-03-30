import 'chart_model.dart';

class RadarChartModel extends ChartModel {
  final List<RadarIndicator> indicators;

  RadarChartModel({
    required super.title,
    required super.series,
    required this.indicators,
    required super.type,
  });

  factory RadarChartModel.fromJson(Map<String, dynamic> json) {
    return RadarChartModel(
      title: json['title'] as String,
      series:
          (json['series'] as List).map((e) => SeriesModel.fromJson(e)).toList(),
      indicators:
          (json['indicator'] as List)
              .map((e) => RadarIndicator.fromJson(e))
              .toList(),
      type: 'radar',
    );
  }
}

class RadarIndicator {
  final String name;
  final double max;

  RadarIndicator({required this.name, required this.max});

  factory RadarIndicator.fromJson(Map<String, dynamic> json) {
    return RadarIndicator(
      name: json['name'] as String,
      max: (json['max'] as num).toDouble(),
    );
  }
}
