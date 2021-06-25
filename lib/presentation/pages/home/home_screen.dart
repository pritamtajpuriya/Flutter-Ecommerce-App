import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category_products.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/header.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/populor_product.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/sajilo_carousel.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/block_header.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class Home extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final int index;
  Home({this.index});

  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
      bottomMenuIndex: index,
      title: null,
      background: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Header(),
              SajiloCarousel(),
              BlockHeader(
                title: 'Popular Product',
                linkText: 'View all',
                onLinkTap: () {
                  final list = controller.productList
                      .where((i) => i.price <= 5000)
                      .toList();
                  navigator.pushNamed(SajiloDokanRoutes.categoryProduct,
                      arguments: CategoryArguments(
                          product: list, categoryName: 'Popular Product'));
                },
              ),
              Obx(() {
                final list = controller.productList
                    .where((i) => i.price <= 5000)
                    .toList();
                return PopulorProduct(
                  products: controller.isLoading.value ? list : null,
                );
              }),
              BlockHeader(
                title: 'New Product',
                linkText: 'View all',
                onLinkTap: () {
                  navigator.pushNamed(SajiloDokanRoutes.categoryProduct,
                      arguments: CategoryArguments(
                          product: controller.productList,
                          categoryName: 'New Products'));
                },
              ),
              Container(child: Obx(() {
                final list = controller.productList
                    .where((i) => i.price > 5000)
                    .toList();
                return ProductGridviewTile(
                  productList: controller.isLoading.value ? list : null,
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
