import 'package:promotions/models/promotion/promotion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class PromotionService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  Future<List<PromotionModel>> getPromotions() async {
    try {
      final response = await _supabase
          .from('promotions')
          .select()
          .order('start_date', ascending: false);
      
      return response
          .map<PromotionModel>((json) => PromotionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Ошибка получения акций: $e');
    }
  }

  Future<PromotionModel> getPromotionById(String id) async {
    try {
      final response = await _supabase
          .from('promotions')
          .select()
          .eq('id', id)
          .single();
      
      return PromotionModel.fromJson(response);
    } catch (e) {
      throw Exception('Ошибка получения акции: $e');
    }
  }

  Future<List<PromotionModel>> searchPromotions(String query) async {
    try {
      final response = await _supabase
          .from('promotions')
          .select()
          .or('title.ilike.%$query%,description.ilike.%$query%')
          .order('start_date', ascending: false);
      
      return response
          .map<PromotionModel>((json) => PromotionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Ошибка поиска акций: $e');
    }
  }
}