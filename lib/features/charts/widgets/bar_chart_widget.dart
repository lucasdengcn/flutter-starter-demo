import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/bar_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';

class BarChartWidget extends StatelessWidget {
  final ChartViewModel viewModel;
  final BarChartModel chartData;

  const BarChartWidget({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.series.isEmpty || chartData.xAxis.isEmpty) {
      return const Center(child: Text('No data available for bar chart'));
    }

    final maxY = chartData.series
        .map(
          (e) =>
              e.data.map((i) => i.toDouble()).reduce((a, b) => a > b ? a : b),
        )
        .reduce((a, b) => a > b ? a : b);
    //
    final barChartGroupData = List.generate(chartData.xAxis.length, (index) {
      final barChartRodData = List.generate(chartData.series.length, (i) {
        return BarChartRodData(
          toY: chartData.series[i].data[index].toDouble(),
          color: Colors.blue.shade300,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        );
      });

      return BarChartGroupData(x: index, barRods: barChartRodData);
    });

    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY * 1.2,
          minY: 0,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: maxY / 5,
            getDrawingHorizontalLine:
                (value) => FlLine(color: Colors.grey.shade200, strokeWidth: 1),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < chartData.xAxis.length) {
                    return Transform.rotate(
                      angle: -0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          chartData.xAxis[value.toInt()],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: null,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toString(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: barChartGroupData,
        ),
      ),
    );
  }
}
