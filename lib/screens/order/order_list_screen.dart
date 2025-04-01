import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/order/viewmodel/order_viewmodel.dart';
import 'widgets/order_list_item.dart';

class OrderListScreen extends StatefulWidget {
  final String userId;

  const OrderListScreen({super.key, required this.userId});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<OrderViewModel>().loadOrders(widget.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.loadOrders(widget.userId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text('No orders yet'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.loadOrders(widget.userId),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.orders.length,
              itemBuilder: (context, index) {
                final order = viewModel.orders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrderListItem(
                    order: order,
                    onTap: () {
                      // TODO: Navigate to order detail screen
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
