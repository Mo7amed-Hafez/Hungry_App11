import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class OrderDetilesWidgets extends StatelessWidget {
  const OrderDetilesWidgets({
    super.key,
    required this.order,
    required this.taxes,
    required this.deliveryFee,
    required this.total,
  });

  final String order, taxes, deliveryFee, total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRow('Order Subtotal', order, false, false, AppColors.textSecondary),
          const Gap(10),
          _buildRow('Taxes & Fees', taxes, false, false, AppColors.textSecondary),
          const Gap(10),
          _buildRow('Delivery Fee', deliveryFee, false, false, AppColors.textSecondary),
          const Gap(14),
          const Divider(height: 1, color: AppColors.borderLight),
          const Gap(14),
          _buildRow('Total Amount', total, true, true, AppColors.primaryColor),
          const Gap(16),

          /// Delivery Time Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.clock_fill,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: "Estimated Delivery Time",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                CustomText(
                  text: "15 - 20 mins",
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String price, bool isBold, bool isLarge, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: isLarge ? 16 : 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
        ),
        CustomText(
          text: price,
          fontSize: isLarge ? 18 : 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: textColor,
        ),
      ],
    );
  }
}
