import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/secret.dart';
import 'package:flutter_online_music_app/core/utils/navigation.dart';
import 'package:flutter_online_music_app/core/utils/store.dart';
import 'package:flutter_online_music_app/features/auth/view/pages/root.dart';
import 'package:flutter_online_music_app/features/home/pages/Home.dart';
import 'package:http/http.dart' as http;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<void> checkAuth() async {
    try {
      final token = await Storage.readStr("access_token");
      if (token.isEmpty) return Nav.replace(context, const RootPage());
      final response = await http.get(
        Uri.parse("$BASE_URL/user/auth"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
      );
      if (response.statusCode == 200) return Nav.replace(context, const Home());
      Nav.replace(context, const RootPage());
    } catch (e) {
      Nav.replace(context, const RootPage());
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
