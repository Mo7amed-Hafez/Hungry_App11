import 'package:flutter/material.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.brown.shade500,
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: 150,

              child: Image.asset(imageUrl, fit: BoxFit.cover),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: title, fontSize: 20, color: Colors.white),

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
      ),
    );
  }
}
