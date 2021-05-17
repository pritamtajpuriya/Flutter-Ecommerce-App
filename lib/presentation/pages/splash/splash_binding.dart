import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find()));
  }
}
