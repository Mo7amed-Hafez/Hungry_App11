import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.rate,
  });

  final String image, title, desc, rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        elevation: 10,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(image, width: 120)),
              Gap(10),
              CustomText(
                text: title,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              CustomText(text: desc),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "⭐ $rate "),
                  Icon(Icons.favorite, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
