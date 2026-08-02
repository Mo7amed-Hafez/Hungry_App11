import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/cart/widgets/cart_item.dart';
import 'package:hungry_app/features/checkout/views/checkout_view.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 3;
  late List<int> quantity;

  @override
  void initState() {
    super.initState();
    quantity = List.generate(itemCount, (_) => 1);
  }

  void onAdd(int index) {
    setState(() {
      quantity[index]++;
    });
  }

  void onMinus(int index) {
    setState(() {
      if (quantity[index] > 1) {
        quantity[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: "My Cart",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: ListView.builder(
          itemCount: itemCount,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return CartItem(
              image: "assets/test/image 6.png",
              text: "Spicy Deluxe Burger",
              desc: "Veggie Patty & Cheddar Cheese",
              quantityNum: quantity[index],
              onAdd: () => onAdd(index),
              onMinus: () => onMinus(index),
              onRemove: () {},
            );
          },
        ),
      ),
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
              color: Colors.black.withValues(alpha: 0.4),
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
                title: "Checkout",
                icon: CupertinoIcons.arrow_right,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutView()),
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
