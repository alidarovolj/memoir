import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileModal extends StatelessWidget {
  final FriendProfile user;
  final bool isFriend;
  final bool isRequestSent;
  final VoidCallback? onSendFriendRequest;
  final String? Function()? formatDate;

  const UserProfileModal({
    super.key,
    required this.user,
    this.isFriend = false,
    this.isRequestSent = false,
    this.onSendFriendRequest,
    this.formatDate,
  });

  static void show(
    BuildContext context, {
    required FriendProfile user,
    bool isFriend = false,
    bool isRequestSent = false,
    VoidCallback? onSendFriendRequest,
    String? Function()? formatDate,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => UserProfileModal(
        user: user,
        isFriend: isFriend,
        isRequestSent: isRequestSent,
        onSendFriendRequest: onSendFriendRequest,
        formatDate: formatDate,
      ),
    );
  }

  String _formatDate(DateTime date) {
    if (formatDate != null) {
      final customFormat = formatDate!();
      if (customFormat != null) return customFormat;
    }

    final months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppTheme.darkColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
              ),
              child: Center(
                child: user.avatarUrl != null
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user.avatarUrl!.startsWith('/uploads')
                              ? '${ApiConfig.baseUrl}${user.avatarUrl}'
                              : user.avatarUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                            ),
                            child: Center(
                              child: Text(
                                user.fullName[0].toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.whiteColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Text(
                            user.fullName[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppTheme.whiteColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        user.fullName[0].toUpperCase(),
                        style: const TextStyle(
                          color: AppTheme.whiteColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Name
            Text(
              user.fullName,
              style: const TextStyle(
                color: AppTheme.darkColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Social networks (if any)
            if (user.telegramUrl != null ||
                user.whatsappUrl != null ||
                user.youtubeUrl != null ||
                user.linkedinUrl != null) ...[
              _buildSocialNetworksRow(user),
              const SizedBox(height: 24),
            ],
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Memories count
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.book_outline,
                        size: 28,
                        color: AppTheme.darkColor.withOpacity(0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user.memoriesCount}',
                        style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'воспоминаний',
                        style: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  width: 1,
                  height: 60,
                  color: AppTheme.darkColor.withOpacity(0.1),
                ),
                // Friends count
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.people_outline,
                        size: 28,
                        color: AppTheme.darkColor.withOpacity(0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user.friendsCount}',
                        style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'друзей',
                        style: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  width: 1,
                  height: 60,
                  color: AppTheme.darkColor.withOpacity(0.1),
                ),
                // Streak days
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.flame_outline,
                        size: 28,
                        color: AppTheme.darkColor.withOpacity(0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user.streakDays}',
                        style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'дней',
                        style: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Created at
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.calendar_outline,
                  size: 16,
                  color: AppTheme.darkColor.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'На платформе с ${_formatDate(user.createdAt)}',
                  style: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Personal data section
            if (user.profession != null ||
                user.city != null ||
                user.dateOfBirth != null ||
                user.education != null ||
                user.hobbies != null ||
                user.aboutMe != null ||
                user.telegramUrl != null ||
                user.whatsappUrl != null ||
                user.youtubeUrl != null ||
                user.linkedinUrl != null) ...[
              Divider(color: AppTheme.darkColor.withOpacity(0.1)),
              const SizedBox(height: 16),
              // Personal info
              if (user.profession != null) ...[
                _buildInfoRow(
                  Ionicons.briefcase_outline,
                  'Профессия',
                  user.profession!,
                ),
                const SizedBox(height: 12),
              ],
              if (user.city != null) ...[
                _buildInfoRow(Ionicons.location_outline, 'Город', user.city!),
                const SizedBox(height: 12),
              ],
              if (user.dateOfBirth != null) ...[
                _buildInfoRow(
                  Ionicons.calendar_outline,
                  'Дата рождения',
                  DateFormat('dd MMMM yyyy', 'ru').format(user.dateOfBirth!),
                ),
                const SizedBox(height: 12),
              ],
              if (user.education != null) ...[
                _buildInfoRow(
                  Ionicons.school_outline,
                  'Образование',
                  user.education!,
                ),
                const SizedBox(height: 12),
              ],
              if (user.hobbies != null) ...[
                _buildInfoRow(Ionicons.heart_outline, 'Хобби', user.hobbies!),
                const SizedBox(height: 12),
              ],
              if (user.aboutMe != null) ...[
                _buildInfoRow(
                  Ionicons.person_outline,
                  'О себе',
                  user.aboutMe!,
                ),
                const SizedBox(height: 12),
              ],
            ],
            const SizedBox(height: 24),
            // Action button
            Builder(
              builder: (context) {
                if (isFriend) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkColor.withOpacity(0.1),
                        foregroundColor: AppTheme.darkColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Вы уже друзья'),
                    ),
                  );
                } else if (isRequestSent) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkColor.withOpacity(0.1),
                        foregroundColor: AppTheme.darkColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Запрос отправлен'),
                    ),
                  );
                } else if (onSendFriendRequest != null) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSendFriendRequest!();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Добавить в друзья'),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.darkColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(color: AppTheme.darkColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialNetworksRow(FriendProfile user) {
    final socialNetworks = <Map<String, String>>[];

    if (user.telegramUrl != null) {
      socialNetworks.add({
        'name': 'Telegram',
        'url': user.telegramUrl!,
        'icon': 'assets/icons/socials/telegram.png',
      });
    }
    if (user.whatsappUrl != null) {
      socialNetworks.add({
        'name': 'WhatsApp',
        'url': user.whatsappUrl!,
        'icon': 'assets/icons/socials/whatsapp.png',
      });
    }
    if (user.youtubeUrl != null) {
      socialNetworks.add({
        'name': 'YouTube',
        'url': user.youtubeUrl!,
        'icon': 'assets/icons/socials/youtube.png',
      });
    }
    if (user.linkedinUrl != null) {
      socialNetworks.add({
        'name': 'LinkedIn',
        'url': user.linkedinUrl!,
        'icon': 'assets/icons/socials/linkedin.png',
      });
    }

    if (socialNetworks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: socialNetworks.asMap().entries.map((entry) {
        final index = entry.key;
        final network = entry.value;
        final isLast = index == socialNetworks.length - 1;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 8),
            child: _buildSocialButton(network['url']!, network['icon']!),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocialButton(String url, String iconPath) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.darkColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Ionicons.link_outline,
                color: AppTheme.darkColor.withOpacity(0.6),
                size: 24,
              );
            },
          ),
        ),
      ),
    );
  }
}
