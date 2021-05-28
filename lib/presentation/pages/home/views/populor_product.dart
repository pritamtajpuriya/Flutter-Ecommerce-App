import 'package:flutter/material.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_tile.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class PopulorProduct extends StatelessWidget {
  final List<Product> products;
  PopulorProduct({this.products});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(products.length, (index) {
            return InkWell(
                onTap: () => Navigator.pushNamed(
                    context, SajiloDokanRoutes.productDetails,
                    arguments:
                        ProductDetailsArguments(product: products[index])),
                child: ProductTile(products[index]));
            // return Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: SizedBox(
            //     width: 140,
            //     child: Column(
            //       children: [
            //         AspectRatio(
            //           aspectRatio: 1.02,
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: Colors.grey.withOpacity(0.1)),
            //             child: Image.network(products[index].image),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           products[index].title,
            //           maxLines: 2,
            //         ),
            //         SizedBox(height: 10),
            //         Text(
            //           products[index].price.toString(),
            //           style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.w600,
            //               color: Colors.red),
            //         )
            //       ],
            //     ),
            //   ),
            // );
          })
        ],
      ),
    );
  }
}
