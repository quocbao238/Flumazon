import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flumazon/constants/error_handling.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/models/product.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double quantity,
    required double price,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dwfhfgzus', 'n7mtrg2d');
      List<String> imageUrls = [];

      for (var element in images) {
        var response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(element.path, folder: name));

        imageUrls.add(response.secureUrl);
      }

      ProductModel product = ProductModel(
          name: name,
          category: category,
          description: description,
          images: imageUrls,
          price: price,
          quantity: quantity);

      var response = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': userProvider.user.token ?? ''
          },
          body: product.toJson());

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all product

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try {
      var response = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token ?? ''
      });

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
