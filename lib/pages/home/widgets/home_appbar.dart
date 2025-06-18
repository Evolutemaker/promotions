import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotions/uikit/colors/app_colors.dart';
import 'package:promotions/uikit/vectors/app_vectors.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode searchFocusNode;
  final double statusBarHeight;
  final TextEditingController searchController;
  final void Function()? onLocationTap;
  final void Function()? onNotificationTap;

  const HomeAppbar({
    super.key,
    required this.searchFocusNode,
    required this.statusBarHeight,
    required this.searchController,
    this.onLocationTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight,
        left: 16,
        right: 16,
      ),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        spacing: 8,
        children: [
          GestureDetector(
            onTap: onLocationTap,
            behavior: HitTestBehavior.translucent,
            child: SvgPicture.asset(AppVectors.location, width: 24, height: 24),
          ),
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                cursorColor: AppColors.primary,
                cursorHeight: 16,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 16),
                    child: SvgPicture.asset(
                      AppVectors.search,
                      alignment: Alignment.centerLeft,
                      width: 16,
                      height: 16,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(maxWidth: 42, minWidth: 42),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF8FAFC),
                  
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onLocationTap,
            behavior: HitTestBehavior.translucent,
            child: SvgPicture.asset(AppVectors.notification,
                width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(46 + statusBarHeight);
}
