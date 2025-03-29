import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/bottom_nav_bar.dart';
import '../../core/widgets/top_app_bar.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import 'widgets/content_recommendations.dart';
import 'widgets/feature_buttons.dart';
import 'widgets/ibadah_guide.dart';
import 'widgets/inspiration_quote.dart';
import 'widgets/location_toggle.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/prayer_time_section.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopAppBar(),
                    const SizedBox(height: 16),
                    const LocationToggle(
                      location: 'Kedah',
                      toggleText: 'Prayer',
                    ),
                    const SizedBox(height: 16),
                    const PrayerTimeSection(),
                    const SizedBox(height: 16),
                    const NavigationButtons(),
                    const SizedBox(height: 16),
                    const FeatureButtons(),
                    const SizedBox(height: 24),
                    const InspirationQuote(
                      quote:
                          'And it is He who created the night and day, and the sun and moon; all in an orbit are swimming.',
                      source: 'Quran 21:33',
                    ),
                    const SizedBox(height: 24),
                    const IbadahGuideSection(),
                    const SizedBox(height: 16),
                    const ContentRecommendations(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
