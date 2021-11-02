import 'package:flutter/material.dart';

class ItemNuber extends StatelessWidget {
  final int? itemNumber;
  ItemNuber({this.itemNumber});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Your Cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '${(itemNumber)} Items',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
