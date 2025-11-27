import 'package:flutter/material.dart';
import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/controller/user_controller.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';

class Auth {
  UserController userController = Get.put(UserController());

  Future<bool> login(
    BuildContext context, {
      required String email,
      required String password,
  }) async {
    dynamic result = await DudeeService.login(email: email, password: password);
    print(result);
    if (result == 'Successful') {
      userController.setIsLogIn(logIn: true);
      GoRouter.of(context).goNamed(AppRoute.home);
      return true;
    }else{
      return false;
    }
  }

  Future<bool> register(
    BuildContext context, {
      required String email,
      required String password,
      required String name,
  }) async {
    dynamic result = await DudeeService().register(
      email: email,
      password: password,
      name: name,
    );
    print(result.statusCode);
    if (result.statusCode == 201) { 
      userController.setIsLogIn(logIn: true);
      GoRouter.of(context).goNamed(AppRoute.home);
      return true;
    }else{
      return false;
    }
  }

  Future<bool> logout(BuildContext context) async {
    await DudeeService().logOut();
    userController.setIsLogIn(logIn: false);
    GoRouter.of(context).goNamed(AppRoute.login);
    return true;
  }
}
