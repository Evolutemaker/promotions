import 'dart:developer';

import 'package:promotions/core/env/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          autoRefreshToken: true,
          detectSessionInUri: false,
        ),
        debug: false,
      );

      log('Supabase инициализирован успешно');
    } catch (e) {
      log(e.toString());
    }
  }
}
