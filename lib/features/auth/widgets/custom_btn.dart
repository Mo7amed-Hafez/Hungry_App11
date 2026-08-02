import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.borderColor,
    this.textColor,
    this.height = 54,
    this.borderRadius = 16,
  });

  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.white;
    final effectiveTextColor = textColor ?? AppColors.primaryColor;
    final effectiveBorder = borderColor ?? AppColors.primaryColor;
    final radius = BorderRadius.circular(borderRadius);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: effectiveColor,
        borderRadius: radius,
        border: Border.all(
          color: effectiveBorder,
          width: 1.5,
        ),
        boxShadow: effectiveColor != Colors.transparent && effectiveBorder == Colors.transparent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Center(
            child: CustomText(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: effectiveTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
