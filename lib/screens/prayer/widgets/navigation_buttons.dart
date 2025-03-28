import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NavigationButton(
            icon: Icons.location_on,
            label: 'Mosque',
            color: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.1),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: NavigationButton(
            icon: Icons.explore,
            label: 'Qibla',
            color: Colors.amber,
            backgroundColor: Colors.amber.withOpacity(0.1),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const NavigationButton({
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
