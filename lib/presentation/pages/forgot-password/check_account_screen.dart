import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/forgot-password_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';

class CheckAccountScreen extends GetWidget<ForgotPasswordController> {
  void forgetPassword() async {
    var result = await controller.forgotPassword();
    print(result);
    if (result) {
      navigator.pushNamed(SajiloDokanRoutes.sendCodeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultLogo(),
            Text(
              'Find Your Acccount',
              style: CustomTextStyle.headLine,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Enter the email associated with your account and we\'ll send an email with OTP code to reset your password',
                style: CustomTextStyle.lowVisial,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: controller.emailController,
              autofillHints: [AutofillHints.email],
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required';
                }
                if (!value.contains('@')) {
                  return 'A valid email is required';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                print('caa');
                forgetPassword();
                // navigator.pushNamed(SajiloDokanRoutes.sendCodeScreen);
              },
              child: DefaultBTN(
                btnText: 'Check Your Account',
              ),
            )
          ],
        ),
      ),
    );
  }
}
