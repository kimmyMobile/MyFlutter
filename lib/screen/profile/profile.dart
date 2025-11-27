import 'package:flutter/material.dart';
import 'package:flutter_app_test1/model/user_profile.dart';
import 'package:flutter_app_test1/service/auth.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {

  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    userProfile = await DudeeService().getUserProfile();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> logout() async {
    await Auth().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                'Profile',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome ${userProfile?.data?.name}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 16),
          ElevatedButton(onPressed: logout , child: Text("Log out"))
        ],
      ),
    );
  }
}
