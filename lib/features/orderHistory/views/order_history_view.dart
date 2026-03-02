import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView.builder(
          itemCount: 6,
          physics: const BouncingScrollPhysics(), // smooth scrolling
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  CustomButton(title: "Reorder", width: double.infinity, height: 60,)
                  ],
                ),
                
              ),
            );
          },
        ),
      ),
    );
  }
}
