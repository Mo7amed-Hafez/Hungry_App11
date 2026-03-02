import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/product/widgets/spicy_slider.dart';
import 'package:hungry_app/features/product/widgets/topping_card.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  // local variables (Logic)
  double value = 0.5; // علشان متغير للتحكم في قيمة الاسليدر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image and SpicySlider
              SpicySlider(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
              ),

              // Toppings
              Gap(20),
              CustomText(text: "Toppings", fontSize: 25),
              Gap(20),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (ind) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ToppingCard(
                        imageUrl: 'assets/details/tometo.png',
                        title: 'Tomato',
                        addToCart: () {},
                      ),
                    );
                  }),
                ),
              ),

              // Side Options
              Gap(50),
              CustomText(text: "Side Options", fontSize: 25),
              Gap(20),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (ind) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ToppingCard(
                        imageUrl: 'assets/details/tometo.png',
                        title: 'Tomato',
                        addToCart: () {},
                      ),
                    );
                  }),
                ),
              ),

              // Add to cart
              Gap(150),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 1)),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Total", fontSize: 25),
                CustomText(text: "\$ 20,55", fontSize: 28),
              ],
            ),
            CustomButton(title: "Add to Cart", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
