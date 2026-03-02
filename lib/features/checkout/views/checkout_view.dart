import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/checkout/widgets/order_detiles_widgets.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedPaymentMethod = "Visa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Order Summary",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              Gap(15),

              OrderDetilesWidgets(
                order: "20,5\$",
                taxes: "2,5\$",
                deliveryFee: "2,5\$",
                total: "24\$",
              ),

              Gap(50),
              CustomText(
                text: "Payment Method",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              Gap(20),

              // Payment Methods

              // Cash payment
              ListTile(
                onTap: () => setState(() => selectedPaymentMethod = "Cash"),
                tileColor: Color(0xff3C2F2F),
                title: Text(
                  "Cash on Delivery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: Image.asset("assets/cash/logoCash.png", width: 50),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "Cash",
                  groupValue: selectedPaymentMethod,
                  onChanged: (v) => setState(() => selectedPaymentMethod = v!),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
              Gap(10),

              // Visa payment
              ListTile(
                onTap: () => setState(() => selectedPaymentMethod = "Visa"),
                tileColor: Color.fromARGB(255, 47, 206, 224),
                title: Text(
                  "Debit Card",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: CustomText(
                  text: "35** **** **** 0505",
                  color: Colors.white,
                ),
                leading: Image.asset("assets/cash/visaLogo.png", width: 50),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "Visa",
                  groupValue: selectedPaymentMethod,
                  onChanged: (v) => setState(() => selectedPaymentMethod = v!),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
              ),

              Gap(5),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.red,
                    value: true,
                    onChanged: (v) {},
                  ),
                  CustomText(
                    text: "Save card details for future payments",
                    fontSize: 15,
                  ),
                ],
              ),
              Gap(150),
            ],
          ),
        ),
      ),

      // 🔹 BOTTOM SHEET for pay
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 1)),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(text: "Total", fontSize: 20),
                CustomText(text: "\$ 20.55", fontSize: 23),
              ],
            ),
            CustomButton(
              width: 180,
              title: "Pay Now",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (mafia) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 100,
                        ),
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(
                                    Icons.check,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                ),
                                CustomText(
                                  text: "Success",
                                  fontSize: 40,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text:
                                      'Your payment was successful.\nA receipt for this purchase has\n     been sent to your email.',
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),

                                CustomButton(
                                  onTap: () {
                                    Navigator.pop(mafia);
                                  },
                                  title: "Colse",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
