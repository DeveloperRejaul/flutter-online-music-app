import 'package:flutter_online_music_app/core/modal/user_model.dart';
import 'package:flutter_online_music_app/core/provider/current_user_notifier.dart';
import 'package:flutter_online_music_app/core/utils/store.dart';
import 'package:flutter_online_music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepositories _authRemoteRepositories;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepositories = ref.watch(authRemoteRepositoriesProvider);

    // state notifier
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future signUpUser(
    String email,
    String name,
    String password,
  ) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepositories.signup(name, email, password);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = _signUp(r),
    };
  }

  Future loginUser(String email, String password) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepositories.login(email, password);
    final val = switch (res) {
      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _login(r),
    };
  }

  Future checkAuthUser() async {
    state = const AsyncValue.loading();
    final token = await Storage.readStr("access_token");
    final res = await _authRemoteRepositories.authCheck(token);
    final val = switch (res) {
      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  // handle all internal functions
  // sing up fn
  AsyncValue<UserModel>? _signUp(UserModel user) {
    _currentUserNotifier.addUser(user); // add data current user
    return state = AsyncValue.data(user); // return current user success data
  }

  // login fn
  Future<AsyncValue<UserModel>?> _login(UserModel user) async {
    _currentUserNotifier.addUser(user);
    await Storage.writeStr("access_token", user.access_token);
    return state = AsyncValue.data(user);
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
