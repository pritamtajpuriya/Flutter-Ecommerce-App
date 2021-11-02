// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product(
      {this.id,
      this.title,
      this.keywords,
      this.description,
      this.image,
      this.price,
      this.slug,
      this.category,
      this.avaragereview,
      this.noOfReviews,
      this.images,
      this.favorite,
      this.productSpecification});

  int? id;
  String? title;
  String? keywords;
  String? description;
  String? image;
  double? price;
  String? slug;
  String? category;
  double? avaragereview;
  int? noOfReviews;
  List<Images>? images;
  bool? favorite;
  List<ProductSpecification>? productSpecification;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      title: json["title"],
      keywords: json["keywords"],
      description: json["description"],
      image: json["image"],
      price: json["price"].toDouble(),
      slug: json["slug"],
      category: json["category"],
      avaragereview: json["avaragereview"].toDouble(),
      noOfReviews: json["no_of_reviews"],
      images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
      favorite: json["favorite"],
      productSpecification: List<ProductSpecification>.from(
          json["productSpecification"]
              .map((x) => ProductSpecification.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "keywords": keywords,
        "description": description,
        "image": image,
        "price": price,
        "slug": slug,
        "category": category,
        "avaragereview": avaragereview,
        "no_of_reviews": noOfReviews,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "favorite": favorite,
      };
}

class Images {
  Images({
    this.image,
  });

  String? image;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class ProductSpecification {
  ProductSpecification({
    this.point,
  });

  String? point;

  factory ProductSpecification.fromJson(Map<String, dynamic> json) =>
      ProductSpecification(
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "point": point,
      };
}
