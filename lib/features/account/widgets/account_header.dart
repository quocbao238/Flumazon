import 'package:flumazon/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: const [
              AccountButton(title: 'Your Orders'),
              AccountButton(title: 'Turn Seller'),
            ],
          ),
          Row(
            children: const [
              AccountButton(title: 'Log Out'),
              AccountButton(title: 'Your Wish List'),
            ],
          ),
        ],
      ),
    );
  }
}
