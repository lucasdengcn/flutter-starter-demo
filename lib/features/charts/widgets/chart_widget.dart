import 'package:flutter/material.dart';

import '../viewmodel/chart_viewmodel.dart';
import 'chart_widget_factory.dart';

class ChartWidget extends StatelessWidget {
  final dynamic chartData;
  final ChartViewModel viewModel;

  const ChartWidget({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData == null) {
      return const Center(child: Text('No chart data available'));
    }
    return ChartWidgetFactory.createChart(
      chartData: chartData,
      viewModel: viewModel,
    );
  }
}
