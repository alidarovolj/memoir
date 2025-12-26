import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';

class StoryCircle extends StatelessWidget {
  final String? imageUrl;
  final String username;
  final bool isViewed;
  final int? storiesCount; // Количество историй у пользователя
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    this.imageUrl,
    required this.username,
    this.isViewed = false,
    this.storiesCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 6),
        child: Column(
          children: [
            // Story circle с градиентной обводкой и новым фоном
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.2),
                    Color.fromRGBO(233, 233, 233, 0.2),
                    Color.fromRGBO(242, 242, 242, 0),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(1), // Толщина границы
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(44, 44, 44, 1),
                ),
                child: Container(
                  margin: const EdgeInsets.all(
                    2,
                  ), // Отступ от фона до градиента истории
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
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: ClipOval(
                      child: imageUrl != null && imageUrl!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: imageUrl!,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              placeholder: (context, url) => Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: const Color.fromRGBO(44, 44, 44, 1),
                                child: const Icon(
                                  Ionicons.person,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            )
                          : Container(
                              color: const Color.fromRGBO(44, 44, 44, 1),
                              child: const Icon(
                                Ionicons.person,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Username
            Text(
              username.length > 10
                  ? '${username.substring(0, 10)}...'
                  : username,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: isViewed ? Colors.white70 : Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
