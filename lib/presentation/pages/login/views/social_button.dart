import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class SocialButton extends StatelessWidget {
  SocialButton({this.imageName, this.socialMedia, this.color, this.onPressed});

  final String? imageName;
  final String? socialMedia;
  final Color? color;
  final VoidCallback? onPressed;

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Image.asset(
            imageName!,
            height: 20,
          )),
        ),
      ),
    );
  }
}
