import 'package:flumazon/features/home/services/home_services.dart';
import 'package:flumazon/features/product_details/screens/product_details_screen.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class HomeDealOfDayWidget extends StatefulWidget {
  const HomeDealOfDayWidget({Key? key}) : super(key: key);

  @override
  State<HomeDealOfDayWidget> createState() => _HomeDealOfDayWidgetState();
}

class _HomeDealOfDayWidgetState extends State<HomeDealOfDayWidget> {
  ProductModel? product;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  Future<void> fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigatorToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product!);
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16.0),
      child: GestureDetector(
        onTap: () => navigatorToDetailsScreen(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Deal of the day',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product!.images[0],
                  height: 235,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '\$${product!.price}',
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                product!.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
