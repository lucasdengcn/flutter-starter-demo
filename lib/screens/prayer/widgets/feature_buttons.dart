import 'package:flutter/material.dart';

class FeatureButtons extends StatelessWidget {
  const FeatureButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FeatureButton(
            icon: Icons.book,
            label: 'Dua',
            color: Colors.blue,
            backgroundColor: Colors.blue.withOpacity(0.1),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FeatureButton(
            icon: Icons.calendar_today,
            label: 'Calendar',
            color: Colors.purple,
            backgroundColor: Colors.purple.withOpacity(0.1),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: color, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
