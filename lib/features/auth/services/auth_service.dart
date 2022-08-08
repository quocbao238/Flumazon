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
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false)
                .setUser(userModel);
            await prefs.setString('x-auth-token', userModel.token ?? '');

            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
