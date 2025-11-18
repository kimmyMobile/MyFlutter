import 'package:flutter/material.dart';
import 'package:flutter_app_test1/service/SharedPreferences/shared_preferences.dart';
import 'package:flutter_app_test1/widgets/custom_drawerbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final token = await SharedPreferencesProvider.getToken('accessToken');
      final ref = await SharedPreferencesProvider.getRefreshToken('refreshToken');

      print('Access Token: $token');
      print('Refesh Token: $ref');

    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerbar(),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
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
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}