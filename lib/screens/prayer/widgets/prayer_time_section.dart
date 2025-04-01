import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/prayer/viewmodel/prayer_viewmodel.dart';

class PrayerTimeSection extends StatelessWidget {
  const PrayerTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PrayerViewModel>();
    final prayerTimes = viewModel.prayerTimes;
    final nextPrayer = viewModel.nextPrayer;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next Prayer',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  nextPrayer!.name,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                prayerTimes
                    .map((prayer) => _buildPrayerTime(prayer.name, prayer.time))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTime(String name, String time) {
    return Column(
      children: [
        Text(name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
