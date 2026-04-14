import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/auth_repository.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/root.dart';

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

    // 🎬 Animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    // ⏳ بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3),
      _checkLogin);
  }

  // 🔥 Auto Login Logic
  Future<void> _checkLogin() async {
    try {
      // ⛔ لو الصفحة اتقفلت متكملش
      if (!mounted) return;

      // 🟢 جيب التوكن الأول
      final token = await PrefHelpers.getToken();
      print("TOKEN => $token");

      // 🧠 تحديد الوجهة
      Widget nextScreen;

      if (authRepo.isGuest) {
        nextScreen =  Root();
      } else if (token != null) {
        nextScreen =  Root();
      } else {
        nextScreen = const LoginView();
      }

      // 🔁 Navigation
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextScreen),
        );
      }
    } catch (e) {
      print("Error in Splash => ${e.toString()}");

      // fallback لو حصل error
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
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const Gap(200),

            /// 🔷 Logo Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  "assets/images/logo.svg",
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),

            const Spacer(),

            /// 🔷 Bottom Image Animation
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  "assets/images/splach.png",
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ),

            const Gap(40),
          ],
        ),
      ),
    );
  }
}