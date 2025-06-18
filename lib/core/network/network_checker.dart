import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker {
  Future<bool> isConnected() async {
    try {
      final bool result = await InternetConnection().hasInternetAccess
          .timeout(
            const Duration(seconds: 2), // Shorter timeout
            onTimeout: () {

              return false;
            },
          );
      
      return result;
    } catch (e) {
      return false; // Always return false on any error
    }
  }

  Stream<bool> get connectionStream {
    return InternetConnection().onStatusChange
        .timeout(
          const Duration(seconds: 2),
          onTimeout: (sink) {
            sink.add(InternetStatus.disconnected);
          },
        )
        .map((status) {
          final isConnected = status == InternetStatus.connected;
          return isConnected;
        })
        .handleError((error) {
          return false;
        });
  }
}
