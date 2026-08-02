import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
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
  double value = 0.5;
  bool isFavorite = false;

  final List<Map<String, String>> toppings = const [
    {"title": "Tomato", "image": "assets/details/tometo.png"},
    {"title": "Onions", "image": "assets/details/tometo.png"},
    {"title": "Pickles", "image": "assets/details/tometo.png"},
    {"title": "Bacon", "image": "assets/details/tometo.png"},
    {"title": "Cheese", "image": "assets/details/tometo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.arrow_left, color: AppColors.textPrimary),
        ),
        title: const CustomText(
          text: "Burger Details",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isFavorite ? Colors.red : AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Spicy Slider Section
            SpicySlider(
              value: value,
              onChanged: (v) {
                setState(() => value = v);
              },
            ),
            const Gap(28),

            /// Toppings Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(
                  text: "Choice of Toppings",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                CustomText(
                  text: "Select items",
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const Gap(14),

            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(toppings.length, (ind) {
                  final item = toppings[ind];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ToppingCard(
                      imageUrl: item["image"]!,
                      title: item["title"]!,
                      addToCart: () {},
                    ),
                  );
                }),
              ),
            ),
            const Gap(28),

            /// Side Options Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(
                  text: "Side Options",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                CustomText(
                  text: "Add extras",
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const Gap(14),

            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(toppings.length, (ind) {
                  final item = toppings[ind];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ToppingCard(
                      imageUrl: item["image"]!,
                      title: item["title"]!,
                      addToCart: () {},
                    ),
                  );
                }),
              ),
            ),
            const Gap(120),
          ],
        ),
      ),

      /// Bottom Add to Cart Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomText(
                    text: "Total Price",
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 2),
                  CustomText(
                    text: "\$ 20.55",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                width: 170,
                height: 52,
                title: "Add to Cart",
                icon: CupertinoIcons.cart_badge_plus,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.primaryColor,
                      content: Row(
                        children: const [
                          Icon(CupertinoIcons.checkmark_circle, color: Colors.white),
                          SizedBox(width: 10),
                          CustomText(
                            text: "Item added to your cart!",
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
