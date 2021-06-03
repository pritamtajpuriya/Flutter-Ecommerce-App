import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';

class ImageScreen extends GetWidget<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    final ImageScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                // PhotoView(
                //   backgroundDecoration: BoxDecoration(color: Colors.white),
                //   imageProvider: NetworkImage(
                //       'https://onlinehatiya.herokuapp.com' +
                //           args.product.images[controller.selectedImage.value]
                //               .image),
                //   maxScale: PhotoViewComputedScale.covered * 2.0,
                //   minScale: PhotoViewComputedScale.contained * 0.8,
                //   initialScale: PhotoViewComputedScale.contained * 0.8,
                //   scaleStateController: controller.controllerState,
                //   loadingBuilder: (context, progress) => Center(
                //     child: Container(
                //       width: 20.0,
                //       height: 20.0,
                //       child: CircularProgressIndicator(
                //         value: progress == null
                //             ? null
                //             : progress.cumulativeBytesLoaded /
                //                 progress.expectedTotalBytes,
                //       ),
                //     ),
                //   ),
                // ),
                if (controller.selectedImage.value != null)
                  //This if condition not neccesory but in builder there must be Obserable value to use Obx Or Getx
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                            args.product.images.length == 0
                                ? 'https://onlinehatiya.herokuapp.com' +
                                    args.product.image
                                : 'https://onlinehatiya.herokuapp.com' +
                                    args
                                        .product
                                        .images[controller.selectedImage.value]
                                        .image),
                        maxScale: PhotoViewComputedScale.covered * 2.0,
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        scaleStateController: controller.controllerState,
                      );
                    },
                    itemCount: args.product.images.length,
                    loadingBuilder: (context, progress) => Center(
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
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                    onPageChanged: (int index) {
                      controller.selectedImage(index);
                    },
                  ),

                Positioned(
                    top: 40,
                    right: 40,
                    child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.goBack();
                        })),
              ],
            );
          })),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ...List.generate(
                  args.product.images.length,
                  (index) => Obx(() {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              controller.selectedImage(index);
                              controller.goBack();
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: controller.selectedImage.value ==
                                              index
                                          ? Colors.red
                                          : Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.network(
                                    'https://onlinehatiya.herokuapp.com' +
                                        args.product.images[index].image),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class ImageScreenArguments {
  final Product product;
  ImageScreenArguments({this.product});
}
