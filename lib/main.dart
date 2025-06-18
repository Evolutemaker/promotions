import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promotions/config/supabase_config.dart';
import 'package:promotions/core/di/service_locator.dart';
import 'package:promotions/cubit/promotion_cubit.dart';
import 'package:promotions/navigation/app_router.dart';
import 'package:promotions/uikit/theme/app_theme.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env");

    await SupabaseConfig.initialize();

    await initializeDependencies();
    runApp(MyApp());
  }, (error, stackTrace) {
    log('Error: $error');
    log('Stack Trace: $stackTrace');
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PromotionCubit()..loadPromotions()),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
      ),
    );
  }
}
