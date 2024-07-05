import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/theme.dart';
import 'package:flutter_online_music_app/futures/auth/pages/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
    );
  }
}
