import 'package:flumazon/common/widgets/custom_button.dart';
import 'package:flumazon/features/cart/services/cart_services.dart';
import 'package:flumazon/features/cart/widgets/cart_product.dart';
import 'package:flumazon/features/cart/widgets/cart_sub_total.dart';
import 'package:flumazon/features/home/widgets/address_book.dart';
import 'package:flumazon/features/product_details/services/product_details_services.dart';
import 'package:flumazon/features/search/widgets/search_appbar.dart';
import 'package:flumazon/models/product.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(ProductModel product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(ProductModel product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final listCardProduct = user.cart ?? [];

    return Scaffold(
      appBar: const SearchAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBoxWidget(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  color: Colors.yellow[600],
                  title: 'Proceed to Buy (${user.cart?.length ?? 0})',
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 16,
                thickness: 2,
                color: Colors.grey.shade200,
              ),
            ),
            if (listCardProduct.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: listCardProduct.length,
                  itemBuilder: ((context, index) {
                    final cartProduct = listCardProduct[index];
                    return CartProduct(
                        cartModel: cartProduct,
                        onPressedDecreaseQuantity: () =>
                            decreaseQuantity(cartProduct.product!),
                        onPressedIncreaseQuantity: () =>
                            increaseQuantity(cartProduct.product!));
                  }))
          ],
        ),
      ),
    );
  }
}
