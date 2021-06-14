import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/product_list_tile.dart';

class CategoryProducts extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();

  final list = ['Clothes', 'Hoodies', 'Nice', 'T-shirts'];

  @override
  Widget build(BuildContext context) {
    final CategoryArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        // appBar: AppBar(
        //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        //   elevation: 0,
        // ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: null,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          expandedHeight: 130,
          floating: true,
          snap: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    args.categoryName,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filter'),
                        Obx(() {
                          return IconButton(
                              onPressed: () {
                                controller
                                    .changeGridMode(controller.isGrid.value);
                              },
                              icon: !controller.isGrid.value
                                  ? Icon(Icons.grid_view)
                                  : Icon(Icons.format_list_bulleted));
                        })
                      ],
                    )),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SingleChildScrollView(
            child: Obx(() {
              if (!controller.isCategoryProductsLoading.value) {
                return !controller.isGrid.value
                    ? ProductGridviewTile(
                        productList: args.product,
                      )
                    : Column(
                        children: [
                          ...List.generate(
                              args.product.length,
                              (index) => ProductListTile(
                                    product: args.product[index],
                                  ))
                        ],
                      );
              } else {
                return Column(
                  children: [
                    ...List.generate(
                        5,
                        (index) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 25),
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 150,
                                          color: AppColors.darkGray
                                              .withOpacity(0.2),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkGray
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 15,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkGray
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 15,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkGray
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 15,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.darkGray
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                  ],
                );
              }
            }),
          ),
        ]))
      ],
    ));
  }
}

class CategoryArguments {
  final String categoryName;
  final List<Product> product;
  CategoryArguments({this.categoryName, this.product});
}
