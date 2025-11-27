import 'package:flutter_app_test1/model/friend_model.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  RxList<Datum> friends = <Datum>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    try {
      isLoading.value = true;
      update();
      final friendResponse = await DudeeService().listFriend();
      friends.assignAll(friendResponse.data!.data!);
    } catch (e) {
      print("Error fetching friends: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}