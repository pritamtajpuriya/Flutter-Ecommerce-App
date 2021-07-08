import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class SocialButton extends StatelessWidget {
  final String imageName;
  final String socialMedia;
  final Color color;

  final controller = Get.put(LoginController());

  void loginGoogle(String idToken) async {
    final result = await controller.googleAuth(idToken);
    if (result) {
      Get.offAllNamed(SajiloDokanRoutes.landingHome);
    } else {
      Get.snackbar('Error', 'Incorrect Password');
    }
  }

  SocialButton({this.imageName, this.socialMedia, this.color});
  final googlesignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<GoogleSignInAccount> login() async {
    final user = await googlesignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        // print(googleKey.idToken + 'this token is good for now');
        log(googleKey.idToken + '  === Token');

        print(googlesignIn.currentUser.displayName);
        loginGoogle(googleKey.idToken);
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
    // print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: login,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Image.asset(
            imageName,
            height: 20,
          )),
        ),
      ),
    );
  }
}
