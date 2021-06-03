import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_tile.dart';

import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class ProductGridviewTile extends StatelessWidget {
  final List<Product> productList;

  ProductGridviewTile({this.productList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          itemCount: productList != null ? productList.length : 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  navigator.pushNamed(SajiloDokanRoutes.productDetails,
                      arguments:
                          ProductDetailsArguments(product: productList[index]));
                },
                child: ProductTile(
                    productList != null ? productList[index] : null));
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
    );
  }
}
