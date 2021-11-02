import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';

class CartController extends GetxController {
  final ApiRepositoryInterface? apiRepositoryInterface;
  final LocalRepositoryInterface? localRepositoryInterface;
  final homecontroller = Get.put(HomeController());
  CartController({this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt quantity = 2.obs;
  RxBool loading = false.obs;

  ScrollController scrollController = ScrollController();
  RxBool isVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    // scontroller = ScrollController();
    // scontroller.addListener(() {
    //   if (scontroller.position.userScrollDirection == ScrollDirection.reverse) {
    //     if (isVisible.value) {
    //       isVisible(false);
    //       print(isVisible);
    //     }
    //   }
    //   if (scontroller.position.userScrollDirection == ScrollDirection.forward) {
    //     if (!isVisible.value) {
    //       isVisible(true);
    //       print(isVisible);
    //     }
    //   }
    // });
  }

  void selectAllCart() {
    if (homecontroller.selectedCarts.length == homecontroller.cartList.length) {
      homecontroller.selectedCarts([]);
    } else {
      homecontroller.selectedCarts([]);
      homecontroller.cartList.forEach((element) {
        homecontroller.selectedCarts.add(element.id);
      });
    }
    homecontroller.refreshTotal();
  }

  void selectCart(Cart cart) {
    if (!homecontroller.selectedCarts.contains(cart.id)) {
      homecontroller.selectedCarts.add(cart.id);
    } else {
      homecontroller.selectedCarts.remove(cart.id);
    }
    homecontroller.refreshTotal();
  }

  void addQuantity(int? id, int quantity) async {
    final token = await localRepositoryInterface!.getToken();
    var result = await apiRepositoryInterface!.addQuanity(token, id, quantity);

    if (result == true) {
      AppWidget.snacbar('Added to cart successfully!');
      homecontroller.fetchCartList();
    }
  }

  void showButtomSheed(BuildContext context, VoidCallback onTap, int? id) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            height: 200,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text('Selete Quantity'),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel)),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            10,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      quantity(index + 1);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color:
                                                  quantity.value == (index + 1)
                                                      ? Colors.redAccent
                                                      : Colors.black)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text((1 + index).toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addQuantity(id, quantity.value);
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        color: Colors.redAccent,
                        width: double.infinity,
                        child: Center(child: Text('Done'))),
                  )
                ],
              );
            })));
  }
}
