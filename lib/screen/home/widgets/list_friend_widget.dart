import 'package:flutter/material.dart';
import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/controller/conversation_controller.dart';
import 'package:flutter_app_test1/model/friend_model.dart' as friend_model;
import 'package:flutter_app_test1/screen/widgets/profile_circle.dart';
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
    ConversationController conversationController = Get.put(
      ConversationController(),
    );


    return InkWell(
      onTap: () async {
        try {
          int? conversationId = friend.conversationId;
          if (conversationId != null) {
            GoRouter.of(context).pushNamed(
              AppRoute.chat,
              pathParameters: {'conversationId': conversationId.toString()},
            );
          } else {
            final newConversation =
                await conversationController.createConversation([friend.id!]);
            GoRouter.of(context).pushNamed(
              AppRoute.chat,
              pathParameters: {'conversationId': newConversation.toString()},
            );
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
            ProfileCircle(imageUrl: friend.profileUrl, size: 60),
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