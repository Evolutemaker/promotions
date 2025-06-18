import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promotions/core/constants/app_constants.dart';
import 'package:promotions/core/utils/debouncer.dart';
import 'package:promotions/cubit/promotion_cubit.dart';
import 'package:promotions/navigation/app_router.dart';
import 'package:promotions/pages/home/widgets/category_tile.dart';
import 'package:promotions/pages/home/widgets/heading_title.dart';
import 'package:promotions/pages/home/widgets/home_appbar.dart';
import 'package:promotions/pages/home/widgets/promotion_card.dart';
import 'package:promotions/uikit/app_sizes.dart';
import 'package:promotions/uikit/colors/app_colors.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  late final Debouncer _searchDebouncer;

  @override
  void initState() {
    super.initState();
    _searchDebouncer = Debouncer(milliseconds: 500);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchDebouncer.dispose();
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchDebouncer.run(() {
      final query = searchController.text.trim();
      context.read<PromotionCubit>().searchPromotions(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: AppColors.bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: HomeAppbar(
          searchFocusNode: searchFocusNode,
          statusBarHeight: context.statusBarHeight,
          searchController: searchController,
        ),
        body: GestureDetector(
          onTap: () => searchFocusNode.unfocus(),
          child: BlocBuilder<PromotionCubit, PromotionState>(
            builder: (context, state) {
              return state.when(
                initial: () => Center(child: CupertinoActivityIndicator()),
                loading: () => Center(child: CupertinoActivityIndicator()),
                promotionsLoaded: (promotions) => RefreshIndicator(
                  onRefresh: () =>
                      context.read<PromotionCubit>().refreshPromotions(),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HeadingTitle(title: 'Категории', onTap: () {}),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 206,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6,
                            ),
                            itemCount: AppConstants.categoryTitles.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                title: AppConstants.categoryTitles[index],
                                vector: AppConstants.categoryVectors[index],
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HeadingTitle(title: 'Акции', onTap: () {}),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final promotion = promotions[index];
                            return Container(
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: index == promotions.length - 1
                                    ? 16 + context.bottomBarHeight
                                    : 10,
                              ),
                              child: PromotionCard(
                                promotion: promotion,
                                onTap: () {
                                  context.router.push(PromotionDetailRoute(
                                    promotionId: promotion.id,
                                  ));
                                },
                              ),
                            );
                          },
                          childCount: promotions.length,
                        ),
                      ),
                    ],
                  ),
                ),
                promotionDetailLoaded: (promotion) => SizedBox.shrink(),
                error: (error) => Center(child: Text(error.toString())),
              );
            },
          ),
        ),
      ),
    );
  }
}
