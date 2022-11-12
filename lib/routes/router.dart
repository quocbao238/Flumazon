import 'package:flumazon/common/widgets/tabs_page.dart';
import 'package:flumazon/features/account/widgets/product_item.dart';
import 'package:flumazon/features/admin/screens/add_product_screen.dart';
import 'package:flumazon/features/auth/screens/auth_screen.dart';
import 'package:flumazon/features/home/screens/category_deals_screen.dart';
import 'package:flumazon/features/home/screens/home_screen.dart';
import 'package:flumazon/features/product_details/screens/product_details_screen.dart';
import 'package:flumazon/features/search/screens/search_screen.dart';
import 'package:flumazon/models/product.dart';
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
    case SearchScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: routeSettings.arguments as String,
              ));
    case CategoryDealsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: (routeSettings.arguments as String),
              ));

    case ProductDetailsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: (routeSettings.arguments as ProductModel),
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
