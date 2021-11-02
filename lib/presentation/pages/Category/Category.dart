import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/category.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category_products.dart';
import 'package:sajilo_dokan/presentation/pages/Category/views/body.dart';

import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class CategorieScreen extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();
  final int index;
  CategorieScreen(this.index);

  final List<dynamic> data = [
    {
      "title": "Laptop",
      "children": [
        {"title": "Asus", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "Asus", "children": []},
        {"title": "Dell", "children": []},
        {"title": "Hp", "children": []},
        {"title": "Apple", "children": []}
      ]
    },
    {
      "title": "Mobile",
      "children": [
        {"title": "Xiomi", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "iphone", "children": []},
        {"title": "Gionee", "children": []},
        {"title": "Samsung", "children": []},
        {"title": "Nokia", "children": []}
      ]
    },
    {
      "title": "Electronic",
      "children": [
        {
          "title": "charger",
          "children": [
            {"title": "mobile charger", "children": []}
          ]
        },
        {"title": "mobile charger", "children": []},
        {"title": "Earphone", "children": []}
      ]
    },
    {
      "title": "Clothes",
      "children": [
        {"title": "Hoodies", "children": []},
        {"title": "Nice", "children": []},
        {"title": "T-shirts", "children": []},
        {"title": "Shirts", "children": []}
      ]
    }
  ];

  _buldContainer(List<Category> data) {
    return Column(
      children: [
        ...List.generate(
            data.length,
            (index) => data[index].children!.length != 0
                ? ExpansionTile(
                    title: Text(data[index].title!),
                    children: [_buldAgainContainer(data[index].children!)],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Text(
                          data[index].title!,
                          textAlign: TextAlign.start,
                        )),
                  ))
      ],
    );
  }

  _buldAgainContainer(List<Category> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            data.length,
            (index) => data[index].children!.length != 0
                ? ExpansionTile(
                    title: Text(data[index].title!),
                    children: [],
                  )
                : Container(
                    width: double.infinity,
                    child: Text(
                      data[index].title!,
                      textAlign: TextAlign.start,
                    )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> ddddd =
        data.map((dynamic e) => Category.fromJson(e)).toList();

    return SafeArea(
      child: SajiloDokanScaffold(
        title: 'Cateroies',
        background: null,
        body:
            // body: SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       ...List.generate(
            //           ddddd.length,
            //           (index) => Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 child: Container(
            //                   child: ExpansionTile(
            //                     title: Container(
            //                       height: 80,
            //                       decoration: BoxDecoration(),
            //                       child: Row(
            //                         children: [
            //                           Image.asset('assets/images/facebook.png'),
            //                           SizedBox(
            //                             width: 50,
            //                           ),
            //                           Text(ddddd[index].title),
            //                         ],
            //                       ),
            //                     ),
            //                     children: [_buldContainer(ddddd[index].children)],
            //                   ),
            //                 ),
            //               ))
            //     ],
            //   ),
            // ),

            Obx(() {
          if (!controller.isLoading.value)
            return CategoriesTile(
              categoriesList: ddddd,
              onChanged: (index) {
                controller.loadCategoryProducts(ddddd[index].title);
                navigator!.pushNamed(SajiloDokanRoutes.categoryProduct,
                    arguments: CategoryArguments(
                        categoryName: ddddd[index].title,
                        product: controller.categoryProducts,
                        category: ddddd[index].children));
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
