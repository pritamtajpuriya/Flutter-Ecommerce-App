import 'package:flutter/material.dart';
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
    var result = await apiRepositoryInterface.makeFavorite(token, id);
    print('fab btn called');
    if (result == true) {
      Get.snackbar('Add item to favoritlist successfully!', '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          borderRadius: 0,
          backgroundColor: Colors.black.withOpacity(0.8),
          isDismissible: true,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(5)
          // animationDuration: Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          );
    }
  }
}
