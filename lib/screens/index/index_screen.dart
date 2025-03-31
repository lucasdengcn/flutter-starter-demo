import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      {'name': 'Sign In', 'route': '/signin'},
      {'name': 'Sign Up', 'route': '/signup'},
      {'name': 'Prayer', 'route': '/prayer'},
      {'name': 'Image Picker', 'route': '/image_picker'},
      {'name': 'Video Player', 'route': '/video_player'},
      {'name': 'Article List', 'route': '/article/list'},
      {'name': 'PDF Viewer', 'route': '/pdf_viewer'},
      {'name': 'Charts', 'route': '/charts'},
      {'name': 'Chat', 'route': '/chat'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('App Navigation'), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3 / 2,
        ),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () => context.go(route['route']!),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_getIconForRoute(route['name']!), size: 32.0),
                    const SizedBox(height: 8.0),
                    Text(
                      route['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForRoute(String routeName) {
    switch (routeName) {
      case 'Sign In':
        return Icons.login;
      case 'Sign Up':
        return Icons.person_add;
      case 'Prayer':
        return Icons.mosque;
      case 'Image Picker':
        return Icons.image;
      case 'Video Player':
        return Icons.play_circle;
      case 'Article List':
        return Icons.article;
      case 'PDF Viewer':
        return Icons.picture_as_pdf;
      case 'Charts':
        return Icons.bar_chart;
      case 'Chat':
        return Icons.chat;
      default:
        return Icons.arrow_forward;
    }
  }
}
