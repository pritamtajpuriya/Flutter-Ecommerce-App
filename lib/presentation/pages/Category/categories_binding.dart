import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CatergoriesController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find()));
  }
}
