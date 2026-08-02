import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class ToppingCard extends StatefulWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.addToCart,
  });

  final String imageUrl;
  final String title;
  final VoidCallback addToCart;

  @override
  State<ToppingCard> createState() => _ToppingCardState();
}

class _ToppingCardState extends State<ToppingCard> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 160,
      width: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAdded ? AppColors.primaryColor : AppColors.borderLight,
          width: isAdded ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Image Container
          Container(
            height: 75,
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),

          /// Title & Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text: widget.title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isAdded = !isAdded;
                  });
                  widget.addToCart();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isAdded ? AppColors.primaryColor : AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isAdded ? CupertinoIcons.checkmark : CupertinoIcons.add,
                    size: 14,
                    color: isAdded ? Colors.white : AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
