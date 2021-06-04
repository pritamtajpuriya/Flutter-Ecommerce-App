import 'dart:convert';

import 'package:sajilo_dokan/domain/model/user.dart';

List<ProductComment> productCommentFromJson(String str) =>
    List<ProductComment>.from(
        json.decode(str).map((x) => ProductComment.fromJson(x)));

class ProductComment {
  ProductComment({
    this.user,
    this.comment,
    this.rate,
  });

  User user;
  String comment;
  int rate;

  factory ProductComment.fromJson(Map<String, dynamic> json) => ProductComment(
      user: User.fromJson(json["user"]),
      comment: json["comment"],
      rate: json["rate"]);
}
