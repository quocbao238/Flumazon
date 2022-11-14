import 'dart:convert';

import 'package:flumazon/constants/error_handling.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/models/product.dart';
import 'package:flumazon/models/user_model.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  // decrement
  Future<void> removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token ?? '',
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            final newCart = UserModel.fromMap(jsonDecode(response.body)).cart;
            final user = userProvider.user.copyWith(cart: newCart);
            userProvider.setUser(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await http.delete(
        Uri.parse('$uri/api/delete-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token ?? '',
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            final newCart = UserModel.fromMap(jsonDecode(response.body)).cart;
            final user = userProvider.user.copyWith(cart: newCart);
            userProvider.setUser(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
