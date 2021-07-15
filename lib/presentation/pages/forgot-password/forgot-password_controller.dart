import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  Future<bool> forgotPassword(String email) async {
    var result = await apiRepositoryInterface.forgetPassword(email);
    return result;
  }
}
