import 'package:flumazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

import 'product_item.dart';

class AccountOrderList extends StatefulWidget {
  const AccountOrderList({Key? key}) : super(key: key);

  @override
  State<AccountOrderList> createState() => _AccountOrderListState();
}

class _AccountOrderListState extends State<AccountOrderList> {
  //temp list
  List listOrders = [
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1546868871-0f936769675e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'See all',
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.shortestSide * 0.4,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: listOrders.length,
                  itemBuilder: ((context, index) => ProductItem(
                        imageUrl: listOrders[index],
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
