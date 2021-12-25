

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/forgot-password_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';

class SendCodeScreen extends GetWidget<ForgotPasswordController> {
  void verifyOtp(String code) async {
    var result = await controller.verifyOtp(code);
    if (result != null) {
      navigator!.pushReplacementNamed(SajiloDokanRoutes.createNewPassword);
    }
  }

  final firstDigit = TextEditingController();
  final secondDigit = TextEditingController();
  final thirdDigit = TextEditingController();
  final fourthDigit = TextEditingController();
  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Stack(
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
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultLogo(),
                      Text(
                        'Reset Your Password',
                        style: CustomTextStyle.headLine,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'We have send a OTP to your email check and verify to reset your password',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.lowVisial,
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: 30,
                                  child: TextField(
                                    focusNode: f1,
                                    autofocus: true,
                                    onChanged: (str) {
                                      if (str.length == 1) {
                                        FocusScope.of(context).requestFocus(f2);
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: firstDigit,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration:
                                        InputDecoration(counterText: ''),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: 30,
                                  child: RawKeyboardListener(
                                    autofocus: true,
                                    focusNode: FocusNode(),
                                    onKey: (event) {
                                      if (event.logicalKey ==
                                          LogicalKeyboardKey.backspace) {
                                        f2.unfocus();
                                        FocusScope.of(context).requestFocus(f1);
                                      }
                                    },
                                    child: TextField(
                                      focusNode: f2,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      controller: secondDigit,
                                      keyboardType: TextInputType.number,
                                      onChanged: (str) {
                                        if (str.length == 1) {
                                          FocusScope.of(context)
                                              .requestFocus(f3);
                                        }
                                        if (str.length == 0) {
                                          FocusScope.of(context)
                                              .requestFocus(f1);
                                        }
                                      },
                                      maxLength: 1,
                                      decoration:
                                          InputDecoration(counterText: ''),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: 30,
                                  child: RawKeyboardListener(
                                    autofocus: true,
                                    focusNode: FocusNode(),
                                    onKey: (event) {
                                      if (event.logicalKey ==
                                          LogicalKeyboardKey.backspace) {
                                        f3.unfocus();
                                        FocusScope.of(context).requestFocus(f2);
                                      }
                                    },
                                    child: TextField(
                                      focusNode: f3,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      controller: thirdDigit,
                                      keyboardType: TextInputType.number,
                                      onChanged: (str) {
                                        if (str.length == 1) {
                                          FocusScope.of(context)
                                              .requestFocus(f4);
                                        }
                                        if (str.length == 0) {
                                          FocusScope.of(context)
                                              .requestFocus(f2);
                                        }
                                      },
                                      maxLength: 1,
                                      decoration:
                                          InputDecoration(counterText: ''),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: 30,
                                  child: RawKeyboardListener(
                                    autofocus: true,
                                    focusNode: FocusNode(),
                                    onKey: (event) {
                                      if (event.logicalKey ==
                                          LogicalKeyboardKey.backspace) {
                                        f4.unfocus();
                                        FocusScope.of(context).requestFocus(f3);
                                      }
                                    },
                                    child: TextField(
                                      focusNode: f4,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      controller: fourthDigit,
                                      keyboardType: TextInputType.number,
                                      onChanged: (str) {
                                        if (str.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                        if (str.length == 0) {
                                          FocusScope.of(context)
                                              .requestFocus(f3);
                                        }
                                      },
                                      maxLength: 1,
                                      decoration:
                                          InputDecoration(counterText: ''),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t reveive the OTP ? ',
                                style: CustomTextStyle.lowVisial,
                              ),
                              Obx(() {
                                return InkWell(
                                  onTap: () {
                                    !controller.isTimer.value
                                        ? controller.forgotPassword()
                                        : null;
                                  },
                                  child: Text(
                                    !controller.isTimer.value
                                        ? 'RESEND OTP'
                                        : controller.loadingTime.value
                                            .toString(),
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                );
                              })
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          print(controller.emailController.text);
                          verifyOtp(firstDigit.text +
                              secondDigit.text +
                              thirdDigit.text +
                              fourthDigit.text);
                          // navigator.pushNamed(SajiloDokanRoutes.createNewPassword);
                        },
                        child: DefaultBTN(
                          btnText: 'Verify',
                        ),
                      )
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
