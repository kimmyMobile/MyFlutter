import 'package:get/get.dart';

class UserController extends GetxController {
  RxBool isLogIn = false.obs;

  void setIsLogIn({required bool logIn}) {
    isLogIn.value = logIn;
    update();
  }

  void clearMemberInfo() {
    setIsLogIn(logIn: false);
  }

} 