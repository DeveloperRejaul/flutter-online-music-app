import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/constants/secret.dart';
import 'package:flutter_online_music_app/core/utils/navigation.dart';
import 'package:flutter_online_music_app/core/utils/store.dart';
import 'package:flutter_online_music_app/core/utils/toast.dart';
import 'package:flutter_online_music_app/core/widgets/logo.dart';
import 'package:flutter_online_music_app/futures/auth/model/auth_model.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/button.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/text_input.dart';
import 'package:flutter_online_music_app/futures/home/pages/Home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // handle from
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // from state
  bool isLoading = false;

  Future<void> handleFrom() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() => isLoading = true);
        final response = await http.post(
          Uri.parse("$BASE_URL/user/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        if (response.statusCode == 400) {
          setState(() => isLoading = false);
          return showSnackBar(context, "Something went wrong");
        }
        final data = AuthModel.fromJson(response.body);
        await Storage.writeStr("access_token", data.access_token);
        setState(() => isLoading = false);
        showSnackBar(context, "You are login successfully");
        Nav.replace(context, const Home());
      }
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
      showSnackBar(context, "Something went wrong");
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark700,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 10),
                Text(
                  "Welcome to Spotify",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 35),
                TextInput(
                  label: "Email",
                  hint: "example@gmail.com",
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                TextInput(
                  label: "Password",
                  hint: "************",
                  controller: passwordController,
                ),
                const SizedBox(height: 12),
                Button(
                  isLoading: isLoading,
                  text: "Login",
                  onPressed: handleFrom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
