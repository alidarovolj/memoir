import 'package:flutter/material.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/challenges/data/models/challenge_model.dart';
import 'package:memoir/features/challenges/data/datasources/challenge_remote_datasource.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage>
    with SingleTickerProviderStateMixin {
  late ChallengeRemoteDataSource _dataSource;
  late TabController _tabController;

  List<ChallengeModel> _challenges = [];
  List<ChallengeProgressModel> _myParticipations = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _dataSource = ChallengeRemoteDataSourceImpl(dio: DioClient.instance);
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final challenges = await _dataSource.getActiveChallenges();
      final participations = await _dataSource.getMyParticipations();

      setState(() {
        _challenges = challenges;
        _myParticipations = participations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка загрузки: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _joinChallenge(ChallengeModel challenge) async {
    try {
      await _dataSource.joinChallenge(challenge.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вы присоединились к "${challenge.title}"! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
      _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _showLeaderboard(ChallengeModel challenge) async {
    try {
      final leaderboard = await _dataSource.getChallengeLeaderboard(
        challenge.id,
      );
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) =>
            _LeaderboardDialog(challenge: challenge, leaderboard: leaderboard),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки leaderboard: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor, // rgba(28, 27, 32, 1)
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor, // rgba(21, 20, 24, 1)
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const CustomHeader(title: 'Челленджи', type: HeaderType.pop),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    tabs: const [
                      Tab(text: 'Все челленджи'),
                      Tab(text: 'Мои'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadData,
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [_buildAllChallenges(), _buildMyParticipations()],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllChallenges() {
    if (_challenges.isEmpty) {
      return const Center(
        child: Text(
          'Нет активных челленджей',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          final challenge = _challenges[index];
          final isParticipating = _myParticipations.any(
            (p) => p.challengeId == challenge.id,
          );

          return _ChallengeCard(
            challenge: challenge,
            isParticipating: isParticipating,
            onJoin: () => _joinChallenge(challenge),
            onShowLeaderboard: () => _showLeaderboard(challenge),
          );
        },
      ),
    );
  }

  Widget _buildMyParticipations() {
    if (_myParticipations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📋', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text(
              'Вы ещё не участвуете в челленджах',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Присоединитесь к любому челленджу',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _myParticipations.length,
        itemBuilder: (context, index) {
          final participation = _myParticipations[index];
          return _ParticipationCard(participation: participation);
        },
      ),
    );
  }
}

// Challenge Card Widget
class _ChallengeCard extends StatelessWidget {
  final ChallengeModel challenge;
  final bool isParticipating;
  final VoidCallback onJoin;
  final VoidCallback onShowLeaderboard;

  const _ChallengeCard({
    required this.challenge,
    required this.isParticipating,
    required this.onJoin,
    required this.onShowLeaderboard,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = Color.fromRGBO(
      challenge.statusColor[0],
      challenge.statusColor[1],
      challenge.statusColor[2],
      1,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(challenge.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            challenge.daysRemaining != null
                                ? '${challenge.daysRemaining} дней осталось'
                                : challenge.hasEnded
                                ? 'Завершён'
                                : 'Скоро начнётся',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                challenge.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flag, color: Colors.white70, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        challenge.goalDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.people, color: Colors.white54, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '${challenge.participantsCount} участников',
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                  const Spacer(),
                  if (isParticipating)
                    ElevatedButton.icon(
                      onPressed: onShowLeaderboard,
                      icon: const Icon(Icons.leaderboard, size: 18),
                      label: const Text('Рейтинг'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        foregroundColor: Colors.white,
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: challenge.hasEnded ? null : onJoin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: statusColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text('Участвовать'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Participation Card Widget
class _ParticipationCard extends StatelessWidget {
  final ChallengeProgressModel participation;

  const _ParticipationCard({required this.participation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    participation.challengeEmoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      participation.challengeTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (participation.completed)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${participation.progress} / ${participation.target}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    '${participation.percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: participation.percentage / 100,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation(
                    participation.completed ? Colors.green : Colors.blue,
                  ),
                  minHeight: 8,
                ),
              ),
              if (participation.rank != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Ваше место: #${participation.rank}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Leaderboard Dialog
class _LeaderboardDialog extends StatelessWidget {
  final ChallengeModel challenge;
  final ChallengeLeaderboard leaderboard;

  const _LeaderboardDialog({
    required this.challenge,
    required this.leaderboard,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(challenge.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Рейтинг',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: leaderboard.entries.length,
                itemBuilder: (context, index) {
                  final entry = leaderboard.entries[index];
                  final isCurrentUser =
                      leaderboard.userRank != null &&
                      entry.rank == leaderboard.userRank;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrentUser ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: entry.rank <= 3
                                ? (entry.rank == 1
                                      ? Colors.amber
                                      : entry.rank == 2
                                      ? Colors.grey
                                      : Colors.brown)
                                : Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              entry.rank <= 3
                                  ? ['🥇', '🥈', '🥉'][entry.rank - 1]
                                  : '#${entry.rank}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: entry.rank <= 3 ? 16 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.username ??
                                    'Пользователь #${entry.userId.substring(0, 8)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (isCurrentUser)
                                const Text(
                                  'Вы',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${entry.progress}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${entry.percentage.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        if (entry.completed)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
