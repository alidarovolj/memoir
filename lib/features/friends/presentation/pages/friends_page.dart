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
  List<FriendProfile> _sentRequests = []; // Пользователи, которым отправлен запрос
  bool _isLoading = true;
  bool _isLoadingSuggestions = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadFriends();
    await _loadSentRequests(); // Загружаем отправленные запросы перед предложениями
    await _loadSuggestions(); // Всегда загружаем список потенциальных друзей
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

  Future<void> _loadSentRequests() async {
    try {
      print('📤 [FRIENDS] Loading sent friend requests...');
      final sentRequests = await _dataSource.getSentFriendRequests();
      print('📤 [FRIENDS] Loaded ${sentRequests.length} sent requests');
      if (mounted) {
        setState(() {
          // Извлекаем профили пользователей из запросов
          _sentRequests = sentRequests
              .map((request) => request.requester)
              .toList();
        });
        print('📤 [FRIENDS] Updated _sentRequests: ${_sentRequests.length}');
      }
    } catch (e) {
      print('❌ [FRIENDS] Error loading sent requests: $e');
      if (mounted) {
        setState(() {
          _sentRequests = [];
        });
        // Показываем ошибку пользователю
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки отправленных запросов: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _loadSuggestions() async {
    setState(() => _isLoadingSuggestions = true);
    try {
      final result = await _dataSource.getAllUsers(page: 1, pageSize: 20);
      if (mounted) {
        // Исключаем пользователей, которым уже отправлен запрос
        final sentRequestIds = _sentRequests.map((u) => u.id).toSet();
        final allUsers = result['users'] as List<FriendProfile>;
        final filteredUsers = allUsers
            .where((user) => !sentRequestIds.contains(user.id))
            .toList();
        
        setState(() {
          _suggestedUsers = filteredUsers;
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
        // Удаляем пользователя из списка рекомендаций и добавляем в отправленные
        setState(() {
          _suggestedUsers.removeWhere((u) => u.id == user.id);
          if (!_sentRequests.any((u) => u.id == user.id)) {
            _sentRequests.add(user);
          }
        });
        // Перезагружаем отправленные запросы для актуальности
        _loadSentRequests();
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

            // Content with tabs or sections
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    )
                  : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadFriends();
        await _loadSentRequests();
        await _loadSuggestions();
      },
      color: AppTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          // Секция с друзьями (если есть)
          if (_friends.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Мои друзья (${_friends.length})',
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
                    final friend = _friends[index];
                    return _buildFriendCard(friend);
                  },
                  childCount: _friends.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: Divider(
                  color: AppTheme.darkColor.withOpacity(0.1),
                  thickness: 1,
                ),
              ),
            ),
          ],

          // Секция с отправленными запросами
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Отправленные запросы (${_sentRequests.length})',
                style: TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_sentRequests.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = _sentRequests[index];
                    return _buildSentRequestCard(user);
                  },
                  childCount: _sentRequests.length,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.darkColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Нет отправленных запросов',
                    style: TextStyle(
                      color: AppTheme.darkColor.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Divider(
                color: AppTheme.darkColor.withOpacity(0.1),
                thickness: 1,
              ),
            ),
          ),

          // Секция с потенциальными друзьями
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                _friends.isEmpty
                    ? 'Потенциальные друзья'
                    : 'Потенциальные друзья',
                style: TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_isLoadingSuggestions)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor,
                  ),
                ),
              ),
            )
          else if (_suggestedUsers.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.people_outline,
                      size: 64,
                      color: AppTheme.darkColor.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Нет доступных пользователей',
                      style: TextStyle(
                        color: AppTheme.darkColor.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = _suggestedUsers[index];
                    return _buildSuggestionCard(user);
                  },
                  childCount: _suggestedUsers.length,
                ),
              ),
            ),
          // Отступ для таббара
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 90),
          ),
        ],
      ),
    );
  }

  Widget _buildSentRequestCard(FriendProfile user) {
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
                  if (user.username.isNotEmpty) ...[
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
            // Status button (disabled)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppTheme.darkColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Запрос отправлен',
                style: TextStyle(
                  color: AppTheme.darkColor.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
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
                  if (user.username.isNotEmpty) ...[
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
