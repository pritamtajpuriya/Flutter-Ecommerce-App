import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find()));
  }
}
