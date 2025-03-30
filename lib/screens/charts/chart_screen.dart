import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/error_view.dart';
import '../../features/charts/viewmodel/chart_viewmodel.dart';
import '../../features/charts/widgets/chart_widget.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Charts Demo'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (type) {
                  viewModel.loadChartData(chartType: type);
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'line',
                        child: Text('Line Chart'),
                      ),
                      const PopupMenuItem(
                        value: 'bar',
                        child: Text('Bar Chart'),
                      ),
                      const PopupMenuItem(
                        value: 'pie',
                        child: Text('Pie Chart'),
                      ),
                      const PopupMenuItem(
                        value: 'scatter',
                        child: Text('Scatter Chart'),
                      ),
                      const PopupMenuItem(
                        value: 'radar',
                        child: Text('Radar Chart'),
                      ),
                    ],
                icon: const Icon(Icons.add_chart),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh:
                () => viewModel.loadChartData(
                  chartType: viewModel.currentChartType,
                ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.errorMessage.isNotEmpty
                      ? ErrorView(
                        message: viewModel.errorMessage,
                        onRetry:
                            () => viewModel.loadChartData(
                              chartType: viewModel.currentChartType,
                            ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.title,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: ChartWidget(
                                key: ValueKey(viewModel.currentChartType),
                                chartData: viewModel.chartData,
                                viewModel: viewModel,
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }
}
