import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../features/signup/viewmodel/signup_viewmodel.dart';

class OTPVerificationStep extends StatelessWidget {
  const OTPVerificationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignupViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Enter the 6-digit code sent to ${viewModel.phoneNumber}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'OTP Code',
            hintText: 'Enter 6-digit code',
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          onChanged: viewModel.setOTP,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: viewModel.otp.length == 6 ? viewModel.verifyOTP : null,
          child: const Text('Verify'),
        ),
      ],
    );
  }
}
