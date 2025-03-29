import 'package:flutter/material.dart';

import '../model/chart_data.dart';

class ChartService {
  // Sample data for demonstration
  Future<ChartDataSet> getChartData() async {
    // In a real app, this would fetch data from an API or database
    return ChartDataSet(
      title: 'Monthly Sales',
      type: 'line',
      data: [
        ChartData(label: 'Jan', value: 1000, color: '#FF4081'),
        ChartData(label: 'Feb', value: 1500, color: '#3F51B5'),
        ChartData(label: 'Mar', value: 1200, color: '#4CAF50'),
        ChartData(label: 'Apr', value: 1800, color: '#FFC107'),
      ],
    );
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
