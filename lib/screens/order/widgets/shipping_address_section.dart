import 'package:flutter/material.dart';

import '../../../features/order/model/order_model.dart';

class ShippingAddressSection extends StatelessWidget {
  final Order order;

  const ShippingAddressSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.shippingAddress.street),
                  const SizedBox(height: 4),
                  Text(
                    '${order.shippingAddress.city}, ${order.shippingAddress.state} ${order.shippingAddress.postalCode}',
                  ),
                  const SizedBox(height: 4),
                  Text(order.shippingAddress.country),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
