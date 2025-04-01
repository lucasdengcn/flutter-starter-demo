import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/checkout/model/checkout_model.dart';
import '../../../features/checkout/viewmodel/checkout_viewmodel.dart';

class PaymentSelector extends StatelessWidget {
  const PaymentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckoutViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<PaymentMethod>(
          value: viewModel.paymentMethod,
          items:
              PaymentMethod.values.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method.toString().split('.').last),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.updatePaymentMethod(value);
            }
          },
        ),
      ],
    );
  }
}
