import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBoxWidget extends StatelessWidget {
  const AddressBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 144, 226, 221),
            Color.fromARGB(255, 162, 236, 233)
          ],
        ),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_drop_down_outlined,
            size: 18.0,
          )
        ],
      ),
    );
  }
}
