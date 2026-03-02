import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Column(
      children: [
        checkoutWidget('Order', order, false, false, false),
        Gap(10),
        checkoutWidget('Taxes', taxes, false, false, false),
        Gap(10),
        checkoutWidget('Delivery Fee', deliveryFee, false, false, false),
        Gap(15),
        Divider(thickness: 2),
        Gap(15),
        checkoutWidget('Total', total, false, true, true),
        Gap(15),
        checkoutWidget(
          'Estimated Delivery Time',
          "15 - 20 mins",
          true,
          true,
          true,
        ),
      ],
    );
  }
}

Widget checkoutWidget(title, price, isSmole, isBold, isBlack) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        fontSize: isSmole ? 15 : 17,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        color: isBlack ? Colors.black : Colors.grey.shade600,
      ),
      CustomText(
        text: price,
        fontSize: isSmole ? 15 : 17,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        color: isBlack ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
