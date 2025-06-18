import 'dart:developer';
import 'package:promotions/core/network/network_checker.dart';
import 'package:promotions/models/promotion/promotion_model.dart';
import 'package:promotions/repository/promotion_repository.dart';
import 'package:promotions/services/promotion_service.dart';
import 'package:promotions/services/storage_service.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionService _remoteService;
  final StorageService _localService;
  final NetworkChecker _networkChecker;

  PromotionRepositoryImpl({
    required PromotionService remoteService,
    required StorageService localService,
    NetworkChecker? networkChecker,
  }) : _remoteService = remoteService,
       _localService = localService,
       _networkChecker = networkChecker ?? NetworkChecker();

  @override
  Future<List<PromotionModel>> getPromotions() async {
    return await _executeWithFallback<List<PromotionModel>>(
      remoteOperation: () async {
        final promotions = await _remoteService.getPromotions();
        await _localService.savePromotions(promotions);
        return promotions;
      },
      localFallback: () => _localService.getPromotions(),
      errorMessage: 'Ошибка получения акций',
    );
  }

  @override
  Future<PromotionModel?> getPromotionById(String id) async {
    return await _executeWithFallback<PromotionModel?>(
      remoteOperation: () async {
        final promotion = await _remoteService.getPromotionById(id);
        await _localService.savePromotion(promotion);
        return promotion;
      },
      localFallback: () => _localService.getPromotionById(id),
      errorMessage: 'Ошибка получения акции по ID',
    );
  }

  @override
  Future<List<PromotionModel>> searchPromotions(String query) async {
    return await _executeWithFallback<List<PromotionModel>>(
      remoteOperation: () => _remoteService.searchPromotions(query),
      localFallback: () => _localService.searchPromotions(query),
      errorMessage: 'Ошибка поиска акций',
    );
  }

  @override
  Future<List<PromotionModel>> refreshPromotions() async {
    try {
      final promotions = await _remoteService.getPromotions();
      await _localService.savePromotions(promotions);
      return promotions;
    } catch (e) {
      log('Ошибка принудительного обновления: $e');
      return await _localService.getPromotions();
    }
  }

  @override
  Future<bool> isOnline() async {
    return await _networkChecker.isConnected();
  }

  Future<T> _executeWithFallback<T>({
    required Future<T> Function() remoteOperation,
    required Future<T> Function() localFallback,
    required String errorMessage,
  }) async {
    try {
      if (await _networkChecker.isConnected()) {
        return await remoteOperation();
      } else {
        return await localFallback();
      }
    } catch (e) {
      log('$errorMessage: $e');
      return await localFallback();
    }
  }
}
