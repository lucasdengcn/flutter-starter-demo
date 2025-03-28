import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Ibadah',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2196F3),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          color: const Color(0xFF2196F3),
          onPressed: () {},
        ),
      ],
    );
  }
}
