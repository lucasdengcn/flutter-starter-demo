import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/error_view.dart';
import '../../features/order/viewmodel/order_viewmodel.dart';
import 'widgets/order_list_item.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<OrderViewModel>();
    Future.microtask(() => viewModel.loadOrders());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final viewModel = context.read<OrderViewModel>();
      if (!viewModel.isLoading && !viewModel.isLastPage) {
        viewModel.loadMoreOrders();
      }
    }
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

          if (viewModel.errorMessage != null) {
            return ErrorView(
              message: viewModel.errorMessage!,
              onRetry: () => viewModel.loadOrders(),
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
                      context.pop();
                    },
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.refreshOrders();
              return;
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount:
                  viewModel.orders.length + (viewModel.isLastPage ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= viewModel.orders.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final order = viewModel.orders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrderListItem(
                    order: order,
                    onTap: () {
                      context.push('/orders/${order.id}');
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
