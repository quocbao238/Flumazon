import 'package:flumazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class HomeTopCategoriesWidget extends StatelessWidget {
  const HomeTopCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 64,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemExtent: 85,
          itemBuilder: ((context, index) {
            final itemCategory = GlobalVariables.categoryImages[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      itemCategory['image']!,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    itemCategory['title']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
