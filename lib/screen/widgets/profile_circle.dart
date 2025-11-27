import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  final String? imageUrl;
  const ProfileCircle({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => const CircleAvatar(
                  radius: 30.0,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            errorWidget:
                (context, url, error) => const CircleAvatar(
                  radius: 30.0,
                  child: Icon(Icons.person, size: 30, color: Colors.grey),
                ),
          ),
        )
        : const CircleAvatar(
          radius: 30.0,
          child: Icon(Icons.person, size: 30, color: Colors.grey),
        );
  }
}
