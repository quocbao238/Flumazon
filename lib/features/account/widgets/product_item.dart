import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  const ProductItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.35,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fitHeight,
          width: MediaQuery.of(context).size.shortestSide * 0.35,
        ),
      ),
    );
  }
}
