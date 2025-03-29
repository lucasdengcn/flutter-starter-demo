import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? localImagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ImageWidget({
    super.key,
    this.imageUrl,
    this.localImagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : assert(imageUrl != null || localImagePath != null);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder:
            (context, url) =>
                placeholder ?? const Center(child: CircularProgressIndicator()),
        errorWidget:
            (context, url, error) =>
                errorWidget ?? const Center(child: Icon(Icons.error)),
      );
    } else {
      return Image.asset(
        localImagePath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder:
            (context, error, stackTrace) =>
                errorWidget ?? const Center(child: Icon(Icons.error)),
      );
    }
  }
}
