import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/radar_chart_model.dart';
import '../viewmodel/chart_viewmodel.dart';

class RadarChartWidget extends StatelessWidget {
  final RadarChartModel chartData;
  final ChartViewModel viewModel;

  const RadarChartWidget({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.series.isEmpty || chartData.indicators.isEmpty) {
      return const Center(child: Text('No data available for radar chart'));
    }

    // Validate data points count matches indicators count
    for (var series in chartData.series) {
      if ((series.data as List).length != chartData.indicators.length) {
        return const Center(
          child: Text('Data points count does not match indicators count'),
        );
      }
    }

    // Find max value for scaling
    final maxValue =
        chartData.series
            .expand((series) => (series.data as List).map((e) => e as num))
            .reduce((a, b) => a > b ? a : b)
            .toDouble();

    // Scale data
    final scaledData =
        chartData.series.map((series) {
          return RadarDataSet(
            dataEntries:
                (series.data as List)
                    .map(
                      (value) => RadarEntry(value: value.toDouble() / maxValue),
                    )
                    .toList(),
          );
        }).toList();
    // Scale data
    return AspectRatio(
      aspectRatio: 2,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          radarBorderData: BorderSide(color: Colors.grey.shade300),
          ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10),
          tickBorderData: BorderSide(color: Colors.grey.shade300),
          gridBorderData: BorderSide(color: Colors.grey.shade200, width: 2),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
          titlePositionPercentageOffset: 0.2,
          dataSets: scaledData,
          radarBackgroundColor: Colors.transparent,
          tickCount: 5,
          getTitle: (index, angle) {
            return RadarChartTitle(
              text: chartData.indicators[index].name,
              angle: angle,
              positionPercentageOffset: 0.1,
            );
          },
        ),
      ),
    );
  }
}
