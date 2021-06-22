import 'package:flutter/material.dart';
import 'package:sajilo_dokan/config/theme.dart';

class CheckoutCart extends StatelessWidget {
  final totalAmount;
  CheckoutCart({this.totalAmount});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment',
                    style: CustomTextStyle.title,
                  ),
                  Text(
                    totalAmount.toString(),
                    style: CustomTextStyle.price,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  'Check Out',
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
