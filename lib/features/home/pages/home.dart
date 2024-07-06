import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/provider/current_user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserNotifierProvider);

    return Scaffold(
      body: Center(
        child: Text(user?.name ?? ''),
      ),
    );
  }
}
