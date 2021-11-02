import 'package:flutter/material.dart';

class AddQuantity extends StatelessWidget {
  // add quantity of product to cart
  final VoidCallback? addButton;

  // subtract quantity of product to cart
  final VoidCallback? subtractButton;
  final int? noOfItem;
  AddQuantity({this.addButton, this.subtractButton, this.noOfItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              onPressed: subtractButton,
              child: Container(
                height: 30,
                width: 30,
                color: Colors.grey.withOpacity(0.1),
                child: Center(
                  child: Text('-',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Text(noOfItem.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Container(
                height: 30,
                width: 30,
                color: Colors.grey.withOpacity(0.1),
                child: Center(
                  child: Text('+',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
