import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/line_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';

class LineChartWidget extends StatelessWidget {
  final ChartViewModel viewModel;
  final LineChartModel model;

  const LineChartWidget({
    super.key,
    required this.viewModel,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (model.series.isEmpty) {
      return const Center(child: Text('No data available for line chart'));
    }

    final List<LineChartBarData> lineData = [];

    for (var series in model.series) {
      lineData.add(
        LineChartBarData(
          spots: viewModel.createLineChartData(series),
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      );
    }

    if (lineData.first.spots.isEmpty) {
      return const Center(
        child: Text('No valid data points available for line chart'),
      );
    }

    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        LineChartData(
          minY: 0,
          minX: 0,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 30,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey[400]!, width: 1),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              axisNameWidget: const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Time',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < model.xAxis.length) {
                    return Transform.rotate(
                      angle: -0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          model.xAxis[index],
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
              axisNameWidget: const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Value',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 30,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: lineData,
        ),
      ),
    );
  }
}
