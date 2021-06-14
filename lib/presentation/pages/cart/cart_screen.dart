import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/cart/views/cart_item.dart';
import 'package:sajilo_dokan/presentation/pages/cart/views/checkout_cart.dart';
import 'package:sajilo_dokan/presentation/pages/cart/views/items_number.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final cardController = Get.put(CartController());
  final int index;
  CartScreen(this.index);
  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
        title: null,
        body: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Shopping Cart',
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.grey.withOpacity(0.1),
            body: Stack(
              children: [
                Obx(() {
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemNuber(
                            itemNumber: controller.cartList.length,
                          ),
                          TextButton(
                              onPressed: () {
                                controller.clearCart();
                              },
                              child: Text(
                                'Clear all',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 16),
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          ...List.generate(
                              controller.cartList.length,
                              (index) => CartItem(
                                    cartIndex: index,
                                    cart: controller.cartList[index],
                                  ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.4),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Continue Shopping',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProductGridviewTile(
                        productList: controller.productList,
                      )
                    ],
                  );
                }),
                Obx(() {
                  return controller.isCartLoad.value
                      ? Container(
                          color: Colors.grey.withOpacity(0.4),
                          height: double.infinity,
                          width: double.infinity,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                })
              ],
            ),
            bottomNavigationBar: CheckoutCart()));
  }
}
