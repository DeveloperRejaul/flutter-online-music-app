import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/constants/secret.dart';
import 'package:flutter_online_music_app/core/utils/navigation.dart';
import 'package:flutter_online_music_app/core/utils/toast.dart';
import 'package:flutter_online_music_app/core/widgets/logo.dart';
import 'package:flutter_online_music_app/features/auth/view/pages/login.dart';
import 'package:flutter_online_music_app/features/auth/view/widgets/button.dart';
import 'package:flutter_online_music_app/features/auth/view/widgets/text_input.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // from state
  bool isLoading = false;

  Future<void> handleFrom() async {
    try {
      if (_formKey.currentState!.validate()) {
        final res = await http.post(
          Uri.parse("$BASE_URL/user"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
            "name": nameController.text
          }),
        );
        // handle success request
        if (res.statusCode == 201) {
          showSnackBar(context, "You sign up successfully");
          return Nav.push(context, const Login());
        }
        showSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      showSnackBar(context, "Something went wrong");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark700,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                      label: "Name",
                      hint: "Jon deo",
                      controller: nameController,
                    ),
                    const SizedBox(height: 10),
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
                      text: "Sign up",
                      onPressed: handleFrom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
