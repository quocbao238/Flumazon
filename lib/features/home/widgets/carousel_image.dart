import 'package:carousel_slider/carousel_slider.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class HomeCarouselImageWidget extends StatelessWidget {
  const HomeCarouselImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
          autoPlay: true,
        ),
        items: GlobalVariables.carouselImages
            .map((e) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                ))
            .toList(),
      ),
    );
  }
}
