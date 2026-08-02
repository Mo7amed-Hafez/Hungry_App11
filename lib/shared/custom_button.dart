import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.height = 54,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderRadius = 16,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.gradient,
    this.fontSize = 16,
  });

  final String title;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final IconData? icon;
  final Gradient? gradient;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primaryColor;
    final effectiveGradient = gradient ?? (color == null && borderColor == null ? AppColors.primaryGradient : null);
    final effectiveRadius = BorderRadius.circular(borderRadius ?? 16);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveGradient == null ? effectiveColor : null,
        gradient: effectiveGradient,
        borderRadius: effectiveRadius,
        border: borderColor != null ? Border.all(color: borderColor!, width: 1.5) : null,
        boxShadow: onTap != null && borderColor == null
            ? [
                BoxShadow(
                  color: (color ?? AppColors.primaryColor).withValues(alpha: 0.22),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: effectiveRadius,
        child: InkWell(
          borderRadius: effectiveRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor ?? Colors.white, size: 20),
                  const SizedBox(width: 8),
                ],
                CustomText(
                  text: title,
                  fontSize: fontSize,
                  color: textColor ?? Colors.white,
                  fontWeight: fontWeight,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
