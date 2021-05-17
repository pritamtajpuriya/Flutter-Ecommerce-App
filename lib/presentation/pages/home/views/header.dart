import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class Header extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Product',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, SajiloDokanRoutes.cart),
                child: Obx(() {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/icons/bottom_menu/cart.svg',
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        right: 2,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Center(
                            child: Text(
                              controller.cartList.length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                })),
          ),
        ],
      ),
    );
  }
}
