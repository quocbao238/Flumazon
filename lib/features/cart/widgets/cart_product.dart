import 'package:flumazon/models/cart.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  final CartModel cartModel;
  final VoidCallback? onPressedIncreaseQuantity;
  final VoidCallback? onPressedDecreaseQuantity;
  final VoidCallback? onPressedDelete;
  const CartProduct(
      {Key? key,
      required this.cartModel,
      this.onPressedIncreaseQuantity,
      this.onPressedDecreaseQuantity,
      this.onPressedDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.shortestSide / 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                color: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: Image.network(
                      cartModel.product!.images[0],
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.shortestSide / 4,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartModel.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '\$${cartModel.product!.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => onPressedDecreaseQuantity?.call(),
                          child: Container(
                            width: 48,
                            height: 24,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(96),
                                color: Colors.white),
                            child: Icon(Icons.remove,
                                size: 14.0, color: Colors.grey.shade400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(cartModel.quantity.toString()),
                        ),
                        GestureDetector(
                          onTap: () => onPressedIncreaseQuantity?.call(),
                          child: Container(
                            width: 48,
                            height: 24,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(96),
                                color: Colors.white),
                            child: Icon(Icons.add,
                                size: 14.0, color: Colors.grey.shade400),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => onPressedDelete?.call(),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(96),
                                color: Colors.white),
                            child: Icon(Icons.delete,
                                size: 14.0, color: Colors.grey.shade400),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
