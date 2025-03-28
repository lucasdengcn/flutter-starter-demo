import 'package:flutter/material.dart';

class IbadahGuideSection extends StatelessWidget {
  const IbadahGuideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ibadah Guide',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildGuideCard(
                title: 'How to Perform Wudu',
                description: 'Learn the proper steps of performing ablution',
                icon: Icons.water_drop,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildGuideCard(
                title: 'Prayer Times Guide',
                description: 'Understanding prayer times calculation',
                icon: Icons.access_time,
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              _buildGuideCard(
                title: 'Dua Collection',
                description: 'Essential duas for daily life',
                icon: Icons.book,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuideCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
