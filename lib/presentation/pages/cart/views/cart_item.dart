import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class CartItem extends StatelessWidget {
  final Cart? cart;
  final int? cartIndex;
  CartItem({this.cart, this.cartIndex});
  final homeController = Get.find<HomeController>();
  final controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() {
          return SizedBox(
              height: 20,
              child: IconButton(
                  onPressed: () {
                    controller.selectCart(cart!);
                  },
                  icon: homeController.selectedCarts.contains(cart!.id)
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank)));
        }),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, SajiloDokanRoutes.productDetails,
                        arguments:
                            ProductDetailsArguments(product: cart!.product)),
                    child: Container(
                      height: 60,
                      width: 50,
                      child: Image.network(
                          'https://onlinehatiya.herokuapp.com' +
                              cart!.product!.image!,
                          height: 100),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cart!.product!.title!,
                              style: GoogleFonts.ptSans(),
                              overflow: TextOverflow.ellipsis),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            cart!.product!.description!,
                            maxLines: 2,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs ' + cart!.amount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              InkWell(
                                  onTap: () {
                                    controller.quantity(cart!.quantity!);
                                    controller.showButtomSheed(
                                        context, () {}, cart!.id);
                                  },
                                  child: Text('Qty:${cart!.quantity} ▾'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        homeController.removeProductFromCart(cart!.id);
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
