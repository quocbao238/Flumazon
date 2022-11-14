// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flumazon/models/cart.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? address;
  String? type;
  String? token;
  List<CartModel>? cart;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.type,
    this.token,
    this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      // cart: map['cart'] != null
      //     ? List<CartModel>.from(map['cart']?.map((x) => CartModel.fromJson(x)))
      //     : null,
      cart: map["cart"] == null
          ? null
          : List<CartModel>.from(map["cart"].map((x) {
              print(x);
              return CartModel.fromJson(x);
            })),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<CartModel>? cart,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
