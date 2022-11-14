import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    String calculateSubTotal() {
      double subTotal = 0;
      if (user.cart != null) {
        user.cart!
            .map((e) => subTotal +=
                (e.quantity!.toDouble() * (e.product?.price ?? 0.0)))
            .toList();
      }
      return '\$$subTotal';
    }

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
              calculateSubTotal(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
