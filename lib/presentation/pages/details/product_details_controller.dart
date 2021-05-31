import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class ProductDetailsController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductDetailsController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt selectedImage = 0.obs;
  int get index => selectedImage.value;

  RxInt init = 0.obs;
  RxBool initbool = true.obs;

  void setInit(bool fab) {
    initbool(fab);
  }

  void clickFavorite() {
    initbool(!initbool.value);
  }

  Future<void> makeFavorite(int id) async {
    final token = await localRepositoryInterface.getToken();
    var result = await apiRepositoryInterface.makeFavorite(token, id);
    print('fab btn called');

    init += 1;
    if (result == true) {
      clickFavorite();
      Get.snackbar(
          initbool.value
              ? 'Add item to favorit list successfully!'
              : 'Remove from favorite',
          '',
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
