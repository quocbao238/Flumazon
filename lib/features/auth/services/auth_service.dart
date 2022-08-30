// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flumazon/common/widgets/tabs_page.dart';
import 'package:flumazon/constants/error_handling.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/features/home/screens/home_screen.dart';
import 'package:flumazon/models/user_model.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Singup User

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(email: email, password: password, name: name);

      var response = await http.post(
        Uri.parse('$uri/api/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: user.toJson(),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = UserModel(email: email, password: password);

      var response = await http.post(
        Uri.parse('$uri/api/signin'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: user.toJson(),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            UserModel userModel = UserModel.fromJson(response.body);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(userModel);
            await prefs.setString('x-auth-token', userModel.token ?? '');
            Navigator.pushNamedAndRemoveUntil(
                context, TabsPage.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        await prefs.setString('x-auth-token', '');
      }

      var response = await http.post(
        Uri.parse('$uri/api/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': token!
        },
      );

      bool validToken = jsonDecode(response.body);

      if (validToken) {
        var userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(UserModel.fromJson(userRes.body));
      }
    } catch (e) {
      debugPrint(e.toString());
      // showSnackBar(context, e.toString());
    }
  }
}
