import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find()));
  }
}
