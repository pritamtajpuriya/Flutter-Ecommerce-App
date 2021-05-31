import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class ProductDetailsController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductDetailsController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt selectedImage = 0.obs;
  int get index => selectedImage.value;

  Future<void> makeFavorite(int id) async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.makeFavorite(token, id);
    print('fab btn called');
  }
}
