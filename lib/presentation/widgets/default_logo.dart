import 'package:flutter/material.dart';

class DefaultLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/logos/logo.png',
              height: 100,
            ),
          )),
    );
  }
}
