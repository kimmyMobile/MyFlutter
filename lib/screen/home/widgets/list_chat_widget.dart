import 'package:flutter/material.dart';
import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/model/chat_model.dart';
import 'package:flutter_app_test1/screen/widgets/profile_circle.dart';
import 'package:go_router/go_router.dart';

class ListChatWidget extends StatelessWidget {
  final Datum conversation;
  final int? currentUserId;

  const ListChatWidget({
    super.key,
    required this.conversation,
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final otherParticipant = conversation.participants?.firstWhere(
      (p) => p.id != currentUserId,
      orElse: () => Participant(name: 'Unknown'),
    );
    final lastMessage = conversation.lastMessage;
    final unreadCount = conversation.unreadCount ?? 0;

    return ListTile(
      leading: ProfileCircle(imageUrl: otherParticipant?.profileUrl, size: 60),
      title: Text(
        otherParticipant?.name ?? 'Unknown User',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastMessage?.content ?? 'No messages yet',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: unreadCount > 0 ? Colors.black : Colors.grey,
          fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: unreadCount > 0
          ? ProfileCircle(imageUrl: otherParticipant?.profileUrl, size: 20)
          : const SizedBox.shrink(),
      onTap: () async {
        try {
          final conversationId = conversation.id;
          if (conversationId == null) {
            print('Conversation ID is null');
            return;
          }
       final result = await  GoRouter.of(context).pushNamed(
            AppRoute.chat,
            pathParameters: {'conversationId': conversationId.toString()},
          );
          print(  'Returned from chat with result: $result');
        } catch (e) {
          print('Failed to create or navigate to conversation: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create conversation: $e')),
          );
        }
      },
    );
  }
}