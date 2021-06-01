import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';

class ImageScreen extends GetWidget<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    final ImageScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(() {
              return PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.white),
                imageProvider: NetworkImage(
                    'https://onlinehatiya.herokuapp.com' +
                        args.product.images[controller.selectedImage.value]
                            .image),
                maxScale: PhotoViewComputedScale.covered * 2.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                scaleStateController: controller.scaleStateController,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
              );
            }),
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
            Positioned(
              bottom: 40,
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
                                          color:
                                              controller.selectedImage.value ==
                                                      index
                                                  ? Colors.red
                                                  : Colors.black)),
                                  child: Image.network(
                                      'https://onlinehatiya.herokuapp.com' +
                                          args.product.images[index].image),
                                ),
                              ),
                            );
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageScreenArguments {
  final Product product;
  ImageScreenArguments({this.product});
}
