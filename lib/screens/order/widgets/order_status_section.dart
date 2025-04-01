import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/order/model/order_model.dart';
import '../../../features/order/viewmodel/order_viewmodel.dart';

class OrderStatusSection extends StatelessWidget {
  final Order order;

  const OrderStatusSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderViewModel>();

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #${order.id}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: viewModel.getStatusColor(order.status),
              ),
              const SizedBox(width: 8),
              Text(
                viewModel.getStatusText(order.status),
                style: TextStyle(
                  color: viewModel.getStatusColor(order.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ordered on ${viewModel.formatDate(order.createdAt)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
