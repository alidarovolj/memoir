import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/base_input.dart';
import 'package:memoir/features/messages/data/models/message_model.dart';
import 'package:memoir/features/messages/data/services/websocket_service.dart';
import 'package:memoir/features/messages/data/datasources/messages_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatModal extends StatefulWidget {
  final FriendProfile friend;
  final String currentUserId;

  const ChatModal({
    super.key,
    required this.friend,
    required this.currentUserId,
  });

  @override
  State<ChatModal> createState() => _ChatModalState();
}

class _ChatModalState extends State<ChatModal> {
  final WebSocketService _wsService = WebSocketService();
  final MessagesRemoteDataSource _dataSource = MessagesRemoteDataSource(DioClient());
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<MessageModel> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
    _initializeChat();
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('ru', null);
  }

  Future<void> _initializeChat() async {
    try {
      // Load message history
      final response = await _dataSource.getMessages(widget.friend.id);
      setState(() {
        _messages = response.messages.reversed.toList(); // Reverse to show oldest first
        _isLoading = false;
      });

      // Connect WebSocket
      print('🔌 [Chat] Connecting WebSocket for user ${widget.currentUserId}');
      await _wsService.connect(widget.currentUserId);
      print('✅ [Chat] WebSocket connected: ${_wsService.isConnected}');
      
      // Listen for new messages
      _wsService.messageStream.listen((message) {
        print('📨 [Chat] Received message: ${message.id}');
        print('📨 [Chat] Message sender: ${message.senderId}, receiver: ${message.receiverId}');
        print('📨 [Chat] Current user: ${widget.currentUserId}, friend: ${widget.friend.id}');
        
        // Проверяем, относится ли сообщение к этому чату
        final isFromFriend = message.senderId == widget.friend.id && message.receiverId == widget.currentUserId;
        final isToFriend = message.senderId == widget.currentUserId && message.receiverId == widget.friend.id;
        
        if (isFromFriend || isToFriend) {
          // Проверяем, нет ли уже такого сообщения
          final exists = _messages.any((m) => m.id == message.id);
          if (!exists) {
            print('✅ [Chat] Adding new message to list: ${message.id}');
            setState(() {
              _messages.add(message);
              // Сортируем по времени создания
              _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
            });
            _scrollToBottom();
          } else {
            print('⚠️ [Chat] Message already exists: ${message.id}');
          }
        }
      });
      
      // Listen for events
      _wsService.eventStream.listen((event) {
        print('📡 [Chat] Received event: ${event['type']}');
        if (event['type'] == 'connected') {
          print('✅ [Chat] WebSocket connection confirmed by server');
        } else if (event['type'] == 'message_sent') {
          // Message was sent successfully - перезагружаем историю для синхронизации
          print('✅ [Chat] Message sent confirmation: ${event['message_id']}');
          // Небольшая задержка, чтобы дать время серверу сохранить сообщение
          Future.delayed(const Duration(milliseconds: 200), () {
            _reloadMessages();
          });
        }
      });

      // Scroll to bottom after loading
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки чата: $e')),
        );
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    // Очищаем поле ввода сразу для лучшего UX
    _messageController.clear();

    try {
      print('📤 [Chat] Attempting to send message to ${widget.friend.id}');
      print('📤 [Chat] WebSocket connected: ${_wsService.isConnected}');
      
      // Try WebSocket first
      if (_wsService.isConnected) {
        try {
          await _wsService.sendMessage(widget.friend.id, content);
          print('✅ [Chat] Message sent via WebSocket');
          // Сообщение будет добавлено через WebSocket stream или через reload после подтверждения
          // Не добавляем локально, чтобы избежать дублирования
          return;
        } catch (e) {
          print('⚠️ [Chat] WebSocket send failed, trying REST API: $e');
        }
      }
      
      // Fallback to REST API if WebSocket is not available or failed
      print('📤 [Chat] Sending message via REST API');
      final message = await _dataSource.sendMessage(widget.friend.id, content);
      print('✅ [Chat] Message sent via REST API: ${message.id}');
      
      // Добавляем сообщение в список сразу
      setState(() {
        // Проверяем, нет ли уже такого сообщения
        if (!_messages.any((m) => m.id == message.id)) {
          _messages.add(message);
          // Сортируем по времени создания
          _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
      });
      _scrollToBottom();
    } catch (e) {
      print('❌ [Chat] Error sending message: $e');
      // Возвращаем текст обратно в поле ввода при ошибке
      _messageController.text = content;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка отправки сообщения: $e')),
        );
      }
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  Future<void> _reloadMessages() async {
    try {
      final response = await _dataSource.getMessages(widget.friend.id);
      setState(() {
        // Полностью заменяем список для гарантии синхронизации
        // response.messages отсортированы по убыванию (новые первыми), поэтому разворачиваем
        _messages = response.messages.reversed.toList();
      });
      _scrollToBottom();
    } catch (e) {
      print('❌ [Chat] Error reloading messages: $e');
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Вчера';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE', 'ru').format(dateTime);
    } else {
      return DateFormat('dd.MM.yyyy').format(dateTime);
    }
  }

  @override
  void dispose() {
    _wsService.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
        color: AppTheme.pageBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Ionicons.chevron_back, color: AppTheme.darkColor),
                ),
                const SizedBox(width: 12),
                // Avatar
                ClipOval(
                  child: widget.friend.avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: widget.friend.avatarUrl!.startsWith('/uploads')
                              ? '${ApiConfig.baseUrl}${widget.friend.avatarUrl}'
                              : widget.friend.avatarUrl!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 40,
                            height: 40,
                            color: AppTheme.lightGrayBorder,
                            child: const Icon(Ionicons.person, color: AppTheme.darkColor),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 40,
                            height: 40,
                            color: AppTheme.lightGrayBorder,
                            child: const Icon(Ionicons.person, color: AppTheme.darkColor),
                          ),
                        )
                      : Container(
                          width: 40,
                          height: 40,
                          color: AppTheme.lightGrayBorder,
                          child: const Icon(Ionicons.person, color: AppTheme.darkColor),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.friend.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Messages list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(
                        child: Text(
                          'Начните общение',
                          style: TextStyle(
                            color: AppTheme.darkColor.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final isMe = message.senderId == widget.currentUserId;
                          return _buildMessageBubble(message, isMe);
                        },
                      ),
          ),
          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: BaseInput(
                    controller: _messageController,
                    hint: 'Написать сообщение...',
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _isSending ? null : _sendMessage,
                  icon: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Ionicons.send, color: AppTheme.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.primaryColor : AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? AppTheme.whiteColor : AppTheme.darkColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.createdAt),
              style: TextStyle(
                color: isMe
                    ? AppTheme.whiteColor.withOpacity(0.7)
                    : AppTheme.darkColor.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
