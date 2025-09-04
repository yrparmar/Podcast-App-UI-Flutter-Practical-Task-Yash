import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final double borderRadius;
  final double? width;
  final double? height;
  final String assetPath;

  const CoverImage({
    super.key,
    this.borderRadius = 16,
    this.width,
    this.height,
    this.assetPath = 'assets/images/producast_image_1.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          );
        },
      ),
    );
  }
}


