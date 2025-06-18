import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotions/uikit/colors/app_colors.dart';
import 'package:promotions/uikit/vectors/app_vectors.dart';

class PromotionAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double statusBarHeight;

  const PromotionAppbar({super.key, required this.statusBarHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.router.pop(),
            behavior: HitTestBehavior.translucent,
            child: SvgPicture.asset(
              AppVectors.left,
              width: 32,
              height: 32,
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            'Акции',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          SizedBox.square(dimension: 32),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40 + statusBarHeight);
}
