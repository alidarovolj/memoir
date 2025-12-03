import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';

class StoryCircle extends StatelessWidget {
  final String? imageUrl;
  final String username;
  final bool isViewed;
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    this.imageUrl,
    required this.username,
    this.isViewed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            // Story circle с градиентной обводкой
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isViewed
                    ? LinearGradient(
                        colors: [
                          Colors.grey.shade400,
                          Colors.grey.shade300,
                        ],
                      )
                    : AppTheme.primaryGradient,
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          width: 64,
                          height: 64,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                            ),
                            child: const Icon(
                              Ionicons.person,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                          ),
                          child: const Icon(
                            Ionicons.person,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Username
            Text(
              username.length > 10 ? '${username.substring(0, 10)}...' : username,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

