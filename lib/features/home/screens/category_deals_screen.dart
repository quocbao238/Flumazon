import 'package:flumazon/features/home/services/home_services.dart';
import 'package:flumazon/features/home/widgets/category_deals_appbar.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  HomeServices homeServices = HomeServices();

  List<ProductModel> listProducts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategoryProducts(context, widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryDealsAppBar(category: widget.category),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.topLeft,
              child: Text(
                'Keep shopping for ${widget.category}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 160,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: listProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (_, index) {
                    final productItem = listProducts[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(productItem.images[0]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            productItem.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchCategoryProducts(BuildContext context, String catergory) async {
    if (_loading == false) {
      setState(() => _loading = true);
    }
    final products = await homeServices.fetchCategoryProducts(
        context: context, category: catergory);

    listProducts = products;
    setState(() => _loading = false);
  }
}
