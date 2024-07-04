import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';
import 'package:flutter_online_music_app/core/widgets/logo.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/button.dart';
import 'package:flutter_online_music_app/futures/auth/widgets/text_input.dart';

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

  handleFrom() {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      print(name);
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
