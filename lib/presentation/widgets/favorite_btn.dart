import 'package:flutter/material.dart';

class FavoriteBTN extends StatelessWidget {
  final AnimationController? controller;
  final Animation? colorTween;
  final VoidCallback? onPress;
  FavoriteBTN({this.controller, this.onPress, this.colorTween});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (_, __) => IconButton(
              onPressed: onPress,
              icon: Icon(
                Icons.favorite,
                size: 20,
              ),
              color: Colors.red,
            ));
  }
}
