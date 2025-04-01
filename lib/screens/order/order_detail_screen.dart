import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/order/viewmodel/order_viewmodel.dart';
import 'widgets/order_items_section.dart';
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

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusSection(order: order),
                    const SizedBox(height: 8),
                    OrderItemsSection(order: order),
                    const SizedBox(height: 8),
                    ShippingAddressSection(order: order),
                    const SizedBox(height: 8),
                    OrderSummarySection(order: order),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
