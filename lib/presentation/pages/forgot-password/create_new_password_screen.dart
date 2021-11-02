import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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
      navigator!.pushNamed(SajiloDokanRoutes.landingHome);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          controller.isLoading.value
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.4),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink(),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
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
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.newPasswordController,
                                autofillHints: [AutofillHints.password],
                                decoration: InputDecoration(
                                    labelText: 'password',
                                    hintText: 'password',
                                    hintStyle: CustomTextStyle.lowVisial,
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.length < 6) {
                                    return 'Its length must be greater than 6 ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                autofillHints: [AutofillHints.password],
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    hintText: 'Confirm Password',
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value !=
                                      controller.newPasswordController.text) {
                                    return 'Password does not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    createNewPassword();
                                  }
                                },
                                child: DefaultBTN(
                                  btnText: 'Reset Password',
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }));
  }
}
