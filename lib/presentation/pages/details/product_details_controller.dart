import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/product_comment.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class ProductDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final LocalRepositoryInterface? localRepositoryInterface;
  final ApiRepositoryInterface? apiRepositoryInterface;

  ProductDetailsController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt selectedImage = 0.obs;
  int get index => selectedImage.value;

  RxBool initbool = true.obs;
  RxInt productid = 0.obs;

  var comments = <ProductComment>[].obs;
  RxBool isCommentsLoad = false.obs;

  PhotoViewScaleStateController? controllerState;

  //Animation Controller for Controll animation
  //Declare
  late AnimationController animationController;

  //Animation Onject
  Animation? colorAnimation;

  @override
  void onInit() async {
    super.onInit();
    controllerState = PhotoViewScaleStateController();
    final token = await localRepositoryInterface!.getToken();
    getComments(productid.value, token);

    //Initialize Animation Controller
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() => print(animationController.value));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void goBack() {
    controllerState!.scaleState = PhotoViewScaleState.initial;
  }

  void setInit(bool? fab) {
    initbool(fab!);
  }

  void clickFavorite() {
    initbool(!initbool.value);
  }

  Future<void> makeFavorite(int? id) async {
    final token = await localRepositoryInterface!.getToken();
    clickFavorite();
    if (token != null) {
      var result = await apiRepositoryInterface!.makeFavorite(token, id);
      print('fab btn called');

      if (result == true) {
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
    } else {
      Get.offNamed(SajiloDokanRoutes.login);
    }
  }

  Future<void> getComments(int? id, String? token) async {
    String? token = await localRepositoryInterface!.getToken();
    isCommentsLoad(true);
    var data = await apiRepositoryInterface!.getComments(token, id);
    print(id);
    print('GetComment call');

    if (data != null) {
      comments(data);
    } else {
      comments(null);
    }
    isCommentsLoad(false);
  }

  void likeBtn(int? commentId, int? productId) async {
    var token = await localRepositoryInterface!.getToken();
    if (token != null) {
      var result = await apiRepositoryInterface!.likeComment(token, commentId);

      if (result == true) {
        await getComments(productId, token);
      }
    } else {
      Get.offNamed(SajiloDokanRoutes.login);
    }
  }

  void dislikeBtn(int? commentId, int? productId) async {
    var token = await localRepositoryInterface!.getToken();

    if (token != null) {
      var result =
          await apiRepositoryInterface!.dislikeComment(token, commentId);

      if (result == true) {
        await getComments(productId, token);
      }
    } else {
      Get.offNamed(SajiloDokanRoutes.login);
    }
  }
}
