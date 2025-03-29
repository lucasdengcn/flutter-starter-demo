import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../features/signup/viewmodel/signup_viewmodel.dart';

class PhoneInputStep extends StatelessWidget {
  const PhoneInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignupViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Enter your phone number',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: 'Enter your phone number',
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: viewModel.setPhoneNumber,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed:
              viewModel.phoneNumber.length >= 10 ? viewModel.sendOTP : null,
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
