import 'dart:developer';

import 'package:drift/drift.dart';
import '../config/database_config.dart';
import '../models/promotion/promotion_model.dart';

class StorageService {
  late final AppDatabase _database;

  StorageService() {
    _database = AppDatabase();
  }

  Future<List<PromotionModel>> getPromotions() async {
    try {
      final promotions = await _database.select(_database.promotions).get();
      return promotions.map((p) => _convertToModel(p)).toList();
    } catch (e) {
      log('Ошибка получения акций: $e');
      return [];
    }
  }

  Future<PromotionModel?> getPromotionById(String id) async {
    try {
      final query = _database.select(_database.promotions)
        ..where((tbl) => tbl.id.equals(id));
      
      final promotion = await query.getSingleOrNull();
      return promotion != null ? _convertToModel(promotion) : null;
    } catch (e) {
      log('Ошибка получения акции по ID: $e');
      return null;
    }
  }

  Future<List<PromotionModel>> searchPromotions(String query) async {
    try {
      final searchQuery = _database.select(_database.promotions)
        ..where((tbl) => 
          tbl.title.like('%$query%') | 
          tbl.description.like('%$query%') |
          tbl.shortDesc.like('%$query%')
        );
      
      final promotions = await searchQuery.get();
      return promotions.map((p) => _convertToModel(p)).toList();
    } catch (e) {
      log('Ошибка поиска акций: $e');
      return [];
    }
  }

  Future<void> savePromotion(PromotionModel promotion) async {
    try {
      await _database.into(_database.promotions).insertOnConflictUpdate(
        _convertToCompanion(promotion)
      );
    } catch (e) {
      log('Ошибка сохранения акции: $e');
    }
  }

  Future<void> savePromotions(List<PromotionModel> promotions) async {
    try {
      await _database.batch((batch) {
        batch.insertAllOnConflictUpdate(
          _database.promotions,
          promotions.map((p) => _convertToCompanion(p)).toList(),
        );
      });
    } catch (e) {
      log('Ошибка массового сохранения акций: $e');
    }
  }

  Future<void> clearPromotions() async {
    try {
      await _database.delete(_database.promotions).go();
    } catch (e) {
      log('Ошибка очистки акций: $e');
    }
  }

  Future<bool> promotionExists(String id) async {
    try {
      final query = _database.select(_database.promotions)
        ..where((tbl) => tbl.id.equals(id));
      
      final promotion = await query.getSingleOrNull();
      return promotion != null;
    } catch (e) {
      log('Ошибка проверки существования акции: $e');
      return false;
    }
  }

  PromotionModel _convertToModel(Promotion promotion) {
    return PromotionModel(
      id: promotion.id,
      title: promotion.title,
      description: promotion.description,
      shortDesc: promotion.shortDesc,
      imageUrl: promotion.imageUrl,
      startDate: promotion.startDate,
      endDate: promotion.endDate,
    );
  }

  PromotionsCompanion _convertToCompanion(PromotionModel model) {
    return PromotionsCompanion(
      id: Value(model.id),
      title: Value(model.title),
      description: Value(model.description),
      shortDesc: Value(model.shortDesc),
      imageUrl: Value(model.imageUrl),
      startDate: Value(model.startDate),
      endDate: Value(model.endDate),
    );
  }

  Future<void> close() async {
    await _database.close();
  }
}