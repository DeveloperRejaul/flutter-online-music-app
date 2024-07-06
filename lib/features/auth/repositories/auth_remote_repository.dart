import 'dart:convert';

import 'package:flutter_online_music_app/core/constants/secret.dart';
import 'package:flutter_online_music_app/core/failure/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_online_music_app/core/modal/user_model.dart';
import 'package:http/http.dart' as http;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepositories authRemoteRepositories(AuthRemoteRepositoriesRef ref) {
  return AuthRemoteRepositories();
}

class AuthRemoteRepositories {
  Future<Either<AppFailure, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;

      // handle response error
      if (response.statusCode != 201) {
        return Left(AppFailure(res['detail']));
      }
      return Right(UserModel.fromMap(res));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> signup(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password, "name": name}),
      );

      // decode the response
      final res = jsonDecode(response.body);

      // handle error response
      if (res.statusCode != 201) return Left(AppFailure(res['message']));

      return Right(UserModel.fromMap(res));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> authCheck(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/user/auth"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
      );
      // decode the response
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) return Right(UserModel.fromMap(res));

      return Left(AppFailure(res['message']));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
