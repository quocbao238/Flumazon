import 'package:badges/badges.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/features/account/screens/account_screen.dart';
import 'package:flumazon/features/account/widgets/account_appbar.dart';
import 'package:flumazon/features/admin/widgets/account_appbar.dart';
import 'package:flumazon/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var _pageIndex = 0;
  final _bottomBarWidth = 42.0;
  final _bottomBarBorderWidth = 5.0;

  List<Widget> pages = [
    const Text('Posts Page'),
    const Text('Analytics Page'),
    const Text('Cart Page'),
  ];

  void onUpdatePage(int newIndex) {
    _pageIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: onUpdatePage,
        items: [
          // Posts Page
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _pageIndex == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: _bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),

          // Analytics
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _pageIndex == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: _bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ''),

          //Cart
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _pageIndex == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: _bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ''),
        ],
      ),
    );
  }
}
