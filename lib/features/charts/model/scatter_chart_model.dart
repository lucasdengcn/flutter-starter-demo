import 'chart_model.dart';

class ScatterChartModel extends ChartModel {
  final String xAxis;
  final String yAxis;

  ScatterChartModel({
    required super.title,
    required List<ScatterSeriesModel> super.series,
    required this.xAxis,
    required this.yAxis,
    required super.type,
  });

  factory ScatterChartModel.fromJson(Map<String, dynamic> json) {
    return ScatterChartModel(
      title: json['title'] as String,
      series:
          (json['series'])
              .map<ScatterSeriesModel>((e) => ScatterSeriesModel.fromJson(e))
              .toList(),
      xAxis: (json['xAxis']['name']),
      yAxis: (json['yAxis']['name']),
      type: 'scatter',
    );
  }
}

class ScatterSeriesModel extends SeriesModel {
  ScatterSeriesModel({
    required super.name,
    required List<ScatterDataItem> super.data,
  });

  factory ScatterSeriesModel.fromJson(Map<String, dynamic> json) {
    return ScatterSeriesModel(
      name: json['name'] as String,
      data:
          (json['data'])
              .map<ScatterDataItem>(
                (e) => ScatterDataItem(x: e[0].toDouble(), y: e[1].toDouble()),
              )
              .toList(),
    );
  }
}

class ScatterDataItem {
  final double x;
  final double y;
  final double? size;
  final String? color;

  ScatterDataItem({required this.x, required this.y, this.size, this.color});

  // factory ScatterDataItem.fromJson(Map<String, dynamic> json) {
  //   return ScatterDataItem(
  //     x: (json['x'] as num).toDouble(),
  //     y: (json['y'] as num).toDouble(),
  //     size: json['size'] != null ? (json['size'] as num).toDouble() : null,
  //     color: json['color'] as String?,
  //   );
  // }
}
