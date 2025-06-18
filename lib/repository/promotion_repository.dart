import 'package:promotions/models/promotion/promotion_model.dart';

abstract class PromotionRepository {
  Future<List<PromotionModel>> getPromotions();
  
  Future<PromotionModel?> getPromotionById(String id);
  
  Future<List<PromotionModel>> searchPromotions(String query);
  
  Future<List<PromotionModel>> refreshPromotions();
  
  Future<bool> isOnline();
}