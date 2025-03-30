import 'package:flutter/material.dart';

import '../model/line_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';
import 'bar_chart_widget.dart';
import 'line_chart_widget.dart';
import 'pie_chart_widget.dart';
import 'radar_chart_widget.dart';
import 'scatter_chart_widget.dart';

class ChartWidgetFactory {
  static Widget createChart({
    required dynamic chartData,
    required ChartViewModel viewModel,
  }) {
    switch (chartData.type.toLowerCase()) {
      case 'line':
        if (chartData is LineChartModel) {
          return LineChartWidget(viewModel: viewModel, model: chartData);
        } else {
          return const Center(child: Text('Invalid chart data for line chart'));
        }
      case 'bar':
        return BarChartWidget(chartData: chartData, viewModel: viewModel);
      case 'pie':
        return PieChartWidget(chartData: chartData, viewModel: viewModel);
      case 'scatter':
        return ScatterChartWidget(chartData: chartData, viewModel: viewModel);
      case 'radar':
        return RadarChartWidget(chartData: chartData, viewModel: viewModel);
      default:
        return const Center(child: Text('Unsupported chart type'));
    }
  }
}
