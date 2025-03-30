import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:insurance_ws/core/viewmodel/base_viewmodel.dart';
import 'package:insurance_ws/features/charts/model/chart_model.dart';

import '../model/bar_chart_model.dart';
import '../service/chart_service.dart';

class ChartViewModel extends BaseViewModel {
  final ChartService _chartService;
  String _currentChartType = 'line';
  bool _isLoading = false;
  dynamic _chartData;
  String _errorMessage = '';

  String _title = '';
  String get title => _title;

  ChartViewModel({required ChartService chartService})
    : _chartService = chartService;

  String get currentChartType => _currentChartType;
  @override
  bool get isLoading => _isLoading;
  dynamic get chartData => _chartData;
  @override
  String get errorMessage => _errorMessage;

  Future<void> loadChartData({String chartType = 'line'}) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      _currentChartType = chartType;
      notifyListeners();

      switch (chartType) {
        case 'line':
          _chartData = await _chartService.getLineChartData();
          _title = _chartData.title;
          break;
        case 'bar':
          _chartData = await _chartService.getBarChartData();
          _title = _chartData.title;
          break;
        case 'pie':
          _chartData = await _chartService.getPieChartData();
          _title = _chartData.title;
          break;
        case 'scatter':
          _chartData = await _chartService.getScatterChartData();
          _title = _chartData.title;
          break;
        case 'radar':
          _chartData = await _chartService.getRadarChartData();
          _title = _chartData.title;
          break;
        default:
          throw Exception('Unsupported chart type: $chartType');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<FlSpot> createLineChartData(SeriesModel series) {
    if (series.data.isEmpty) return [];
    final List<dynamic> data = series.data;

    return List.generate(
      data.length,
      (i) => FlSpot(i.toDouble(), data[i].toDouble()),
    );
  }

  List<BarChartGroupData> createBarChartData(BarChartModel model) {
    if (model.series.isEmpty || model.xAxis.isEmpty) return [];

    return List.generate(
      model.xAxis.length,
      (i) => BarChartGroupData(
        x: i,
        barRods:
            model.series.map((series) {
              return BarChartRodData(
                toY: series.data[i].toDouble(),
                color: Colors.blue,
              );
            }).toList(),
      ),
    );
  }
}
