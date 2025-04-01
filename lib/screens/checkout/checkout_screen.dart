import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/snackbar_service.dart';
import '../../features/checkout/viewmodel/checkout_viewmodel.dart';
import 'widgets/payment_selector.dart';
import 'widgets/shipping_form.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<void> _handleCheckout() async {
    final viewModel = context.read<CheckoutViewModel>();
    final success = await viewModel.submitCheckout();

    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/orders',
        (route) => route.isFirst,
      );
      SnackBarService.showSuccess(context, 'Order placed successfully!');
    } else if (viewModel.errorMessage != null) {
      SnackBarService.showError(context, viewModel.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Consumer<CheckoutViewModel>(
        builder: (context, viewModel, child) {
          if (!viewModel.hasItems) {
            return const Center(child: Text('Your cart is empty'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ShippingForm(),
                const SizedBox(height: 24),
                const PaymentSelector(),
                const SizedBox(height: 24),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _OrderSummary(viewModel: viewModel),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed:
                      context.watch<CheckoutViewModel>().isLoading
                          ? null
                          : _handleCheckout,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child:
                      context.watch<CheckoutViewModel>().isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Place Order'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final CheckoutViewModel viewModel;

  const _OrderSummary({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final subtotal = viewModel.subtotal;
    final tax = viewModel.tax;
    final shippingCost = viewModel.shippingCost;
    final total = viewModel.total;

    return Column(
      children: [
        _SummaryRow(label: 'Subtotal', value: subtotal),
        _SummaryRow(label: 'Shipping', value: shippingCost),
        _SummaryRow(label: 'Tax (10%)', value: tax),
        const Divider(),
        _SummaryRow(label: 'Total', value: total, isTotal: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
