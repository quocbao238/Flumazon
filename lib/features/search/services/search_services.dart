import 'dart:convert';

import 'package:flumazon/constants/error_handling.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/models/product.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<ProductModel>> fetchSearchProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try {
      var response = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token ?? '',
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            productList = jsonDecode(response.body).map<ProductModel>((e) {
              return ProductModel.fromMap(e);
            }).toList();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }
}
