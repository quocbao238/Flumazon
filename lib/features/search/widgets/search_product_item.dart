import 'package:flumazon/common/widgets/ratting_stars.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/features/product_details/screens/product_details_screen.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class SearchProductItem extends StatelessWidget {
  final ProductModel productModel;
  const SearchProductItem({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: productModel);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Center(
                        child: Image.network(
                          productModel.images[0],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          productModel.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const RattingStars(
                          rating: 4,
                        ),
                        Text(
                          '\$${productModel.price}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(productModel.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle()),
                        ),
                        Text(
                            productModel.quantity > 0
                                ? 'In stock'
                                : 'Out Stock',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: productModel.quantity > 0
                                    ? GlobalVariables.selectedNavBarColor
                                    : Colors.red)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
