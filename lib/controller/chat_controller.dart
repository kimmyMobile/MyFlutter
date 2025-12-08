import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/model/message_model.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  final dudee = DudeeService();
  final RxList<Item> messages = <Item>[].obs;

  void navigateToChat(int? conversationId) {
    if (conversationId == null) {
      print('Conversation ID is null');
      Get.snackbar(
        'Error',
        'Cannot open chat, conversation ID is missing.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(
      AppRoute.chat,
      parameters: {'conversationId': conversationId.toString()},
    );
  }


  Future<void> fetchMessages(String conversationId) async {
    try {
      await dudee.chatRead(int.parse(conversationId));
      final messageResponse = await dudee.getMessages(int.parse(conversationId));
      if (messageResponse.data != null && messageResponse.data!.items != null) {
        final items = messageResponse.data!.items!;
        items.sort((a, b) {
          return (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0));
        });
        messages.assignAll(items);
      }
    } catch (e) {
      print('Failed to fetch messages: $e');
    }
  }
}