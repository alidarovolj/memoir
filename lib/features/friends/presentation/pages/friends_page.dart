import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';
import 'package:memoir/features/friends/presentation/pages/friend_requests_page.dart';
import 'package:memoir/features/friends/presentation/pages/user_search_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _dataSource = FriendsRemoteDataSource(DioClient());
  List<FriendProfile> _friends = [];
  List<FriendProfile> _suggestedUsers = [];
  List<FriendProfile> _sentRequests =
      []; // Пользователи, которым отправлен запрос
  bool _isLoading = true;
  bool _isLoadingSuggestions = false;

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
    _initializeData();
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('ru', null);
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
          SnackBar(content: Text(message), backgroundColor: backgroundColor),
        );
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
            ),
          ),
        ],
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
          // Отступ для CustomHeader
          SliverPadding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 64, // SafeArea + высота CustomHeader
            ),
          ),
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final friend = _friends[index];
                  return _buildFriendCard(friend);
                }, childCount: _friends.length),
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final user = _sentRequests[index];
                  return _buildSentRequestCard(user);
                }, childCount: _sentRequests.length),
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final user = _suggestedUsers[index];
                  return _buildSuggestionCard(user);
                }, childCount: _suggestedUsers.length),
              ),
            ),
          // Отступ для таббара
          const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showUserInfoModal(user),
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
                        child: CachedNetworkImage(
                          imageUrl: user.avatarUrl!.startsWith('/uploads')
                              ? '${ApiConfig.baseUrl}${user.avatarUrl}'
                              : user.avatarUrl!,
                          width: 56,
                          height: 56,
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Text(
                            user.fullName[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppTheme.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Status icon
            IconButton(
              icon: Icon(
                Ionicons.time_outline,
                color: AppTheme.darkColor.withOpacity(0.6),
              ),
              onPressed: null,
            ),
          ],
            ),
          ),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showUserInfoModal(user),
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
                        child: CachedNetworkImage(
                          imageUrl: user.avatarUrl!.startsWith('/uploads')
                              ? '${ApiConfig.baseUrl}${user.avatarUrl}'
                              : user.avatarUrl!,
                          width: 56,
                          height: 56,
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Text(
                            user.fullName[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppTheme.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Add icon
            GestureDetector(
              onTap: () => _sendFriendRequest(user),
              child: Icon(
                Ionicons.person_add_outline,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
            ),
          ),
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
          onTap: () => _showUserInfoModal(friend),
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
                    child: friend.avatarUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: friend.avatarUrl!.startsWith('/uploads')
                                  ? '${ApiConfig.baseUrl}${friend.avatarUrl}'
                                  : friend.avatarUrl!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
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
                              errorWidget: (context, url, error) => Text(
                                friend.fullName[0].toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.whiteColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Text(
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  void _showUserInfoModal(FriendProfile user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
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
                _buildInfoRow(Ionicons.briefcase_outline, 'Профессия', user.profession!),
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
                _buildInfoRow(Ionicons.school_outline, 'Образование', user.education!),
                const SizedBox(height: 12),
              ],
              if (user.hobbies != null) ...[
                _buildInfoRow(Ionicons.heart_outline, 'Хобби', user.hobbies!),
                const SizedBox(height: 12),
              ],
              if (user.aboutMe != null) ...[
                _buildInfoRow(Ionicons.person_outline, 'О себе', user.aboutMe!),
                const SizedBox(height: 12),
              ],
            ],
            const SizedBox(height: 24),
            // Action button
            Builder(
              builder: (context) {
                final isFriend = _friends.any((f) => f.id == user.id);
                final isRequestSent = _sentRequests.any((r) => r.id == user.id);
                
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
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _sendFriendRequest(user);
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
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.primaryColor,
        ),
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
                style: const TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 16,
                ),
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
            child: _buildSocialButton(
              network['url']!,
              network['icon']!,
            ),
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
