import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sajilo_dokan/package/product_rating.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/image_screen.dart';

import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/add_cart.dart';

import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:share/share.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  final dataKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    final homecontroller = Get.find<HomeController>();
    controller.productid(args.product.id);
    controller.setInit(args.product.favorite);

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
                              homecontroller.cartList.length.toString(),
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
                  background: Obx(() {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              child: InkWell(
                                  onDoubleTap: () {
                                    navigator.pushNamed(
                                        SajiloDokanRoutes.imageScreen,
                                        arguments: ImageScreenArguments(
                                            product: args.product));
                                  },
                                  child: PhotoViewGallery.builder(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    builder: (BuildContext context, int index) {
                                      return PhotoViewGalleryPageOptions(
                                        disableGestures: true,
                                        imageProvider: NetworkImage(args
                                                    .product.images.length ==
                                                0
                                            ? 'https://onlinehatiya.herokuapp.com' +
                                                args.product.image
                                            : 'https://onlinehatiya.herokuapp.com' +
                                                args
                                                    .product
                                                    .images[controller
                                                        .selectedImage.value]
                                                    .image),
                                        initialScale:
                                            PhotoViewComputedScale.contained *
                                                0.8,
                                      );
                                    },
                                    itemCount: args.product.images.length,
                                    loadingBuilder: (context, progress) =>
                                        Center(
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          value: progress == null
                                              ? null
                                              : progress.cumulativeBytesLoaded /
                                                  progress.expectedTotalBytes,
                                        ),
                                      ),
                                    ),
                                    pageController: null,
                                    backgroundDecoration:
                                        BoxDecoration(color: Colors.white),
                                    onPageChanged: (int index) {
                                      controller.selectedImage(index);
                                    },
                                  )),
                            )),

                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.4)),
                            height: 25,
                            width: 40,
                            child: Center(
                              child: Text(
                                args.product.images.length == 0
                                    ? '${controller.index + 1} '
                                            '/' +
                                        '${args.product.images.length + 1}'
                                    : '${controller.index + 1} '
                                            '/' +
                                        args.product.images.length.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Column(
                  children: [
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
                                    Obx(() {
                                      return IconButton(
                                          onPressed: () {
                                            controller
                                                .makeFavorite(args.product.id);

                                            homecontroller.fetchProduct();
                                          },
                                          icon: controller.initbool.value
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : Icon(Icons.favorite_border));
                                    }),
                                    IconButton(
                                        onPressed: () {
                                          Share.share('App link not available');
                                        },
                                        icon: Icon(Icons.share)),
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
                                InkWell(
                                  onTap: () => Scrollable.ensureVisible(
                                      dataKey.currentContext),
                                  child: Row(
                                    children: [
                                      ProductRating(
                                        rating: args.product.avaragereview,
                                        isReadOnly: true,
                                        size: 15,
                                        filledIconData: Icons.star,
                                        borderColor:
                                            Colors.red.withOpacity(0.8),
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
                                        ' / ' +
                                            '(${args.product.noOfReviews}) reviews',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: 'Seller:',
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: ' DmkMart',
                                          style: TextStyle(color: Colors.black))
                                    ])),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('View Shop',
                                        style: TextStyle(color: Colors.green)),
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
                                                    text:
                                                        ' Damak city: 1 to 3 Days',
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Specification',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  args.product.productSpecification.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '•',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            args
                                                .product
                                                .productSpecification[index]
                                                .point,
                                            overflow: TextOverflow.clip,
                                            style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ExpansionTile(
                          expandedAlignment: Alignment.topLeft,
                          title: Text(
                            'Product Details',
                            style: TextStyle(fontSize: 18),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                args.product.description,
                                style: GoogleFonts.ptSans(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            )
                          ],
                        )),
                    Obx(() {
                      if (!controller.isCommentsLoad.value)
                        return Container(
                          key: dataKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rating & Reviews (${controller.comments.length})',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Rate Product',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ...List.generate(
                                  controller.comments.length,
                                  (index) => !controller.isCommentsLoad.value
                                      ? Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(controller
                                                        .comments[index]
                                                        .comment),
                                                    Spacer(),
                                                    ProductRating(
                                                      rating: controller
                                                          .comments[index].rate
                                                          .toDouble(),
                                                      isReadOnly: true,
                                                      size: 12,
                                                      filledIconData:
                                                          Icons.star,
                                                      borderColor: Colors.red
                                                          .withOpacity(0.8),
                                                      color: Colors.red,
                                                      halfFilledIconData:
                                                          Icons.star_half,
                                                      defaultIconData:
                                                          Icons.star_border,
                                                      starCount: 5,
                                                      allowHalfRating: true,
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller.comments[index]
                                                          .user.username
                                                          .replaceAll(
                                                              '@gmail.com',
                                                              '*****'),
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.6)),
                                                    ),
                                                    Text(
                                                      ' | ' +
                                                          controller
                                                              .comments[index]
                                                              .whenpublished,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.6)),
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.thumb_up,
                                                          size: 12,
                                                          color: controller
                                                                      .comments[
                                                                          index]
                                                                      .like ==
                                                                  true
                                                              ? Colors.blue
                                                              : Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          controller.likeBtn(
                                                              controller
                                                                  .comments[
                                                                      index]
                                                                  .id,
                                                              args.product.id);
                                                        }),
                                                    Text(
                                                      controller.comments[index]
                                                                  .getTotalLikes ==
                                                              null
                                                          ? '0'
                                                          : controller
                                                              .comments[index]
                                                              .getTotalLikes
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.thumb_down,
                                                          size: 12,
                                                          color: controller
                                                                      .comments[
                                                                          index]
                                                                      .dislike ==
                                                                  true
                                                              ? Colors.blue
                                                              : Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          controller.dislikeBtn(
                                                              controller
                                                                  .comments[
                                                                      index]
                                                                  .id,
                                                              args.product.id);
                                                        }),
                                                    Text(
                                                      controller.comments[index]
                                                                  .getTotalDislikes ==
                                                              null
                                                          ? '0'
                                                          : controller
                                                              .comments[index]
                                                              .getTotalDislikes
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator())
                            ],
                          ),
                        );
                      else {
                        return SizedBox.shrink();
                      }
                    }),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.white.withOpacity(0.4),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'You may also like',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(child: Obx(() {
                      if (homecontroller.isLoading.value) {
                        final list = homecontroller.productList
                            .where((i) => i.category == args.product.category)
                            .toList();

                        return ProductGridviewTile(
                          productList: list,
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
                  ],
                ),
              )
            ]))
          ],
        ),
      ),
      bottomNavigationBar: AddToCard(
        product: args.product,
        onChanged: () {
          homecontroller.addToCard(args.product.id);
        },
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  ProductDetailsArguments({this.product});
}
