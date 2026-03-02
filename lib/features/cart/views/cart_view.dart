import 'package:flutter/material.dart';
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
  // علشان اتحكم في كميه كل حاجه لوحدها
  final int itemCount = 20;
  late List<int> quantity;

  @override
  void initState() {
    super.initState();
    quantity = List.generate(itemCount, (_) => 1);
  }

  void onAdd(index) {
    setState(() {
      quantity[index]++;
    });
  }

  void onMinus(index) {
    setState(() {
      if (quantity[index] > 1) {
        quantity[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),

      // 🔹 SCROLLABLE CART ITEMS (BEST PRACTICE)
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView.builder(
          itemCount: itemCount,
          physics: const BouncingScrollPhysics(), // smooth scrolling
          itemBuilder: (context, index) {
            return CartItem(
              image: "assets/test/image 6.png",
              text: "Spicy Burger",
              desc: "Vaggie Burger",
              quantityNum: quantity[index],
              onAdd: () {
                onAdd(index);
              },
              onMinus: () {
                onMinus(index);
              },
            );
          },
        ),
      ),

      // 🔹 FIXED CHECKOUT SECTION
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(text: "Total", fontSize: 20),
                CustomText(text: "\$ 20.55", fontSize: 23),
              ],
            ),
            CustomButton(
              title: "Checkout",
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
    );
  }
}
