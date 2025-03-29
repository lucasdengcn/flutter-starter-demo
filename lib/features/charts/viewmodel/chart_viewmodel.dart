import 'package:flutter/material.dart';

import '../model/chart_data.dart';
import '../service/chart_service.dart';

class ChartViewModel extends ChangeNotifier {
  final ChartService _chartService = ChartService();
  ChartDataSet? _chartData;
  bool _isLoading = false;
  String? _error;

  ChartDataSet? get chartData => _chartData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadChartData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _chartData = await _chartService.getChartData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to get formatted values
  String getFormattedValue(double value) {
    return _chartService.formatValue(value);
  }

  // Helper method to get color from hex string
  Color getColor(String hexColor) {
    return _chartService.getColorFromHex(hexColor);
  }
}
