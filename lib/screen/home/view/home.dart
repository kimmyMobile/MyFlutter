import 'package:flutter/material.dart';
import 'package:flutter_app_test1/config/routes/app_route.dart';
import 'package:flutter_app_test1/controller/conversation_controller.dart';
import 'package:flutter_app_test1/controller/friend_controller.dart';
import 'package:flutter_app_test1/controller/socket_controller.dart';
import 'package:flutter_app_test1/controller/user_controller.dart';
import 'package:flutter_app_test1/screen/home/widgets/list_chat_widget.dart';
import 'package:flutter_app_test1/screen/home/widgets/list_friend_widget.dart';
import 'package:flutter_app_test1/screen/widgets/custom_drawerbar.dart';
import 'package:flutter_app_test1/screen/widgets/profile_circle.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ConversationController conversationController = Get.put(
    ConversationController(),
  );
  final FriendController friendController = Get.put(FriendController());
  SocketController skController = Get.put(SocketController());

  final UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userController.fetchUserProfile();
    // เชื่อมต่อ Socket เมื่อเข้าหน้า Home
    //_connectSocket();
  }

  //เชื่อมต่อ Socket (async)
  Future<void> _connectSocket() async {
    try {
      await skController.connectSocket();
    } catch (e) {
      print('❌ [Home] Failed to connect socket: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await Future.wait([
      conversationController.fetchConversations(),
      friendController.fetchFriends(),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerbar(),
      appBar: AppBar(
        title: const Text('Message'),
        actions: <Widget>[
          Obx(() {
            return Text(skController.socketStatus.value.name);
          }),
          Builder(
            builder: (BuildContext innerContext) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(innerContext).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      final profileUrl =
                          userController.userProfile.value?.data?.profileUrl;
                      return InkWell(
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRoute.profile);
                        },
                        child: ProfileCircle(imageUrl: profileUrl),
                      );
                    }),
                    const SizedBox(width: 10),
                    const Text(
                      'Chats',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    const Icon(Icons.camera_alt_outlined, size: 28),
                    const SizedBox(width: 16),
                    const Icon(Icons.edit, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                final isFriendLoading = friendController.isLoading.value && friendController.friends.isEmpty;
                final isConversationLoading = conversationController.isLoading.value && conversationController.conversations.isEmpty;

                if (isFriendLoading || isConversationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    // Friend List
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: friendController.friends.length,
                        itemBuilder: (context, index) {
                          final friend = friendController.friends[index];
                          return ListFriendWidget(
                            friend: friend,
                            currentUserId: userController.userProfile.value?.data?.userId,
                          );
                        },
                      ),
                    ),
                    // Conversation List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: conversationController.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversationController.conversations[index];
                        return ListChatWidget(
                          conversation: conversation,
                          currentUserId: userController.userProfile.value?.data?.userId,
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // ปัจจุบันอยู่ที่หน้า Home แล้วไม่ต้องทำอะไร
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRoute.profile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
