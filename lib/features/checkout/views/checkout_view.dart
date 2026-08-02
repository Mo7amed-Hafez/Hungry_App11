import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/checkout/widgets/order_detiles_widgets.dart';
import 'package:hungry_app/features/checkout/widgets/success_dailog.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedPaymentMethod = "Visa";
  bool saveCardDetails = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.arrow_left, color: AppColors.textPrimary),
        ),
        title: const CustomText(
          text: "Checkout",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Order Summary",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            const Gap(14),

            const OrderDetilesWidgets(
              order: "\$ 20.55",
              taxes: "\$ 2.50",
              deliveryFee: "\$ 2.50",
              total: "\$ 24.00",
            ),

            const Gap(28),
            const CustomText(
              text: "Payment Method",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            const Gap(14),

            /// Cash Payment Tile
            _buildPaymentTile(
              id: "Cash",
              title: "Cash on Delivery",
              subtitle: "Pay in cash upon food delivery",
              imagePath: "assets/cash/logoCash.png",
              bgColor: Colors.white,
            ),
            const Gap(12),

            /// Visa Payment Tile
            _buildPaymentTile(
              id: "Visa",
              title: "Debit / Credit Card",
              subtitle: "•••• •••• •••• 0505",
              imagePath: "assets/cash/visaLogo.png",
              bgColor: Colors.white,
            ),

            const Gap(16),
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    value: saveCardDetails,
                    onChanged: (v) {
                      setState(() {
                        saveCardDetails = v ?? true;
                      });
                    },
                  ),
                ),
                const Gap(10),
                const Expanded(
                  child: CustomText(
                    text: "Save card details for future payments",
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const Gap(120),
          ],
        ),
      ),

      /// Bottom Sheet Pay Now Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomText(
                    text: "Total Amount",
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 2),
                  CustomText(
                    text: "\$ 24.00",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                width: 180,
                height: 52,
                title: "Pay Now",
                icon: CupertinoIcons.lock_shield_fill,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogCtx) => SuccessDailog(
                      onClose: () {
                        Navigator.pop(dialogCtx);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required String id,
    required String title,
    required String subtitle,
    required String imagePath,
    required Color bgColor,
  }) {
    final isSelected = selectedPaymentMethod == id;

    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.textMuted,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 40,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  const Gap(2),
                  CustomText(
                    text: subtitle,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? CupertinoIcons.checkmark_circle_fill
                  : CupertinoIcons.circle,
              color: isSelected ? AppColors.primaryColor : AppColors.textMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
