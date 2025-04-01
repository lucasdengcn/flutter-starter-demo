import 'package:flutter/material.dart';

import '../../../features/order/model/order_model.dart';
import 'order_item_card.dart';

class OrderItemsSection extends StatelessWidget {
  final Order order;

  const OrderItemsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Order Items',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Text(
                '${order.items.length} ${order.items.length == 1 ? "item" : "items"}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.items.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = order.items[index];
            return OrderItemCard(orderItem: item);
          },
        ),
      ],
    );
  }
}
