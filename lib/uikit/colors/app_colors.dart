import 'package:flutter/painting.dart';

abstract class AppColors {
  static const Gradient bgGradient = LinearGradient(
    colors: [
      Color(0xFFFFFCF5),
      Color(0xFFEAF4FE),
    ],
  );
  static const Color text = Color(0xFF020617);
  static const Color primary = Color(0xFF3D76F2);
  static const Color white = Color(0xFFFFFFFF);
  static Color tertiary = Color(0xFF020617).withValues(alpha: 0.7);
  static const Color divider = Color(0xFF94A3B8);

  static const Color error = Color(0xFFD92D20);
}
