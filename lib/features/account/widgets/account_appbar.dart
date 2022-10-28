import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountAppBar extends StatelessWidget with PreferredSizeWidget {
  const AccountAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 8,
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
              right: 16,
              bottom: 16.0),
          child: RichText(
            text: TextSpan(
                text: 'Hello, ',
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                      text: user.name,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500))
                ]),
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/amazon_in.png',
              width: 120,
              height: 45,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Icon(Icons.notifications_outlined),
          ),
          const Icon(Icons.search),
        ],
      ),
    );
  }
}
