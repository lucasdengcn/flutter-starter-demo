import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/error_view.dart';
import '../../../features/prayer/model/content_recommendation.dart';
import '../../../features/prayer/viewmodel/prayer_viewmodel.dart';

class ContentRecommendations extends StatelessWidget {
  const ContentRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PrayerViewModel>();
    final recommendations = viewModel.contentRecommendations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'For You',
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
        if (viewModel.state == PrayerViewState.loading)
          const Center(child: CircularProgressIndicator())
        else if (viewModel.state == PrayerViewState.error)
          const ErrorView(
            message: 'Failed to load recommendations',
            onRetry: null,
          )
        else
          ...recommendations.map(
            (content) => Column(
              children: [
                InkWell(
                  onTap: () => viewModel.markContentAsViewed(content.title),
                  child: _buildContentCard(content),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildContentCard(ContentRecommendation content) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              content.imageUrl,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ErrorView(
                  message: 'Failed to load image',
                  onRetry: null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (content.subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    content.subtitle!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
