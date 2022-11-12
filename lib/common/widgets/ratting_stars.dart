import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RattingStars extends StatelessWidget {
  final double rating;
  const RattingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      itemCount: 5,
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }
}
