import 'package:flutter/material.dart';

import '../../../core/service/snackbar_service.dart';
import '../../../features/article/model/article_model.dart';

class ArticleActionToolbar extends StatefulWidget {
  final Article article;

  const ArticleActionToolbar({super.key, required this.article});

  @override
  State<ArticleActionToolbar> createState() => _ArticleActionToolbarState();
}

class _ArticleActionToolbarState extends State<ArticleActionToolbar> {
  bool _isLiked = false;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.thumb_up,
            activeIcon: Icons.thumb_up,
            label: 'Like',
            isActive: _isLiked,
            activeColor: Colors.blue,
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
              });
              SnackBarService.showSuccess(
                context,
                _isLiked ? 'Article liked!' : 'Like removed',
              );
            },
          ),
          _buildActionButton(
            icon: Icons.favorite_border,
            activeIcon: Icons.favorite,
            label: 'Favorite',
            isActive: _isFavorited,
            activeColor: Colors.red,
            onPressed: () {
              setState(() {
                _isFavorited = !_isFavorited;
              });
              SnackBarService.showSuccess(
                context,
                _isFavorited ? 'Added to favorites!' : 'Removed from favorites',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey<bool>(isActive),
                color: isActive ? activeColor : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
