// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:sajilo_dokan/domain/model/product.dart';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    this.id,
    this.quantity,
    this.product,
    this.amount,
  });

  int id;
  int quantity;
  Product product;
  int amount;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product.toJson(),
        "amount": amount,
      };
}
