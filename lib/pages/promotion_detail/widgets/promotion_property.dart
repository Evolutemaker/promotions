import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

class PromotionProperty extends StatelessWidget {
  final String vectorIcon;
  final String text;

  const PromotionProperty({
    super.key,
    required this.vectorIcon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            SvgPicture.asset(vectorIcon),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.tertiary,
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
