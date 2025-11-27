import 'package:flutter/material.dart';
import 'package:flutter_app_test1/helpers/local_storage_service.dart';
import 'package:flutter_app_test1/model/message_model.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  const ChatPage({super.key, required this.conversationId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final dudee = DudeeService();
  final TextEditingController _messageController = TextEditingController();

  List<Item> _messages = [];
  Map<String, dynamic> _currentUserInfo = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadCurrentUserInfo().then((_) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      final messageResponse = await dudee.getMessages(int.parse(widget.conversationId));
      if (messageResponse.data != null && messageResponse.data!.items != null) {
        final items = messageResponse.data!.items!;
        items.sort((a, b) {
          return (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0));
        });
        _messages = items;
        _scrollToBottom();
      }
    } catch (e) {
      print('Failed to fetch messages: $e');
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _loadCurrentUserInfo() async {
    final userInfo = await LocalStorageService().getUserInfo();
    setState(() {
      _currentUserInfo = userInfo;
    });
  }

  Future<void> _sendMessage () async {
    if (_messageController.text.trim().isEmpty) return;

    final response = await DudeeService().sendMessage(
      int.parse(widget.conversationId),
      _messageController.text.trim(),
    );
    print('Send Message Status ${response.statusCode}');
    print('Send Message Data ${response.data}');
    if (response.statusCode == 201) {
      _messageController.clear();
      await fetchData();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    if (_messages.isEmpty) {
      return const Center(child: Text("No messages yet."));
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final messageItem = _messages[index];
        final bool isMe = messageItem.sender?.id == _currentUserInfo['userId'];
        return _buildMessageBubble(messageItem, isMe);
      },
    );
  }

  Widget _buildMessageBubble(Item message, bool isMe) {
    final participant = message.sender;
    if (participant == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(participant.name ?? 'Unknown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            if (!isMe) SizedBox(height: 4),
            Text(message.content ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            maxLines: 5,
            minLines: 1,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _sendMessage,
        ),
      ],
    );
  }
}
