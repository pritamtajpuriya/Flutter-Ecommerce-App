import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:sajilo_dokan/domain/exception/auth_exception.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';

enum SignType { sigIn, signUp }

class LoginController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  LoginController({this.localRepositoryInterface, this.apiRepositoryInterface});

  final passwordTextController = TextEditingController();
  final nameTexcontroller = TextEditingController();
  final emailTextController = TextEditingController();

  var isLoading = false.obs;

  var isvalidEmail = false.obs;
  var isValidPassword = false.obs;
  RxBool isSignIn = true.obs;
  RxBool showPassword = true.obs;

  toggleFormType() {
    isSignIn(!isSignIn.value);
  }

  toggleShowPassword() {
    showPassword(!showPassword.value);
  }

  Future<bool> login() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    try {
      isLoading(true);
      final loginResponse =
          await apiRepositoryInterface.login(LoginRequest(email, password));

      if (loginResponse != null) {
        await localRepositoryInterface.saveToken(loginResponse.token);
        await localRepositoryInterface.saveUser(loginResponse.user);
        return true;
      } else
        isLoading(false);

      return false;
    } on Exception {
      isLoading(false);
      return false;
    }
  }

  Future<bool> register() async {
    final name = nameTexcontroller.text;
    final email = emailTextController.text;
    final password = passwordTextController.text;

    try {
      isLoading(true);
      final loginResponse = await apiRepositoryInterface.register(
          RegisterRequest(name: name, email: email, password: password));
      await localRepositoryInterface.saveToken(loginResponse.token);
      await localRepositoryInterface.saveUser(loginResponse.user);
      return true;
    } on AuthException catch (_) {
      isLoading(false);
      return false;
    }
  }
}
