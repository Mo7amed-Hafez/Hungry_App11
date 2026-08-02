import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  String _getSpicyText(double v) {
    if (v < 0.3) return "Mild 🥶";
    if (v < 0.7) return "Medium 🌶️";
    return "Extra Hot 🔥";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 130,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                'assets/details/pngwing 12.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Customize Spice Level",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                const Gap(4),
                CustomText(
                  text: "Adjust spicy level to your taste preference",
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  maxLines: 2,
                ),
                const Gap(8),

                /// Slider Control
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.primaryColor,
                    inactiveTrackColor: AppColors.borderLight,
                    thumbColor: AppColors.accentColor,
                    overlayColor: AppColors.accentColor.withValues(alpha: 0.15),
                    trackHeight: 6,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                  ),
                  child: Slider(
                    min: 0,
                    max: 1,
                    value: value,
                    onChanged: onChanged,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "🥶 Mild", fontSize: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomText(
                        text: _getSpicyText(value),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentColor,
                      ),
                    ),
                    const CustomText(text: "🔥 Hot", fontSize: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
