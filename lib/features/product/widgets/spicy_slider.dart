import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/details/pngwing 12.png', height: 230),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              CustomText(
                text:
                    "Customize Your Burger\n to Your Tastes.\n Ultimate Experience",
              ),

              Slider(
                min: 0,
                max: 1,
                value: value, // current slider value range from 0 to 1`
                onChanged: onChanged,
                inactiveColor: Colors.grey.shade300,
                activeColor: AppColors.primaryColor,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomText(text: "🥶"),
                  Gap(120),
                  CustomText(text: "🌶️"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
