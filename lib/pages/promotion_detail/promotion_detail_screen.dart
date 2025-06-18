import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promotions/core/utils/date_period.dart';
import 'package:promotions/core/utils/share_helper.dart';
import 'package:promotions/cubit/promotion_cubit.dart';
import 'package:promotions/pages/home/widgets/promotion_card.dart';
import 'package:promotions/pages/promotion_detail/widgets/promotion_appbar.dart';
import 'package:promotions/pages/promotion_detail/widgets/promotion_property.dart';
import 'package:promotions/uikit/app_sizes.dart';
import 'package:promotions/uikit/colors/app_colors.dart';
import 'package:promotions/uikit/vectors/app_vectors.dart';

@RoutePage()
class PromotionDetailScreen extends StatefulWidget {
  final String promotionId;
  const PromotionDetailScreen({super.key, required this.promotionId});

  @override
  State<PromotionDetailScreen> createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PromotionCubit()..loadPromotionById(widget.promotionId),
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.bgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PromotionAppbar(statusBarHeight: context.statusBarHeight),
          body: BlocBuilder<PromotionCubit, PromotionState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                promotionsLoaded: (promotions) => const SizedBox.shrink(),
                promotionDetailLoaded: (promotion) => SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      PromotionCard(
                        isRounded: false,
                        promotion: promotion,
                        onTap: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PromotionProperty(
                          vectorIcon: AppVectors.paper,
                          text: promotion.description,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PromotionProperty(
                          vectorIcon: AppVectors.calendar,
                          text: datePeriod(
                              promotion.startDate, promotion.endDate),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ShareHelper.sharePromotion(promotion);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Поделиться',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                error: (error) => Center(child: Text(error.toString())),
              );
            },
          ),
        ),
      ),
    );
  }
}
