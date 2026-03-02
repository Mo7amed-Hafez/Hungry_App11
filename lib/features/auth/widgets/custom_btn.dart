import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.borderColor, this.textColor,
  });

  final String text;
  final Function onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor ?? AppColors.primaryColor,
            width: 2,
          ),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
