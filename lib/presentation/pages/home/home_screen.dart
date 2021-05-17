import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/category.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/header.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/populor_product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_tile.dart';
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
                title: 'Categories',
                linkText: 'View all',
                onLinkTap: () {},
              ),
              Categories(),
              BlockHeader(
                title: 'Popular Product',
                linkText: 'View all',
                onLinkTap: () {},
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return PopulorProduct(
                    products: controller.productList,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              BlockHeader(
                title: 'New Product',
                linkText: 'View all',
                onLinkTap: () {},
              ),
              Container(child: Obx(() {
                if (controller.isLoading.value) {
                  return ProductGridviewTile(
                    productList: controller.productList,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
