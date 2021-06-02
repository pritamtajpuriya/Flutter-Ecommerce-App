import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category_products.dart';
import 'package:sajilo_dokan/presentation/pages/Category/views/body.dart';

import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class CategorieScreen extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();
  final int index;
  CategorieScreen(this.index);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SajiloDokanScaffold(
        title: 'Cateroies',
        background: null,
        body: Obx(() {
          if (!controller.isLoading.value)
            return CategoriesTile(
              categoriesList: controller.categoriesList,
              onChanged: (index) {
                controller
                    .loadCategoryProducts(controller.categoriesList[index]);
                navigator.pushNamed(SajiloDokanRoutes.categoryProduct,
                    arguments: CategoryArguments(
                        categoryName: controller.categoriesList[index],
                        product: controller.categoryProducts));
              },
            );
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        bottomMenuIndex: 1,
      ),
    );
  }
}
