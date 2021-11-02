import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SpecialOfferCard(
            image: "assets/images/Image Banner 2.png",
            category: "Smartphone",
            numOfBrands: 18,
            press: () {},
          ),
          SpecialOfferCard(
            image: "assets/images/Image Banner 3.png",
            category: "Fashion",
            numOfBrands: 24,
            press: () {},
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: GestureDetector(
            onTap: press,
            child: SizedBox(
              width: 242,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF343434).withOpacity(0.4),
                            Color(0xFF343434).withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      right: 10,
                      child: Text(
                        category,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
