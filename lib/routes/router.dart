import 'package:flumazon/common/widgets/tabs_page.dart';
import 'package:flumazon/features/admin/screens/add_product_screen.dart';
import 'package:flumazon/features/auth/screens/auth_screen.dart';
import 'package:flumazon/features/home/screens/category_deals_screen.dart';
import 'package:flumazon/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case TabsPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const TabsPage());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: (routeSettings.arguments as String),
              ));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist!'),
                ),
              ));
  }
}
