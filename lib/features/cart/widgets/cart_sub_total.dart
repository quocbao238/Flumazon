import 'package:flutter/material.dart';

class CartSubTotal extends StatelessWidget {
  final String subTotal;
  const CartSubTotal({Key? key, required this.subTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text(
            'Subtotal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              subTotal,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
