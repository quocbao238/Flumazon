import 'package:flumazon/features/home/widgets/address_book.dart';
import 'package:flumazon/features/home/widgets/carousel_image.dart';
import 'package:flumazon/features/home/widgets/categories.dart';
import 'package:flumazon/features/home/widgets/deal_of_day.dart';
import 'package:flumazon/features/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          const AddressBoxWidget(),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: const [
                  HomeTopCategoriesWidget(),
                  HomeCarouselImageWidget(),
                  HomeDealOfDayWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
