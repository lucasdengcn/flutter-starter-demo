class ChartModel {
  final String title;
  final List<SeriesModel> series;
  final String type;

  ChartModel({required this.title, required this.series, required this.type});

  factory ChartModel.fromJson(Map<String, dynamic> json, String type) {
    return ChartModel(
      title: json['title'] as String,
      series:
          (json['series'] as List).map((e) => SeriesModel.fromJson(e)).toList(),
      type: type,
    );
  }
}

class SeriesModel {
  final String name;
  final dynamic data;

  SeriesModel({required this.name, required this.data});

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(name: json['name'] as String, data: json['data']);
  }
}
