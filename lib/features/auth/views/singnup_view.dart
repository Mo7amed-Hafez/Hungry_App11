// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_btn.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_textform.dart';

class SingnupView extends StatefulWidget {
  const SingnupView({super.key});

  @override
  State<SingnupView> createState() => _SingnupViewState();
}

class _SingnupViewState extends State<SingnupView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmpassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


 // dispose function for controller to stop controlling and memory leak
@override
void dispose(){
  nameController.dispose();
  emailController.dispose();
  passController.dispose();
  confirmpassController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(70),
                SvgPicture.asset("assets/images/logo.svg"),
                Gap(20),
                CustomText(
                  text: "Welcome to Hungry App",
                  color: Colors.white,
                ),
                CustomText(
                  text: "Discover the best food, in the best places",
                  color: Colors.white,
                ),
                Gap(40),
          
                // Singnup form
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomTextform(
                          controller: nameController,
                          isPassword: false,
                          hint: "Name",
                        ),
                        Gap(20),
                        CustomTextform(
                          controller: emailController,
                          isPassword: false,
                          hint: "Email",
                        ),
                        Gap(20),
                        CustomTextform(
                          controller: passController,
                          isPassword: true,
                          hint: "Password",
                        ),
                        Gap(20),
          
                        CustomAuthButton(
                          text: "SIGN UP",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print('success sign up');
                            }
                          },
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                        Gap(5),
                        CustomAuthButton(
                          text: "Go to Login",
                          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                          
                          color: Colors.grey.shade300,
                          textColor: AppColors.primaryColor,
                          borderColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
