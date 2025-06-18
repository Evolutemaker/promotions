import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        fontFamily: 'Roboto',
        primaryColor: AppColors.primary,
        useMaterial3: true,
        dividerTheme: DividerThemeData(
          color: AppColors.divider,
          thickness: 0.5,
          space: 1,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
        ),
      );
}
