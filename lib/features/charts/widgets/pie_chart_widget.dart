import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/pie_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';

class PieChartWidget extends StatelessWidget {
  final PieChartModel chartData;
  final ChartViewModel viewModel;

  const PieChartWidget({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.series.isEmpty) {
      return const Center(child: Text('No data available for pie chart'));
    }

    final series = chartData.series.first;
    if (series.data.isEmpty) {
      return const Center(
        child: Text('No data points available for pie chart'),
      );
    }

    final List<PieChartSectionData> sections = [];
    double totalValue = 0;

    // Calculate total value for percentage
    for (var item in series.data) {
      totalValue += (item as PieDataItem).value;
    }

    if (totalValue <= 0) {
      return const Center(
        child: Text('Invalid data: total value must be greater than 0'),
      );
    }

    // Create pie sections
    for (var i = 0; i < series.data.length; i++) {
      final item = series.data[i] as PieDataItem;
      final percentage = (item.value / totalValue) * 100;

      sections.add(
        PieChartSectionData(
          color: Colors.primaries[i % Colors.primaries.length],
          value: item.value,
          title: '${item.name}\n${percentage.toStringAsFixed(1)}%',
          radius: 100,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 2,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          startDegreeOffset: -90,
        ),
      ),
    );
  }
}
