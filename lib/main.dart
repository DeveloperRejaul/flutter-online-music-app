import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/app.dart';
import 'package:flutter_online_music_app/core/constants/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const App(),
    );
  }
}
