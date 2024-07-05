// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_online_music_app/core/constants/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color? bg;
  final double? radius;
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bg,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg ?? AppColors.success700,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.light100,
          fontSize: 18,
        ),
      ),
    );
  }
}
