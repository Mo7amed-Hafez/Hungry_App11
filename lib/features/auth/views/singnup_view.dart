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

class SingnupView extends StatefulWidget {
  const SingnupView({super.key});

  @override
  State<SingnupView> createState() => _SingnupViewState();
}

class _SingnupViewState extends State<SingnupView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  Future<void> singnup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await authRepo.singnup(
        nameController.text.trim(),
        emailController.text.trim(),
        passController.text.trim(),
      );

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "Error in Signup";
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
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmpassController.dispose();
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
                  const Gap(20),

                  /// Header Logo & Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppStringes.logo,
                          width: size.width * 0.55,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(8),
                        const CustomText(
                          text: "Create Account",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const Gap(4),
                        CustomText(
                          text: "Join Hungry App to explore mouth-watering meals",
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.8),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const Gap(24),

                  /// White Form Sheet Container
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
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
                              text: "Fill in your details",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            const Gap(16),

                            CustomTextform(
                              controller: nameController,
                              isPassword: false,
                              hint: "Full Name",
                              prefixIcon: CupertinoIcons.person,
                            ),
                            const Gap(14),

                            CustomTextform(
                              controller: emailController,
                              isPassword: false,
                              hint: "Email Address",
                              prefixIcon: CupertinoIcons.mail,
                            ),
                            const Gap(14),

                            CustomTextform(
                              controller: passController,
                              isPassword: true,
                              hint: "Password",
                              prefixIcon: CupertinoIcons.lock,
                            ),
                            const Gap(24),

                            isLoading
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
                                    text: "Sign Up",
                                    onTap: singnup,
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    borderColor: Colors.transparent,
                                  ),
                            const Gap(12),

                            CustomAuthButton(
                              text: "Already have an account? Sign In",
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                '/login',
                              ),
                              color: Colors.white,
                              textColor: AppColors.primaryColor,
                              borderColor: AppColors.borderLight,
                            ),
                            const Gap(20),
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
