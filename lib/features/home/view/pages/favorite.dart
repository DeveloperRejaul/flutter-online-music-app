import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/provider/music_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMusics = ref
        .watch(musicNotifierProvider)
        .where((e) => e?.isFavorite == true)
        .toList();

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.dark600),
      backgroundColor: AppColors.dark600,
      body: ListView.builder(
        itemCount: favoriteMusics.length,
        itemBuilder: (ctx, index) {
          final song = favoriteMusics[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/demo.jpg',
                height: 50,
                width: 50,
              ),
            ),
            title: Text(
              song!.title,
              maxLines: 2,
              style: TextStyle(color: AppColors.light100),
            ),
            subtitle: Text(
              song.name,
              style: TextStyle(color: AppColors.light500),
            ),
          );
        },
      ),
    );
  }
}
