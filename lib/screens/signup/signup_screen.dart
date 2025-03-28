import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/signup/viewmodels/signup_viewmodel.dart';
import 'completed_step.dart';
import 'name_input_step.dart';
import 'otp_verification_step.dart';
import 'phone_input_step.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (viewModel.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      viewModel.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                _buildCurrentStep(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentStep(BuildContext context, SignupViewModel viewModel) {
    switch (viewModel.currentStep) {
      case SignupStep.phoneInput:
        return const PhoneInputStep();
      case SignupStep.otpVerification:
        return const OTPVerificationStep();
      case SignupStep.nameInput:
        return const NameInputStep();
      case SignupStep.completed:
        return const CompletedStep();
    }
  }
}
