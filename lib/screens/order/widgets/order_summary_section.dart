import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/order/model/order_model.dart';
import '../../../features/order/viewmodel/order_viewmodel.dart';

class OrderSummarySection extends StatelessWidget {
  final Order order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryRow(
                    context,
                    viewModel.formatItemCount(order.items.length),
                    viewModel.formatPrice(order.totalAmount),
                  ),
                  const Divider(),
                  _buildSummaryRow(
                    context,
                    'Total',
                    viewModel.formatPrice(order.totalAmount),
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                isTotal
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value,
            style:
                isTotal
                    ? Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    )
                    : Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
