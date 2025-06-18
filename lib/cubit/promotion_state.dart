part of 'promotion_cubit.dart';

@freezed
class PromotionState with _$PromotionState {
  const factory PromotionState.initial() = _Initial;
  const factory PromotionState.loading() = _Loading;
  const factory PromotionState.promotionsLoaded(List<PromotionModel> promotions) = _Loaded;
  const factory PromotionState.promotionDetailLoaded(PromotionModel promotion) = _DetailLoaded;
  const factory PromotionState.error(String message) = _Error;
}