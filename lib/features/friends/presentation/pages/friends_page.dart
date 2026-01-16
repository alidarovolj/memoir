import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';
import 'package:memoir/features/friends/presentation/pages/friend_requests_page.dart';
import 'package:memoir/features/friends/presentation/pages/user_search_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _dataSource = FriendsRemoteDataSource(DioClient());
  List<FriendProfile> _friends = [];
  List<FriendProfile> _suggestedUsers = [];
  bool _isLoading = true;
  bool _isLoadingSuggestions = false;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    setState(() => _isLoading = true);
    try {
      final friends = await _dataSource.getFriends();
      if (mounted) {
        setState(() {
          _friends = friends;
          _isLoading = false;
        });
        // Если друзей нет, загружаем рекомендации
        if (_friends.isEmpty) {
          _loadSuggestions();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка загрузки друзей: $e')));
      }
    }
  }

  Future<void> _loadSuggestions() async {
    setState(() => _isLoadingSuggestions = true);
    try {
      final suggestions = await _dataSource.getSuggestedUsers(limit: 10);
      if (mounted) {
        setState(() {
          _suggestedUsers = suggestions;
          _isLoadingSuggestions = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSuggestions = false);
      }
    }
  }

  Future<void> _sendFriendRequest(FriendProfile user) async {
    try {
      await _dataSource.sendFriendRequest(user.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Запрос отправлен пользователю ${user.fullName}'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        // Удаляем пользователя из списка рекомендаций
        setState(() {
          _suggestedUsers.removeWhere((u) => u.id == user.id);
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = e.toString();
        String message = 'Ошибка при отправке запроса';
        Color backgroundColor = Colors.red;
        
        if (errorMessage.contains('already sent')) {
          message = 'Запрос уже отправлен этому пользователю';
          backgroundColor = Colors.orange;
          // Удаляем из рекомендаций, т.к. запрос уже есть
          setState(() {
            _suggestedUsers.removeWhere((u) => u.id == user.id);
          });
        } else if (errorMessage.contains('already friends')) {
          message = 'Вы уже друзья';
          backgroundColor = Colors.orange;
        } else if (errorMessage.contains('cannot send to yourself')) {
          message = 'Нельзя отправить запрос самому себе';
          backgroundColor = Colors.orange;
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: backgroundColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            CustomHeader(
              title: 'Друзья',
              type: HeaderType.none,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search button
                  IconButton(
                    icon: const Icon(Ionicons.search_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserSearchPage(),
                        ),
                      ).then((_) => _loadFriends());
                    },
                  ),
                  // Friend requests button
                  IconButton(
                    icon: const Icon(Ionicons.person_add_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FriendRequestsPage(),
                        ),
                      ).then((_) => _loadFriends());
                    },
                  ),
                ],
              ),
            ),

            // Friends list
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    )
                  : _friends.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      onRefresh: _loadFriends,
                      color: AppTheme.primaryColor,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _friends.length,
                        itemBuilder: (context, index) {
                          final friend = _friends[index];
                          return _buildFriendCard(friend);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    if (_isLoadingSuggestions) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
      );
    }

    if (_suggestedUsers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Ionicons.people_outline,
              size: 80,
              color: AppTheme.darkColor.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'У вас пока нет друзей',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.7),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Найдите друзей через поиск',
              style: TextStyle(
                color: AppTheme.darkColor.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserSearchPage(),
                  ),
                ).then((_) => _loadFriends());
              },
              icon: const Icon(Ionicons.search, color: AppTheme.whiteColor),
              label: const Text(
                'Найти друзей',
                style: TextStyle(color: AppTheme.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Показываем рекомендации
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Рекомендуемые пользователи',
          style: TextStyle(
            color: AppTheme.darkColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Добавьте их в друзья',
          style: TextStyle(
            color: AppTheme.darkColor.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ..._suggestedUsers.map((user) => _buildSuggestionCard(user)),
        const SizedBox(height: 90), // Отступ для таббара
      ],
    );
  }

  Widget _buildSuggestionCard(FriendProfile user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
              ),
              child: Center(
                child: user.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          user.avatarUrl!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                              user.fullName[0].toUpperCase(),
                              style: const TextStyle(
                                color: AppTheme.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      )
                    : Text(
                        user.fullName[0].toUpperCase(),
                        style: const TextStyle(
                          color: AppTheme.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (user.username != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        color: AppTheme.darkColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Add button
            ElevatedButton(
              onPressed: () => _sendFriendRequest(user),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.whiteColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard(FriendProfile friend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: AppTheme.darkColor.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showFriendOptions(friend),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      friend.fullName[0].toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Friend info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.fullName,
                        style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (friend.username.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          '@${friend.username}',
                          style: TextStyle(
                            color: AppTheme.darkColor.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Ionicons.book_outline,
                            size: 14,
                            color: AppTheme.darkColor.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${friend.memoriesCount} воспоминаний',
                            style: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Ionicons.flame_outline,
                            size: 14,
                            color: AppTheme.darkColor.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${friend.streakDays} дней',
                            style: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Options button
                IconButton(
                  icon: Icon(
                    Ionicons.ellipsis_vertical,
                    color: AppTheme.darkColor.withOpacity(0.6),
                  ),
                  onPressed: () => _showFriendOptions(friend),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFriendOptions(FriendProfile friend) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Friend info
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      friend.fullName[0].toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  friend.fullName,
                  style: const TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: AppTheme.darkColor.withOpacity(0.1)),
            const SizedBox(height: 12),

            // Remove friend button
            ListTile(
              leading: const Icon(
                Ionicons.person_remove_outline,
                color: Colors.red,
              ),
              title: const Text(
                'Удалить из друзей',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmRemoveFriend(friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemoveFriend(FriendProfile friend) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Удалить друга?',
          style: TextStyle(color: AppTheme.darkColor),
        ),
        content: Text(
          'Вы уверены, что хотите удалить ${friend.fullName} из друзей?',
          style: TextStyle(color: AppTheme.darkColor.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Отмена',
              style: TextStyle(color: AppTheme.darkColor.withOpacity(0.7)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await _dataSource.removeFriend(friend.id);
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Друг удалён')));
                  _loadFriends();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
                }
              }
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
