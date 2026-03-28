import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.quantityNum,
  });

  final String image, text, desc;
  final int quantityNum;

  final Function()? onAdd, onMinus, onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor,
            blurRadius: 5,
            offset: Offset(3, 3),
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
        children: [
          // image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, height: 100),
              CustomText(text: text, fontSize: 18, fontWeight: FontWeight.bold),
              CustomText(text: desc),
            ],
          ),
      
          // details
          Column(
            children: [
              // quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // remove
                  ElevatedButton(
                    onPressed: onMinus,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: AppColors.primaryColor,
                      disabledBackgroundColor: AppColors.primaryColor,
                      iconSize: 30,
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                  CustomText(text: quantityNum.toString(), fontSize: 25),
                  // Add
                  ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      disabledBackgroundColor: AppColors.primaryColor,
                      backgroundColor: AppColors.primaryColor,
                      iconSize: 27,
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
      
              Gap(10),
              // Button remove
              ElevatedButton(
                onPressed: onRemove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  disabledBackgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(60, 50),
                ),
      
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
