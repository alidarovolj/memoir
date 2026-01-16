import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final _dataSource = FriendsRemoteDataSource(DioClient());
  final _searchController = TextEditingController();
  List<FriendProfile> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final results = await _dataSource.searchUsers(
        query: _searchController.text.trim(),
      );
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка поиска: $e')));
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
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = e.toString();
        String message = 'Ошибка при отправке запроса';
        
        if (errorMessage.contains('already sent')) {
          message = 'Запрос уже отправлен этому пользователю';
        } else if (errorMessage.contains('already friends')) {
          message = 'Вы уже друзья';
        } else if (errorMessage.contains('cannot send to yourself')) {
          message = 'Нельзя отправить запрос самому себе';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
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
            const CustomHeader(title: 'Поиск друзей', type: HeaderType.back),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _searchController,
                style: const TextStyle(color: AppTheme.darkColor),
                decoration: InputDecoration(
                  labelText: 'Поиск друзей',
                  hintText: 'Введите имя или фамилию',
                  hintStyle: TextStyle(
                    color: AppTheme.darkColor.withOpacity(0.3),
                  ),
                  prefixIcon: Icon(
                    Ionicons.search_outline,
                    color: AppTheme.darkColor.withOpacity(0.4),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Ionicons.search),
                    color: AppTheme.primaryColor,
                    onPressed: _searchUsers,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppTheme.darkColor.withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppTheme.darkColor.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: AppTheme.lightGrayColor,
                ),
                onFieldSubmitted: (_) => _searchUsers(),
              ),
            ),

            // Results
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    )
                  : !_hasSearched
                  ? _buildInitialState()
                  : _searchResults.isEmpty
                  ? _buildEmptyResults()
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 90,
                      ),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _searchResults[index];
                        return _buildUserCard(user);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Ionicons.search_circle_outline,
            size: 100,
            color: AppTheme.darkColor.withOpacity(0.2),
          ),
          const SizedBox(height: 24),
          Text(
            'Найдите друзей',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Введите имя или фамилию для поиска',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Ionicons.sad_outline,
            size: 80,
            color: AppTheme.darkColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Ничего не найдено',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить запрос',
            style: TextStyle(
              color: AppTheme.darkColor.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(FriendProfile user) {
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
                  user.fullName[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.whiteColor,
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
                    user.fullName,
                    style: const TextStyle(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.username.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      '@${user.username}',
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
                        '${user.memoriesCount} воспоминаний',
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

            // Add friend button
            ElevatedButton.icon(
              onPressed: () => _sendFriendRequest(user),
              icon: const Icon(Ionicons.person_add, size: 18),
              label: const Text('Добавить'),
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
            ),
          ],
        ),
      ),
    );
  }
}
