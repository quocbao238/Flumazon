// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'package:flumazon/models/product.dart';

class CartModel {
  CartModel({
    this.product,
    this.quantity,
    this.id,
  });

  ProductModel? product;
  int? quantity;
  String? id;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        product: json["product"] == null
            ? null
            : ProductModel.fromMap(json["product"]),
        quantity: json["quantity"] == null ? null : json["quantity"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "quantity": quantity == null ? null : quantity,
        "_id": id == null ? null : id,
      };
}
