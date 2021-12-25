import 'package:flutter/material.dart';
import 'package:sajilo_dokan/package/carousel.dart';

// import 'package:sajilo_dokan/package/carousel.dart';
class SajiloCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 150.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Carousel(
          overlayShadow: false,
          borderRadius: true,
          boxFit: BoxFit.none,
          autoplay: true,
          dotSize: 4,
          images: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://icms-image.slatic.net/images/ims-web/3296ad03-9722-482c-a557-3687c71d9d1f.jpg_1200x1200.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://icms-image.slatic.net/images/ims-web/0375b5b5-9a1d-4009-8944-f3825d52a117.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://icms-image.slatic.net/images/ims-web/7aae4f19-f83b-44e3-9955-86d12746252a.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://icms-image.slatic.net/images/ims-web/715e6508-73c6-4003-8575-1f1e1dbd0e76.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://icms-image.slatic.net/images/ims-web/934ef866-8368-49f4-9dc7-cdba33eaf81a.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
