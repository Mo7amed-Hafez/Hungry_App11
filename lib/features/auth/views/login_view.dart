import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/app_stringes.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repository.dart';
import 'package:hungry_app/features/auth/widgets/custom_btn.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_textform.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo();
  bool _isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final user = await authRepo.login(
        emailController.text.trim(),
        passController.text.trim(),
      );

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/root');
      }
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "unknown error";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const Gap(10),
              Expanded(
                child: CustomText(
                  text: errorMsg,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.error,
          elevation: 6,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.text = 'mafia159@gmail.com';
    passController.text = '123456789';
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          child: SafeArea(
            bottom: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(24),

                  /// Modern Header Logo & Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppStringes.logo,
                          width: size.width * 0.6,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(12),
                        const CustomText(
                          text: "Welcome Back",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const Gap(4),
                        CustomText(
                          text: "Discover and order the best food around you",
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const Gap(32),

                  /// White Container Form Sheet
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CustomText(
                              text: "Sign In",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            const Gap(20),

                            CustomTextform(
                              controller: emailController,
                              isPassword: false,
                              hint: "Email address",
                              prefixIcon: CupertinoIcons.mail,
                            ),
                            const Gap(16),

                            CustomTextform(
                              controller: passController,
                              isPassword: true,
                              hint: "Password",
                              prefixIcon: CupertinoIcons.lock,
                            ),
                            const Gap(24),

                            _isLoading
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: CupertinoActivityIndicator(
                                        color: AppColors.primaryColor,
                                        radius: 14,
                                      ),
                                    ),
                                  )
                                : CustomAuthButton(
                                    text: "Sign In",
                                    onTap: login,
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    borderColor: Colors.transparent,
                                  ),
                            const Gap(12),

                            CustomAuthButton(
                              text: "Create an Account",
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                '/signup',
                              ),
                              color: Colors.white,
                              textColor: AppColors.primaryColor,
                              borderColor: AppColors.borderLight,
                            ),
                            const Gap(20),

                            /// Continue as Guest
                            Center(
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/root');
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_right_circle,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                label: const CustomText(
                                  text: "Continue as Guest",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const Gap(16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
