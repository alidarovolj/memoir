import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memoir/core/config/api_config.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  final _dataSource = FriendsRemoteDataSource(DioClient());
  List<FriendRequest> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() => _isLoading = true);
    try {
      final requests = await _dataSource.getFriendRequests();
      if (mounted) {
        setState(() {
          _requests = requests;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка загрузки запросов: $e')));
      }
    }
  }

  Future<void> _respondToRequest(String requestId, String action) async {
    try {
      await _dataSource.respondToFriendRequest(
        requestId: requestId,
        action: action,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              action == 'accept' ? 'Запрос принят' : 'Запрос отклонён',
            ),
          ),
        );
        _loadRequests();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Stack(
        children: [
          // Body content - весь контент на весь экран
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                )
              : _buildContent(),
          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(
                title: 'Запросы в друзья',
                type: HeaderType.back,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: _loadRequests,
      color: AppTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          // Отступ для CustomHeader
          SliverPadding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  64, // SafeArea + высота CustomHeader
            ),
          ),
          // Секция с запросами
          if (_requests.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Новые запросы (${_requests.length})',
                  style: TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final request = _requests[index];
                    return _buildRequestCard(request);
                  },
                  childCount: _requests.length,
                ),
              ),
            ),
          ] else
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildEmptyState(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Ionicons.mail_open_outline,
            size: 80,
            color: AppTheme.darkColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Нет новых запросов',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Здесь появятся запросы в друзья',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(FriendRequest request) {
    // Получаем URL аватара
    String? avatarUrl = request.requester.avatarUrl;
    if (avatarUrl != null && avatarUrl.startsWith('/uploads')) {
      avatarUrl = '${ApiConfig.baseUrl}$avatarUrl';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor, // Светлая карточка
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.greenButtonColor, // Зеленый фон
                  ),
                  child: avatarUrl != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: avatarUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Text(
                                request.requester.username[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Text(
                                request.requester.username[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            request.requester.username[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 16),

                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.requester.username,
                        style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(request.createdAt),
                        style: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _respondToRequest(request.id, 'accept'),
                    icon: const Icon(Ionicons.checkmark, size: 20),
                    label: const Text('Принять'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.greenButtonColor, // Ярко-зеленая кнопка
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _respondToRequest(request.id, 'reject'),
                    icon: const Icon(Ionicons.close, size: 20),
                    label: const Text('Отклонить'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightGrayBorder, // Светло-серая кнопка
                      foregroundColor: AppTheme.darkColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} дн. назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ч. назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} мин. назад';
    } else {
      return 'Только что';
    }
  }
}
