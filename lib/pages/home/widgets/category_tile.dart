import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String vector;
  final void Function()? onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.vector,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
          border: Border.all(color: Color(0xFFCBD5E1), width: 0.5),
        ),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            SvgPicture.asset(vector, width: 35, height: 35),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
                height: 1,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
