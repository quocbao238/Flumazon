import 'dart:convert';

import 'package:flumazon/constants/error_handling.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/models/product.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  Future<void> rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await http.post(Uri.parse('$uri/api/products/rating'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token ?? '',
          },
          body: jsonEncode({
            'id': product.id,
            'rating': rating,
          }));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            print("Success");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
