import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/product.dart';

class ImageScreen extends StatelessWidget {
  final Product product;
  ImageScreen({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.white),
              imageProvider: NetworkImage('https://onlinehatiya.herokuapp.com' +
                  product.images[0].image),
              maxScale: PhotoViewComputedScale.covered * 2.0,
              minScale: PhotoViewComputedScale.contained * 0.8,
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
                    })),
            Positioned(
              bottom: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                      product.images.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Image.network(
                                  'https://onlinehatiya.herokuapp.com' +
                                      product.images[index].image),
                            ),
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
