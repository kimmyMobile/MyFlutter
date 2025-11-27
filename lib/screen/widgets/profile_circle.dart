import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  final String? imageUrl;
  final double size;
  const ProfileCircle({
    super.key,
    this.imageUrl,
    this.size = 60,
  });

  /// แปลง URL ให้รองรับ dicebear (SVG -> PNG)
  String? _processImageUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.contains('dicebear.com')) {
      return url.replaceAll('/svg?', '/png?');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final processedUrl = _processImageUrl(imageUrl);
    final placeholder = CircleAvatar(
      radius: size / 2,
      child: const Icon(Icons.person, size: 30, color: Colors.grey),
    );

    if (processedUrl == null ||
        processedUrl.isEmpty ||
        !(processedUrl.startsWith('http://') ||
            processedUrl.startsWith('https://'))) {
      return placeholder;
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: processedUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircleAvatar(
          radius: size / 2,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }
}
