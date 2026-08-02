import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SuccessDailog extends StatelessWidget {
  const SuccessDailog({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(alpha: 0.1),
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  size: 56,
                  color: AppColors.success,
                ),
              ),
            ),
            const Gap(20),
            const CustomText(
              text: "Order Confirmed!",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            const Gap(10),
            const CustomText(
              text: "Your payment was successful.\nA receipt for this purchase has been sent to your email.",
              fontSize: 14,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
              maxLines: 3,
              height: 1.4,
            ),
            const Gap(24),
            CustomButton(
              width: double.infinity,
              height: 52,
              title: "Back to Home",
              onTap: onClose ?? () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}