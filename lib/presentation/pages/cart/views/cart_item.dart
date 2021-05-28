import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/add_quantity.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final int cartIndex;
  CartItem({this.cart, this.cartIndex});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  arguments: ProductDetailsArguments(product: cart.product)),
              child: Image.network(
                  'https://onlinehatiya.herokuapp.com' + cart.product.image,
                  height: 100),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.title,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      cart.product.description,
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$' + cart.product.price.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        Expanded(
                            child: AddQuantity(
                          noOfItem: cart.quantity,
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.removeProductFromCart(cartIndex);
                },
                icon: Icon(Icons.cancel))

            // Padding(
            //   padding: const EdgeInsets.only(left: 70),
            //   child: Row(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //             color: Colors.redAccent,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(
            //                 'Remove',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
