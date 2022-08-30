import 'package:flumazon/features/account/widgets/account_header.dart';
import 'package:flumazon/features/account/widgets/accout_order_list.dart';
import 'package:flutter/material.dart';

import '../widgets/account_appbar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccountAppBar(),
      body: Column(
        children: const [
          AccountHeader(),
          AccountOrderList(),
        ],
      ),
    );
  }
}
