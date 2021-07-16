import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/forgot-password_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';

class CreateNewPassword extends GetWidget<ForgotPasswordController> {
  void createNewPassword() async {
    var result = await controller.createNewPassword();
    if (result) {
      navigator.pushNamed(SajiloDokanRoutes.landingHome);
    } else {
      Get.snackbar('New password create fail', 'Your reset is fail');
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
          children: [
            Text(
              'Create New Password',
              style: CustomTextStyle.headLine,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your new password must be different from previous used passwords',
              style: CustomTextStyle.lowVisial,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'password',
                  hintStyle: CustomTextStyle.lowVisial,
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: controller.newPasswordController,
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                createNewPassword();
              },
              child: DefaultBTN(
                btnText: 'Reset Password',
              ),
            )
          ],
        ),
      ),
    );
  }
}
