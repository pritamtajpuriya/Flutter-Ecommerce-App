import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/form.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class LoginScreen extends GetWidget<LoginController> {
  void login() async {
    final result = await controller.login();
    if (result) {
      Get.offAllNamed(SajiloDokanRoutes.landingHome);
    } else {
      Get.snackbar('Error', 'Incorrect Password');
    }
  }

  void register() async {
    print('register call in screen');
    final result = await controller.register();
    if (result) {
      Get.offAllNamed(SajiloDokanRoutes.landingHome);
    } else {
      Get.snackbar('Error', 'No VAlid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Obx(() {
                      return SignForm(
                        name: controller.nameTexcontroller,
                        email: controller.emailTextController,
                        password: controller.passwordTextController,
                        logOrRegAction:
                            controller.isSignIn.value ? login : register,
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
