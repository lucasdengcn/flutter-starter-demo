import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/order/model/order_model.dart';
import '../../features/order/viewmodel/order_viewmodel.dart';
import 'widgets/order_item_card.dart';
import 'widgets/order_status_section.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/shipping_address_section.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    final orderViewModel = context.read<OrderViewModel>();
    Future.microtask(() => orderViewModel.loadOrderDetails(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.loadOrderDetails(widget.orderId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final order = viewModel.selectedOrder;
          if (order == null) {
            return const Center(child: Text('Order not found'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStatusSection(order: order),
                _buildOrderItems(context, order),
                ShippingAddressSection(order: order),
                OrderSummarySection(order: order),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context, Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Order Items',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.items.length,
          itemBuilder: (context, index) {
            final item = order.items[index];
            return OrderItemCard(orderItem: item);
          },
        ),
      ],
    );
  }
}
