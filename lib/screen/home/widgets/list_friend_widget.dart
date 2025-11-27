import 'package:flutter/material.dart';
import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/controller/conversation_controller.dart';
import 'package:flutter_app_test1/model/friend_model.dart' as friend_model;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ListFriendWidget extends StatelessWidget {
  final friend_model.Datum friend;
  final int? currentUserId;

  const ListFriendWidget({
    super.key,
    required this.friend,
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final ConversationController conversationController =
        Get.find<ConversationController>();
    return InkWell(
      onTap: () async {
        try {
           final existingConversation =
              conversationController.conversations.firstWhereOrNull(
            (convo) =>
                convo.participants?.length == 2 &&
                convo.participants!.any((p) => p.id == friend.id) &&
                convo.participants!.any((p) => p.id == currentUserId),
          );
          if (existingConversation != null) {
            GoRouter.of(context).pushNamed(
              AppRoute.chat,
              pathParameters: {
                'conversationId': existingConversation.id.toString()
              },
            );
          } else {
            if (currentUserId != null && friend.id != null) {
              final newConversationId = await conversationController
                  .createConversation([currentUserId!, friend.id!]);
              if (newConversationId != null && context.mounted) {
                GoRouter.of(context).pushNamed(
                  AppRoute.chat,
                  pathParameters: {'conversationId': newConversationId.toString()},
                );
              }
            }
          }
        } catch (e) {
          print('Failed to create or navigate to conversation: $e');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to process conversation: $e')),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircleAvatar(
              radius: 30,
            ),
            const SizedBox(height: 4),
            Text(
              friend.name ?? 'Unknown',
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}