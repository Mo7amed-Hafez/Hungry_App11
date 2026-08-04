import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/app_stringes.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/auth_repository.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  final AuthRepo authRepo = AuthRepo();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), _checkLogin);
  }

  Future<void> _checkLogin() async {
    try {
      if (!mounted) return;

      final token = await PrefHelpers.getToken();

      Widget nextScreen;

      if (authRepo.isGuest) {
        nextScreen = Root();
      } else if (token != null) {
        nextScreen = Root();
      } else {
        nextScreen = const LoginView();
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (_, animation, __) => FadeTransition(
              opacity: animation,
              child: nextScreen,
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(40),

              /// Logo & Slogan Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppStringes.logo,
                        width: size.width * 0.8,
                      ),
                      const Gap(16),
                      CustomText(
                        text: "Delicious Food Delivered Fast",
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                      ),
                    ],
                  ),
                ),
              ),

              /// Bottom Image Animation & Loading Indicator
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/splach.png",
                        width: size.width * 0.85,
                        fit: BoxFit.contain,
                      ),
                      const Gap(24),
                      SizedBox(
                        width: 40,
                        height: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: const LinearProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.white24,
                          ),
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}