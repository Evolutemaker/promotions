import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:promotions/core/di/service_locator.dart';
import 'package:promotions/models/promotion/promotion_model.dart';
import 'package:promotions/repository/promotion_repository.dart';

part 'promotion_state.dart';
part 'promotion_cubit.freezed.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final PromotionRepository _repository;

  PromotionCubit()
      : _repository = sl<PromotionRepository>(),
        super(const PromotionState.initial());

  Future<void> loadPromotions() async {
    emit(const PromotionState.loading());
    try {
      final promotions = await _repository.getPromotions();
      emit(PromotionState.promotionsLoaded(promotions));
    } catch (e) {
      emit(PromotionState.error(e.toString()));
    }
  }

  Future<void> loadPromotionById(String id) async {
    emit(const PromotionState.loading());
    try {
      final promotion = await _repository.getPromotionById(id);
      if (promotion != null) {
        emit(PromotionState.promotionDetailLoaded(promotion));
      } else {
        emit(const PromotionState.error('Акция не найдена'));
      }
    } catch (e) {
      emit(PromotionState.error(e.toString()));
    }
  }

  Future<void> refreshPromotions() async {
    try {
      final promotions = await _repository.refreshPromotions();
      emit(PromotionState.promotionsLoaded(promotions));
    } catch (e) {
      emit(PromotionState.error(e.toString()));
    }
  }

  Future<void> searchPromotions(String query) async {
    if (query.isEmpty) {
      await loadPromotions();
      return;
    }

    emit(const PromotionState.loading());
    try {
      final promotions = await _repository.searchPromotions(query);
      emit(PromotionState.promotionsLoaded(promotions));
    } catch (e) {
      emit(PromotionState.error(e.toString()));
    }
  }

  Future<bool> isOnline() async {
    return await _repository.isOnline();
  }
}
