import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.addToCart,
  });

  final String imageUrl;
  final String title;
  final Function() addToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.brown.shade500,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.shade600,
          //   blurRadius: 3,
          //   offset: Offset(5, 5),
          // ),
          BoxShadow(
            color: const Color.fromARGB(255, 100, 17, 17),
            blurRadius: 6,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 140,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
      
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
      
          // title and add to add button
          Spacer(),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(2),
                CustomText(text: title, fontSize: 19, color: Colors.white),
      
                IconButton(
                  onPressed: addToCart,
                  icon: Icon(
                    Icons.add_circle_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
