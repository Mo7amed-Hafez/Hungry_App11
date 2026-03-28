import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.borderRadius,
    this.fontWeight,
  });

  final String title;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 60,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
        ),
        child: Center(
          child: CustomText(
            text: title,
            fontSize: 20,
            color: textColor ?? Colors.white,
            fontWeight: fontWeight ??  FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
