import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/provider/music_notifier.dart';
import 'package:flutter_online_music_app/core/utils/color.dart';
import 'package:flutter_online_music_app/core/widgets/Button.dart';
import 'package:flutter_online_music_app/core/widgets/Card.dart';
import 'package:flutter_online_music_app/features/home/view/widgets/bottom_bar.dart';
import 'package:flutter_online_music_app/features/home/viewmodel/music_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isBottomMusic = false;
  String name = "";
  String title = "";
  String img = "";
  late bool isFavorite = false;
  late int? id;

  Future handleFavorite(int? musicId, bool favorite) async {
    if (musicId != null) {
      await ref
          .read(musicViewModelProvider.notifier)
          .updateMusic(id: musicId, isFavorite: !favorite);
      if (id == musicId) isFavorite = !isFavorite;
    } else {
      print("Id is missing");
    }
  }

  @override
  Widget build(BuildContext context) {
    final getMusics = ref.watch(getMusicsProvider);
    final allMusic = ref.watch(musicNotifierProvider);

    final isLoading = getMusics.isLoading;
    final isError = getMusics.hasError;

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.dark600),
      backgroundColor: AppColors.dark600,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Button(
                      text: "M",
                      onPressed: () {},
                      bg: AppColors.error400,
                      shape: CircleBorder(),
                    ),
                    const SizedBox(width: 5),
                    Button(
                      text: "All",
                      onPressed: () {},
                      bg: AppColors.success500,
                    ),
                    const SizedBox(width: 10),
                    Button(
                      text: "Music",
                      onPressed: () {},
                      bg: AppColors.dark300,
                      px: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "To get you started",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 10),
                // list of music display
                isError ? Text("Something went wrong") : SizedBox(),
                isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: allMusic.length,
                          itemBuilder: (BuildContext context, int index) {
                            final song = allMusic[index];
                            return MusicCard(
                              onFavorite: () =>
                                  handleFavorite(song.id, song.isFavorite),
                              onPressed: () {
                                setState(() {
                                  isBottomMusic = true;
                                  name = song.name;
                                  title = song.title;
                                  img = "assets/images/demo.jpg";
                                  isFavorite = song.isFavorite;
                                  id = song.id;
                                });
                              },
                              img: "assets/images/demo.jpg",
                              name: song!.name,
                              title: song.title,
                              color: hexToColor(song.color),
                              isFavorite: song.isFavorite,
                            );
                          },
                        ),
                      ),
              ],
            ),
            isBottomMusic
                ? BottomBar(
                    img: img,
                    name: name,
                    title: title,
                    isFavorite: isFavorite,
                    id: id,
                    onFavorite: () => handleFavorite(id, isFavorite))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
