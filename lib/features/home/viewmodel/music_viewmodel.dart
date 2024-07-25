import 'package:flutter_online_music_app/core/modal/music_modal.dart';
import 'package:flutter_online_music_app/core/provider/music_notifier.dart';
import 'package:flutter_online_music_app/features/home/repositoris/music_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_viewmodel.g.dart';

@riverpod
Future<List<MusicModal>> getMusics(GetMusicsRef ref) async {
  final res = await ref.watch(musicRepositoryProvider).getMusics();
  final musicNotifier = ref.read(musicNotifierProvider.notifier);

  _handleRight(List<MusicModal> musics) {
    musicNotifier.addMusics(musics);
    return musics;
  }

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => _handleRight(r),
  };
}

@riverpod
class MusicViewModel extends _$MusicViewModel {
  late MusicRepository _musicRepository;
  late MusicNotifier _musicNotifier;

  @override
  AsyncValue<MusicModal>? build() {
    _musicRepository = ref.read(musicRepositoryProvider);
    _musicNotifier = ref.read(musicNotifierProvider.notifier);
    return null;
  }

/**
 * This Function only for creating music
 * returns created music  
 */
  Future createMusic({
    required String name,
    required String title,
    required String image,
    required String color,
    required String url,
    required bool isFavorite,
  }) async {
    state = AsyncValue.loading();
    final res = await _musicRepository.createMusic(
      name: name,
      title: title,
      image: image,
      color: color,
      url: url,
      isFavorite: isFavorite,
    );
    return switch (res) {
      Right(value: final r) => _createMusic(r),
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current)
    };
  }

  Future<AsyncValue<MusicModal>> _createMusic(MusicModal music) async {
    return state = AsyncValue.data(music);
  }

/**
 * This Function using for only get single music
 * returns single music  with id
 */
  Future getMusic() async {}

/**
 * This Function using for delete music by id
 * returns delete count and status code
*/
  Future deleteMusic() async {}

/**
 * This Function using for update music by id
 * returns updated music 
*/
  Future updateMusic({required int id, required bool isFavorite}) async {
    final res =
        await _musicRepository.updateMusic(id: id, isFavorite: isFavorite);

    return switch (res) {
      Right(value: final r) => _updateMusic(r),
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current)
    };
  }

  Future<AsyncValue<MusicModal>> _updateMusic(MusicModal music) async {
    _musicNotifier.updateMusicFavorite(music.id, music.isFavorite);
    return AsyncValue.data(music);
  }
}
