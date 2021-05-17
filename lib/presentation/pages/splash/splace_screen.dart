import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splash_controller.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: Image.asset('assets/logos/logo.png'),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
