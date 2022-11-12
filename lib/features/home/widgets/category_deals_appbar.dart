import 'package:flumazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryDealsAppBar extends StatelessWidget with PreferredSizeWidget {
  final String category;
  const CategoryDealsAppBar({Key? key, required this.category})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Text(
        category,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
