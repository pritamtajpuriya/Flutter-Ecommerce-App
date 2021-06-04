import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imageName;
  final String socialMedia;
  final Color color;
  SocialButton({this.imageName, this.socialMedia, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Image.asset(
          imageName,
          height: 20,
        )),
      ),
    );
  }
}
