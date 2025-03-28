import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompletedStep extends StatelessWidget {
  const CompletedStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        const Text(
          'Registration Completed!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your account has been created successfully.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            context.go('/prayer');
          },
          child: const Text('Continue to App'),
        ),
      ],
    );
  }
}
