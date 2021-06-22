import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  ProductTile({this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator.pushNamed(SajiloDokanRoutes.productDetails,
            arguments: ProductDetailsArguments(product: product));
      },
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: product != null
                          ? Center(
                              child: Image.network(
                              'https://onlinehatiya.herokuapp.com' +
                                  product.images[0].image,
                              height: 170,
                              width: 130,
                              fit: BoxFit.fill,
                            ))
                          : Center(
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                    color: AppColors.darkGray.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                    ),
                    SizedBox(height: 8),
                    product != null
                        ? Text(
                            product.title,
                            maxLines: 2,
                            style: GoogleFonts.ptSans(),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(
                            height: 20,
                            width: 120,
                            decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    product != null
                        ? Text('Rs. ' + '${product.price}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF7643)))
                        : Container(
                            height: 15,
                            decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                    SizedBox(height: 8),
                    product != null
                        ? SmoothStarRating(
                            rating: product.avaragereview,
                            isReadOnly: true,
                            size: 15,
                            filledIconData: Icons.star,
                            borderColor: Colors.red,
                            color: Colors.red,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: true,
                          )
                        : Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                  ],
                ),
              ),
            ),
            product != null
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red),
                      child: Center(
                        child: Text(
                          product.price <= 5000 ? 'New' : '-30%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                : SizedBox.shrink(),
            // Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: InkWell(
            //         onTap: () {
            //           controller.makeFavorite(product.id);
            //           // productController.makeFavorite(product.id);
            //         },
            //         child: Container(
            //             height: 30,
            //             width: 30,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(30),
            //             ),
            //             child: Icon(
            //               product.favorite
            //                   ? Icons.favorite
            //                   : Icons.favorite_border,
            //               color: Colors.red,
            //             )),
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}
