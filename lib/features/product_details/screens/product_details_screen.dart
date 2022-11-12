import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumazon/common/widgets/custom_button.dart';
import 'package:flumazon/common/widgets/ratting_stars.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/features/home/widgets/carousel_image.dart';
import 'package:flumazon/features/home/widgets/home_appbar.dart';
import 'package:flumazon/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details';
  final ProductModel product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: RattingStars(rating: 3.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: CarouselSlider(
                items: widget.product.images
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            e,
                            fit: BoxFit.fitHeight,
                          ),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  enableInfiniteScroll:
                      widget.product.images.length > 2 ? true : false,
                  autoPlay: widget.product.images.length > 2 ? true : false,
                  enlargeCenterPage:
                      widget.product.images.length > 2 ? false : true,
                  aspectRatio: 1.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),
            if (widget.product.images.length > 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : GlobalVariables.selectedNavBarColor)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            Divider(
              height: 8,
              thickness: 8,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '\$${widget.product.price}',
                          style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w500))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.product.description,
              ),
            ),
            Divider(
              height: 4,
              thickness: 2,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(title: 'Buy Now', onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                  title: 'Add to Cart',
                  color: const Color.fromRGBO(254, 216, 19, 1),
                  onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
