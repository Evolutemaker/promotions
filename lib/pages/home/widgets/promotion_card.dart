import 'package:flutter/material.dart';
import 'package:promotions/core/network/network_checker.dart';
import 'package:promotions/models/promotion/promotion_model.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

class PromotionCard extends StatelessWidget {
  final bool isRounded;
  final void Function()? onTap;
  final PromotionModel promotion;

  const PromotionCard({
    super.key,
    this.isRounded = true,
    required this.promotion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: FutureBuilder<bool>(
        future: NetworkChecker().isConnected(),
        builder: (context, snapshot) {
          final isOnline = snapshot.data ?? false;
          
          return Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isRounded ? 8 : 0),
              color: !isOnline ? Colors.grey[300] : null,
            ),
            child: Stack(
              children: [
                if (isOnline)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(isRounded ? 8 : 0),
                    child: Image.network(
                      promotion.imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isRounded ? 8 : 0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotion.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        promotion.shortDesc,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
