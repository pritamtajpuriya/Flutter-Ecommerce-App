import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class CatergoriesController extends GetxController {
  final LocalRepositoryInterface? localRepositoryInterface;
  final ApiRepositoryInterface? apiRepositoryInterface;
  CatergoriesController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  RxList categoriesList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isCategoryProductsLoading = false.obs;
  var categoryProducts = <Product>[].obs;

  final box = GetStorage();

  RxBool isGrid = false.obs;
  void changeGridMode(bool val) {
    box.write('gridmode', !val);
    isGrid(!val);
  }

  void initGridMode() => isGrid(box.read('gridmode') ?? false);

  @override
  void onReady() {
    loadCategories();
    super.onReady();
    initGridMode();
  }

  loadCategories() {
    try {
      isLoading(true);
      apiRepositoryInterface!
          .getCategories()
          .then((value) => categoriesList(value));
    } finally {
      isLoading(false);
    }
  }

  loadCategoryProducts(String? categoryName) async {
    print('load');
    try {
      isCategoryProductsLoading(true);
      await apiRepositoryInterface!
          .getCategorieProduct(categoryName)
          .then((value) {
        categoryProducts(value!);
        print(categoryProducts(value));
      });
    } finally {
      isCategoryProductsLoading(false);
    }
  }
}
