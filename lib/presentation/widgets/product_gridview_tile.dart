import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/widgets/product_tile.dart';

class ProductGridviewTile extends StatelessWidget {
  final List<Product>? productList;

  ProductGridviewTile({this.productList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          itemCount: productList != null ? productList!.length : 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) => ProductTile(
                product: productList != null ? productList![index] : null,
              ),
          staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
    );
  }
}
