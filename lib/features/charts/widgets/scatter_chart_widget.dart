import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/scatter_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';

class ScatterChartWidget extends StatelessWidget {
  final ScatterChartModel chartData;
  final ChartViewModel viewModel;

  const ScatterChartWidget({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.series.isEmpty) {
      return const Center(child: Text('No data available for scatter chart'));
    }

    // Calculate max values for axis scaling
    final maxX = chartData.series
        .expand((series) => series.data.map((point) => point.x))
        .reduce((a, b) => a > b ? a : b);
    final maxY = chartData.series
        .expand((series) => series.data.map((point) => point.y))
        .reduce((a, b) => a > b ? a : b);

    final spots =
        chartData.series.expand<ScatterSpot>((series) {
          return (series.data as List<ScatterDataItem>).map<ScatterSpot>((
            point,
          ) {
            return ScatterSpot(
              point.x,
              point.y,
              dotPainter: FlDotCirclePainter(
                radius: point.size ?? 8.0,
                color:
                    point.color != null
                        ? Color(int.parse(point.color!.replaceAll('#', '0xFF')))
                        : Colors.blue,
              ),
            );
          });
        }).toList();

    return AspectRatio(
      aspectRatio: 2,
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: spots,
          minX: 0,
          maxX: maxX * 1.1,
          minY: 0,
          maxY: maxY * 1.1,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: maxX / 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxY / 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            horizontalInterval: maxY / 5,
            verticalInterval: maxX / 5,
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
