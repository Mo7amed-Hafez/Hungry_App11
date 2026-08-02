import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF460A03);
  static const Color primaryLight = Color(0xFF7A1B11);
  static const Color primarySoft = Color(0xFFFBF2F1);
  static const Color accentColor = Color(0xFFFF523B);
  static const Color secondaryAccent = Color(0xFFFFB703);
  
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textMuted = Color(0xFF9E9EA7);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color borderLight = Color(0xFFECEEF2);
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5E0F07), Color(0xFF380702)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6B4A), Color(0xFFFF3B2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFAF6F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.02),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static final List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.25),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];
}