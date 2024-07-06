import 'package:flutter_online_music_app/core/modal/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@riverpod
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user) {
    state = user;
  }
}
