import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/domain/model/user.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  HomeController({this.apiRepositoryInterface, this.localRepositoryInterface});

  Rx<User> user = User.empty().obs;
  RxInt selectedIndex = 0.obs;
  var productList = <Product>[].obs;
  RxBool isLoading = true.obs;

  RxBool isFavorite = false.obs;
  var cartList = <Cart>[].obs;
  @override
  void onReady() {
    loadUser();
    super.onReady();
    fetchProduct();
  }

  loadUser() {
    localRepositoryInterface.getUser().then((value) => user(value));
  }

  void updateIndexSelected(int index) {
    selectedIndex(index);
  }

  void logout() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
  }

  void fetchProduct() async {
    isLoading(false);
    try {
      var products = await apiRepositoryInterface.fetchingProdcut();
      if (products != null) {
        productList(products);
      }
    } finally {
      isLoading(true);
    }
  }

  void favoritebtn() {
    isFavorite.value = !isFavorite.value;
  }

  void fetchCartList() {
    cartList(demoCarts);
  }

  void addToCard(Product product) {
    print(cartList.asMap().containsKey(product.id));
    if (cartList.asMap().containsKey(product.id))
      return null;
    else {
      cartList.add(Cart(product: product, numOfItem: 1));
    }
  }

  void removeProductFromCart(int index) {
    cartList.removeAt(index);
  }

  void clearCart() {
    cartList.clear();
  }
}
