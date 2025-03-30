import 'chart_model.dart';

class PieChartModel extends ChartModel {
  PieChartModel({
    required super.title,
    required List<PieSeriesModel> super.series,
    required super.type,
  });

  factory PieChartModel.fromJson(Map<String, dynamic> json) {
    return PieChartModel(
      title: json['title'] as String,
      series:
          (json['series'] as List)
              .map((e) => PieSeriesModel.fromJson(e))
              .toList(),
      type: 'pie',
    );
  }
}

class PieSeriesModel extends SeriesModel {
  PieSeriesModel({required super.name, required List<PieDataItem> super.data});

  factory PieSeriesModel.fromJson(Map<String, dynamic> json) {
    return PieSeriesModel(
      name: json['name'] as String,
      data: (json['data'] as List).map((e) => PieDataItem.fromJson(e)).toList(),
    );
  }
}

class PieDataItem {
  final String name;
  final double value;

  PieDataItem({required this.name, required this.value});

  factory PieDataItem.fromJson(Map<String, dynamic> json) {
    return PieDataItem(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
    );
  }
}
