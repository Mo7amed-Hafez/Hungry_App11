import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),

      body: ListView.builder(
        itemCount: 6,
        physics: const BouncingScrollPhysics(), // smooth scrolling
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor,
                  blurRadius: 5,
                  offset: Offset(3,3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // image
                    Image.asset("assets/test/image 6.png", height: 100),
      
                    // details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Spicy Burger"),
                        CustomText(text: "Qty: 2"),
                        CustomText(text: "Price: 5\$"),
                      ],
                    ),
                  ],
                ),
      
                Gap(20),
                CustomButton(
                  title: "Reorder",
                  width: double.infinity,
                  height: 60,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
