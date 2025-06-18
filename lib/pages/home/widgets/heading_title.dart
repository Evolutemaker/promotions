import 'package:flutter/material.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

class HeadingTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const HeadingTitle({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.text,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: Text(
              'все',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
