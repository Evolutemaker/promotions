import 'package:auto_route/auto_route.dart';
import 'package:promotions/navigation/app_route_paths.dart';
import 'package:promotions/pages/home/home_screen.dart';
import 'package:promotions/pages/promotion_detail/promotion_detail_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: AppRoutePaths.homePath,
      initial: true,
    ),
    AutoRoute(
      page: PromotionDetailRoute.page,
      path: AppRoutePaths.promotionDetailPath,
    ),
  ];
}
