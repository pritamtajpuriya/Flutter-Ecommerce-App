import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find()));
  }
}
