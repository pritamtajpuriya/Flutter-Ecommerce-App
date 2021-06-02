import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
          expandedHeight: 190,
          floating: true,
          snap: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        list.length,
                        (index) => Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Text(
                                  list[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                  ],
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
                        productList: controller.categoryProducts,
                      )
                    : Column(
                        children: [
                          ...List.generate(
                              controller.categoryProducts.length,
                              (index) => InkWell(
                                    onTap: () {
                                      navigator.pushNamed(
                                          SajiloDokanRoutes.productDetails,
                                          arguments: ProductDetailsArguments(
                                              product: controller
                                                  .categoryProducts[index]));
                                    },
                                    child: Padding(
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
                                                  child: Center(
                                                    child: Image.network(
                                                      'https://onlinehatiya.herokuapp.com' +
                                                          controller
                                                              .categoryProducts[
                                                                  index]
                                                              .image,
                                                      height: 150,
                                                      width: 130,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .categoryProducts[
                                                                  index]
                                                              .title,
                                                          maxLines: 2,
                                                          style: GoogleFonts
                                                              .ptSans(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SmoothStarRating(
                                                              rating: controller
                                                                  .categoryProducts[
                                                                      index]
                                                                  .avaragereview,
                                                              isReadOnly: true,
                                                              size: 15,
                                                              filledIconData:
                                                                  Icons.star,
                                                              borderColor:
                                                                  Colors.red,
                                                              color: Colors.red,
                                                              halfFilledIconData:
                                                                  Icons
                                                                      .star_half,
                                                              defaultIconData:
                                                                  Icons
                                                                      .star_border,
                                                              starCount: 5,
                                                              allowHalfRating:
                                                                  true,
                                                            ),
                                                            Text(
                                                              ' ' +
                                                                  controller
                                                                      .categoryProducts[
                                                                          index]
                                                                      .avaragereview
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Rs ' +
                                                              controller
                                                                  .categoryProducts[
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                height: 20,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.red),
                                                child: Center(
                                                  child: Text(
                                                    controller
                                                                .categoryProducts[
                                                                    index]
                                                                .price <=
                                                            30
                                                        ? 'New'
                                                        : '-30%',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
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

    //  Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Text(
    //         args.categoryName,
    //         style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 40),
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ...List.generate(
    //             list.length,
    //             (index) => Container(
    //                   height: 40,
    //                   width: 80,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(15),
    //                     color: Colors.black,
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       list[index],
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                   ),
    //                 ))
    //       ],
    //     ),
    //     Padding(
    //         padding: const EdgeInsets.only(
    //             left: 20, right: 20, top: 10, bottom: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text('Filter'),
    //             Obx(() {
    //               return IconButton(
    //                   onPressed: () {
    //                     controller.changeGridMode(controller.isGrid.value);
    //                   },
    //                   icon: !controller.isGrid.value
    //                       ? Icon(Icons.grid_view)
    //                       : Icon(Icons.format_list_bulleted));
    //             })
    //           ],
    //         )),
    //     Expanded(
    //       child: SingleChildScrollView(
    //         child: Obx(() {
    //           if (!controller.isCategoryProductsLoading.value) {
    //             return !controller.isGrid.value
    //                 ? ProductGridviewTile(
    //                     productList: controller.categoryProducts,
    //                   )
    //                 : Column(
    //                     children: [
    //                       ...List.generate(
    //                           controller.categoryProducts.length,
    //                           (index) => Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 25, right: 25, bottom: 25),
    //                                 child: Stack(
    //                                   children: [
    //                                     Card(
    //                                       elevation: 2,
    //                                       child: Row(
    //                                         children: [
    //                                           Container(
    //                                             height: 200,
    //                                             width: 150,
    //                                             color: AppColors.darkGray
    //                                                 .withOpacity(0.2),
    //                                             child: Center(
    //                                               child: Image.network(
    //                                                 controller
    //                                                     .categoryProducts[
    //                                                         index]
    //                                                     .image,
    //                                                 height: 150,
    //                                                 width: 80,
    //                                                 fit: BoxFit.fill,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           Flexible(
    //                                             child: Padding(
    //                                               padding:
    //                                                   const EdgeInsets.all(
    //                                                       8.0),
    //                                               child: Column(
    //                                                 crossAxisAlignment:
    //                                                     CrossAxisAlignment
    //                                                         .start,
    //                                                 children: [
    //                                                   Text(
    //                                                     controller
    //                                                         .categoryProducts[
    //                                                             index]
    //                                                         .title
    //                                                         .toString(),
    //                                                     maxLines: 2,
    //                                                     style: GoogleFonts
    //                                                         .ptSans(),
    //                                                     overflow:
    //                                                         TextOverflow
    //                                                             .ellipsis,
    //                                                   ),
    //                                                   Text(
    //                                                     'Rs ' +
    //                                                         controller
    //                                                             .categoryProducts[
    //                                                                 index]
    //                                                             .price
    //                                                             .toString(),
    //                                                     style: TextStyle(
    //                                                         color: Colors
    //                                                             .redAccent),
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                             ),
    //                                           )
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     Positioned(
    //                                         top: 0,
    //                                         left: 0,
    //                                         child: Container(
    //                                           height: 20,
    //                                           width: 40,
    //                                           decoration: BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(
    //                                                       5),
    //                                               color: Colors.red),
    //                                           child: Center(
    //                                             child: Text(
    //                                               controller
    //                                                           .categoryProducts[
    //                                                               index]
    //                                                           .price <=
    //                                                       30
    //                                                   ? 'New'
    //                                                   : '-30%',
    //                                               style: TextStyle(
    //                                                   color: Colors.white),
    //                                             ),
    //                                           ),
    //                                         )),
    //                                     Positioned(
    //                                         bottom: 0,
    //                                         right: 0,
    //                                         child: Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(8.0),
    //                                           child: InkWell(
    //                                             onTap: () {},
    //                                             child: Container(
    //                                                 height: 30,
    //                                                 width: 30,
    //                                                 decoration:
    //                                                     BoxDecoration(
    //                                                   borderRadius:
    //                                                       BorderRadius
    //                                                           .circular(30),
    //                                                 ),
    //                                                 child: Icon(
    //                                                   Icons.favorite_border,
    //                                                   color: Colors.red,
    //                                                 )),
    //                                           ),
    //                                         )),
    //                                   ],
    //                                 ),
    //                               ))
    //                     ],
    //                   );
    //           } else {
    //             return Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           }
    //         }),
    //       ),
    //     ),
    //   ],
    // ));
  }
}

class CategoryArguments {
  final String categoryName;
  CategoryArguments({this.categoryName});
}
