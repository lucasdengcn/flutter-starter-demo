import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../core/service/logger_service.dart';
import '../model/bar_chart_model.dart';
import '../model/line_chart_model.dart';
import '../model/pie_chart_model.dart';
import '../model/radar_chart_model.dart';
import '../model/scatter_chart_model.dart';

class ChartService {
  // Logger service for logging configuration events
  final LoggerService _logger = GetIt.instance<LoggerService>();

  Future<LineChartModel> getLineChartData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/line_chart.json',
      );
      final jsonData = json.decode(jsonString);
      return LineChartModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load line chart data: $e');
    }
  }

  Future<BarChartModel> getBarChartData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/bar_chart.json',
      );
      final jsonData = json.decode(jsonString);
      return BarChartModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load bar chart data: $e');
    }
  }

  Future<PieChartModel> getPieChartData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/pie_chart.json',
      );
      final jsonData = json.decode(jsonString);
      return PieChartModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load pie chart data: $e');
    }
  }

  Future<ScatterChartModel> getScatterChartData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/scatter_chart.json',
      );
      final jsonData = json.decode(jsonString);
      return ScatterChartModel.fromJson(jsonData);
    } catch (e) {
      _logger.e('Failed to load scatter chart data: ', [e, StackTrace.current]);
      throw Exception('Failed to load scatter chart data: $e');
    }
  }

  Future<RadarChartModel> getRadarChartData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/radar_chart.json',
      );
      final jsonData = json.decode(jsonString);
      return RadarChartModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load radar chart data: $e');
    }
  }

  // Convert hex color string to Color object
  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  // Format value for display
  String formatValue(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toString();
  }
}
