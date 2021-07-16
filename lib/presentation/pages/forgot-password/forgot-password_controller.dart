import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sajilo_dokan/domain/model/user.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Timer timer;
  var loadingTime = 60.obs;
  RxBool isTimer = false.obs;

  void startTimer() {
    isTimer(true);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (loadingTime.value > 0) {
        loadingTime(loadingTime.value - 1);
      } else {
        timer.cancel();
        loadingTime(60);
        isTimer(false);
      }
    });
  }

  RxString token = ''.obs;

  Future<bool> forgotPassword() async {
    final email = emailController.text;
    var result = await apiRepositoryInterface.forgetPassword(email);
    if (result == true) {
      startTimer();
      Get.snackbar('Validation OTP', 'Successfuly send');
    }
    return result;
  }

  Future<String> verifyOtp(String otp) async {
    final email = emailController.text;
    // final otp = otpController.text;
    var result =
        await apiRepositoryInterface.verifyForgetPasswordCode(email, otp);
    token(result);
    if (result == null) {
      Get.snackbar('Validation OTP', 'Do not match');
    }
    print(result);
    return result;
  }

  Future<bool> createNewPassword() async {
    final newpassword = newPasswordController.text;
    print(newpassword);
    var result = await apiRepositoryInterface.createNewPassword(
        token.value, newpassword);
    if (result != null) {
      localRepositoryInterface.saveToken(result.token);
      localRepositoryInterface.saveUser(result.user);
      return true;
    }
    return false;
  }
}
