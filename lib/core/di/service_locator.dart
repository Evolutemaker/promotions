import 'package:get_it/get_it.dart';
import '../../services/promotion_service.dart';
import '../../services/storage_service.dart';
import '../../repository/promotion_repository.dart';
import '../../repository/promotion_repository_impl.dart';
import '../../core/network/network_checker.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());

  sl.registerLazySingleton<PromotionService>(() => PromotionService());

  sl.registerLazySingleton<StorageService>(() => StorageService());

  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(
      remoteService: sl<PromotionService>(),
      localService: sl<StorageService>(),
      networkChecker: sl<NetworkChecker>(),
    ),
  );
}
