import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/checkout/viewmodel/checkout_viewmodel.dart';

class ShippingForm extends StatelessWidget {
  const ShippingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckoutViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Full Name',
          value: viewModel.fullName,
          onChanged: (value) => viewModel.updateField('fullName', value),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          label: 'Address',
          value: viewModel.address,
          onChanged: (value) => viewModel.updateField('address', value),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          label: 'City',
          value: viewModel.city,
          onChanged: (value) => viewModel.updateField('city', value),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          label: 'State',
          value: viewModel.state,
          onChanged: (value) => viewModel.updateField('state', value),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          label: 'ZIP Code',
          value: viewModel.postalCode,
          onChanged: (value) => viewModel.updateField('postalCode', value),
        ),
        const SizedBox(height: 8),
        _buildTextField(
          label: 'Phone',
          value: viewModel.phone,
          onChanged: (value) => viewModel.updateField('phone', value),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: value,
      onChanged: onChanged,
    );
  }
}
