

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/views/singnup_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_btn.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_textform.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


@override
void dispose(){
  emailController.dispose();
  passController.dispose();
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
                  text: "Welcome Back, Discover the best food",
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
                          text: "Login",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print('success login up');
                            }
                          },
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                        Gap(10),
                        CustomAuthButton(
                          text: "Create an account ?",
                          onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                          
                          color: Colors.grey.shade300,
                          textColor: AppColors.primaryColor,
                          borderColor: Colors.transparent,
                        ),
          
                        // signup as a Guest
                        Gap(20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/root');
                          },
                          child: CustomText(
                            text: "Continue as a Guest",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
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
