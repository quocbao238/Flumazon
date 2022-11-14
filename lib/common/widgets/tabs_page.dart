import 'package:badges/badges.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/features/account/screens/account_screen.dart';
import 'package:flumazon/features/cart/screens/cart_screen.dart';
import 'package:flumazon/features/home/screens/home_screen.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  static const routeName = '/tabsPage';
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  var _pageIndex = 0;
  final _bottomBarWidth = 42.0;
  final _bottomBarBorderWidth = 5.0;

  List<Widget> pages = const [
    HomeScreen(),
    AccountScreen(),
    CartScreen(),
  ];

  void onUpdatePage(int newIndex) {
    _pageIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartLength = context.watch<UserProvider>().user.cart?.length ?? 0;

    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: onUpdatePage,
        items: [
          // Home
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
          // ACCOUNT

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
                child: const Icon(Icons.person),
              ),
              label: ''),
          // CART
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
                child: Badge(
                    elevation: 0,
                    badgeContent: Text(cartLength.toString()),
                    badgeColor: Colors.white,
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: '')
        ],
      ),
    );
  }
}
