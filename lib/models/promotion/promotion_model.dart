import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion_model.freezed.dart';
part 'promotion_model.g.dart';

@freezed
class PromotionModel with _$PromotionModel {
  const factory PromotionModel({
    required String id,
    required String title,
    required String description,
    @JsonKey(name: 'short_desc') required String shortDesc,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
  }) = _PromotionModel;

  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);
}