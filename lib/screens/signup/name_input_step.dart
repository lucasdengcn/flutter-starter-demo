import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/signup/viewmodels/signup_viewmodel.dart';

class NameInputStep extends StatelessWidget {
  const NameInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignupViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'What\'s your name?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            border: OutlineInputBorder(),
          ),
          onChanged: viewModel.setName,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed:
              viewModel.name.isNotEmpty ? viewModel.completeSignup : null,
          child: const Text('Complete Signup'),
        ),
      ],
    );
  }
}
