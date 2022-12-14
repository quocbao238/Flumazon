import 'package:flumazon/common/widgets/loading_widget.dart';
import 'package:flumazon/features/admin/screens/add_product_screen.dart';
import 'package:flumazon/features/admin/services/admin_service.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  AdminService adminService = AdminService();
  List<ProductModel> listProducts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          listProducts.isEmpty
              ? const Center(
                  child: Text('Empty Product'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    _fetchAllProducts();
                  },
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1,
                              mainAxisSpacing: 16),
                      itemCount: listProducts.length,
                      itemBuilder: (_, index) {
                        final productItem = listProducts[index];
                        return Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          productItem.images[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          productItem.name,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ))
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () => _deleteProduct(
                                      context: context, product: productItem),
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.redAccent.shade100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
          if (_loading) const LoadingWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToProduct(context),
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, AddProductScreen.routeName)
        .then((value) => _fetchAllProducts());
  }

  void _fetchAllProducts() async {
    if (_loading == false) {
      setState(() => _loading = true);
    }
    final products = await adminService.fetchAllProducts(context);

    listProducts = products;
    setState(() => _loading = false);
  }

  void _deleteProduct(
      {required BuildContext context, required ProductModel product}) async {
    setState(() => _loading = true);

    await adminService.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          listProducts.remove(product);
        });
    setState(() => _loading = false);
  }
}
