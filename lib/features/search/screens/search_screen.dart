import 'package:flumazon/common/widgets/loading_widget.dart';
import 'package:flumazon/features/home/widgets/address_book.dart';
import 'package:flumazon/features/search/services/search_services.dart';
import 'package:flumazon/features/search/widgets/search_appbar.dart';
import 'package:flumazon/features/search/widgets/search_product_item.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-Screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();

  List<ProductModel> listProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoryProducts(context, widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SearchAppBar(),
        body: listProducts.isEmpty
            ? const LoadingWidget()
            : Column(
                children: [
                  const AddressBoxWidget(),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          itemCount: listProducts.length,
                          itemBuilder: (context, index) {
                            return SearchProductItem(
                              productModel: listProducts[index],
                            );
                          }))
                ],
              ));
  }

  void _fetchCategoryProducts(BuildContext context, String searchQuery) async {
    final products = await searchServices.fetchSearchProducts(
        context: context, searchQuery: searchQuery);
    listProducts = products;
    setState(() {});
  }
}
