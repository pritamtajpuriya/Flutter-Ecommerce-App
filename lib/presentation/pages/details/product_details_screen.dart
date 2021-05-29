import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/add_cart.dart';

import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    final controller = Get.find<HomeController>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: null,
              actions: [
                InkWell(onTap: () {
                  Navigator.of(context).pushNamed(SajiloDokanRoutes.cart);
                }, child: Obx(() {
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
                SizedBox(
                  width: 30,
                )
              ],
              expandedHeight: 300,
              floating: false,
              pinned: true,
              snap: false,
              elevation: 2,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: PhotoView(
                          backgroundDecoration:
                              BoxDecoration(color: Colors.white),
                          imageProvider: NetworkImage(
                              'https://onlinehatiya.herokuapp.com' +
                                  args.product.image),
                          maxScale: PhotoViewComputedScale.covered * 2.0,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black.withOpacity(0.4)),
                        height: 25,
                        width: 40,
                        child: Center(
                          child: Text(
                            '1/1',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                    // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$' + args.product.price.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.share)),
                            ],
                          )
                        ],
                      ),
                      Text(
                        args.product.title,
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                          fontSize: 18,
                        )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SmoothStarRating(
                                rating: args.product.avaragereview,
                                isReadOnly: true,
                                size: 15,
                                filledIconData: Icons.star,
                                borderColor: Colors.red,
                                color: Colors.red,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                allowHalfRating: true,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                args.product.avaragereview.toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                ' / ' + '(${args.product.noofreviews}) reviews',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sold by',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Waiva Mobile',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                              fontSize: 18,
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'View Shop',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/insurance.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: 'Secure Shoping',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text:
                                                  ' We are committed to protecting the security of your informatio',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ))
                                        ])),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/return.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: '7 Days Returns',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text:
                                                  ' Change of mind is not applicable',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ))
                                        ])),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/quality.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: 'Quality Checked',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text:
                                                  ' We are providing top quality products and service.',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ))
                                        ])),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/time.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: 'Estimated Delivery Time',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: ' Damak city: 1 to 3 Days',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ))
                                        ])),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Information',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text(
                          args.product.description,
                          style: GoogleFonts.ptSans(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: ExpansionTile(
                      title: Text(
                    'Specification',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 14),
                  ))),
              SizedBox(height: 10),
              Container(
                color: Colors.white.withOpacity(0.4),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Continue Shopping',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Container(child: Obx(() {
              //   if (controller.isLoading.value) {
              //     final list = controller.productList
              //         .where((i) => i. != args.product.category)
              //         .toList();

              //     return ProductGridviewTile(
              //       productList: list,
              //     );
              //   } else {
              //     return Center(child: CircularProgressIndicator());
              //   }
              // })),
            ]))
          ],
        ),
      ),
      bottomNavigationBar: AddToCard(
        product: args.product,
        onChanged: () {
          controller.addToCard(args.product.id);
        },
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  ProductDetailsArguments({this.product});
}


  // SajiloDokanScaffold(
  //     title: null,
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       backwardsCompatibility: false,
  //       systemOverlayStyle: SystemUiOverlayStyle(
  //         statusBarColor: Colors.transparent,
  //         statusBarIconBrightness: Brightness.dark,
  //       ),
  //       actions: [
  //         InkWell(
  //             onTap: () {
  //               Navigator.of(context).pushNamed(SajiloDokanRoutes.cart);
  //             },
  //             child: SvgPicture.asset(
  //               'assets/icons/bottom_menu/cart.svg',
  //               color: Colors.black,
  //             )),
  //         SizedBox(
  //           width: 30,
  //         )
  //       ],
  //     ),
  //     body: Scaffold(
  //       backgroundColor: Colors.grey.withOpacity(0.1),
  //       body: ListView(
  //         children: [
  //           Stack(
  //             alignment: Alignment.bottomRight,
  //             children: [
  //               // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
  //               AspectRatio(
  //                 aspectRatio: 4 / 3,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 10, right: 10),
  //                   child: ClipRRect(
  //                     child: PhotoView(
  //                       backgroundDecoration:
  //                           BoxDecoration(color: Colors.white),
  //                       imageProvider: NetworkImage(args.product.image
  //                           .replaceAll(
  //                               'fakestoreapi', 'fakestoreapi.herokuapp')),
  //                       maxScale: PhotoViewComputedScale.covered * 2.0,
  //                       minScale: PhotoViewComputedScale.contained * 0.8,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Positioned(
  //                   child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(30),
  //                       color: Colors.grey.withOpacity(0.5)),
  //                   height: 40,
  //                   width: 40,
  //                   child: Center(
  //                     child: Text(
  //                       '1/1',
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                   ),
  //                 ),
  //               ))
  //               // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
  //             ],
  //           ),
  //           // Row(
  //           //   mainAxisAlignment: MainAxisAlignment.center,
  //           //   children: [
  //           //     ...List.generate(
  //           //         1,
  //           //         (index) => AnimatedContainer(
  //           //               padding: EdgeInsets.all(10),
  //           //               margin: EdgeInsets.all(10),
  //           //               duration: Duration(seconds: 1),
  //           //               height: 70,
  //           //               width: 70,
  //           //               decoration: BoxDecoration(
  //           //                   color: Colors.white,
  //           //                   borderRadius: BorderRadius.circular(10),
  //           //                   border: Border.all(
  //           //                       color: Colors.purple
  //           //                           .withOpacity(index == 0 ? 1 : 0))),
  //           //               child: Image.network(args.product.image.replaceAll(
  //           //                   'fakestoreapi', 'fakestoreapi.herokuapp')),
  //           //             ))
  //           //   ],
  //           // ),
  //           Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 border: Border(bottom: BorderSide(color: Colors.grey))),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         '\$' + args.product.price.toString(),
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.redAccent),
  //                       ),
  //                       IconButton(onPressed: () {}, icon: Icon(Icons.share))
  //                     ],
  //                   ),
  //                   Text(
  //                     args.product.title,
  //                     style: GoogleFonts.ptSans(
  //                         textStyle: TextStyle(
  //                       fontSize: 18,
  //                     )),
  //                   ),

  //                   // Row(
  //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   //   children: [
  //                   //     RichText(
  //                   //         text: TextSpan(children: [
  //                   //       TextSpan(
  //                   //           text: 'Seller :',
  //                   //           style: TextStyle(
  //                   //               fontSize: 14,
  //                   //               color: Colors.black.withOpacity(0.5))),
  //                   //       TextSpan(
  //                   //           text: ' Waiva Mobile',
  //                   //           style: TextStyle(
  //                   //               fontSize: 14,
  //                   //               color: Colors.black.withOpacity(0.5)))
  //                   //     ])),
  //                   //     InkWell(
  //                   //       onTap: () {},
  //                   //       child: Text(
  //                   //         'Visit Store',
  //                   //         style:
  //                   //             TextStyle(fontSize: 14, color: Colors.redAccent),
  //                   //       ),
  //                   //     )
  //                   //   ],
  //                   // )
  //                 ],
  //               ),
  //             ),
  //           ),

  //           Container(
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 border: Border(bottom: BorderSide(color: Colors.grey))),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Sold by',
  //                     style: TextStyle(color: Colors.black.withOpacity(0.5)),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Waiva Mobile',
  //                         style: GoogleFonts.roboto(
  //                             textStyle: TextStyle(
  //                           fontSize: 18,
  //                         )),
  //                       ),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.grey),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(5.0),
  //                           child: Text(
  //                             'View Shop',
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   // Container(
  //                   //   decoration: BoxDecoration(
  //                   //       border: Border.all(color: Colors.redAccent),
  //                   //       color: Colors.redAccent.withOpacity(0.3)),
  //                   //   child: Padding(
  //                   //     padding: const EdgeInsets.all(5.0),
  //                   //     child: Text('Chat Now'),
  //                   //   ),
  //                   // )
  //                 ],
  //               ),
  //             ),
  //           ),

  //           Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 border: Border(bottom: BorderSide(color: Colors.grey))),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Product Information',
  //                     style: TextStyle(fontSize: 14),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 100),
  //                     child: Text(
  //                       args.product.description,
  //                       style: GoogleFonts.ptSans(
  //                           fontSize: 14, color: Colors.black.withOpacity(0.5)),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),

  //           // Container(
  //           //   decoration: BoxDecoration(color: Colors.white),
  //           //   child: ExpansionTile(
  //           //     title: Text(
  //           //       'Product Information',
  //           //       style: TextStyle(
  //           //           color: Colors.black.withOpacity(0.6), fontSize: 14),
  //           //     ),
  //           //     backgroundColor: Colors.white,
  //           //     children: [
  //           //       Padding(
  //           //         padding: const EdgeInsets.only(left: 20, right: 20),
  //           //         child: Text(
  //           //           args.product.description,
  //           //           style: GoogleFonts.ptSans(
  //           //               fontSize: 14, color: Colors.black.withOpacity(0.5)),
  //           //         ),
  //           //       ),
  //           //     ],
  //           //   ),
  //           // ),

  //           Container(
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   border: Border(bottom: BorderSide(color: Colors.grey))),
  //               child: ExpansionTile(
  //                   title: Text(
  //                 'Specification',
  //                 style: TextStyle(
  //                     color: Colors.black.withOpacity(0.5), fontSize: 14),
  //               ))),
  //           SizedBox(height: 10),

  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Text(
  //               'Related Products',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Container(child: Obx(() {
  //             if (controller.isLoading.value) {
  //               final list = controller.productList
  //                   .where((i) => i.category != args.product.category)
  //                   .toList();

  //               return ProductGridviewTile(
  //                 productList: list,
  //               );
  //             } else {
  //               return Center(child: CircularProgressIndicator());
  //             }
  //           })),
  //         ],
  //       ),
  //     ),
  //     bottomNavigationBar: AddToCard(),
  //   );