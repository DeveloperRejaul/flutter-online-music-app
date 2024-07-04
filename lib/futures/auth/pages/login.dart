import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/widgets/logo.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/button.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  handleFrom() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      print(email);
      print(password);
    }
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
