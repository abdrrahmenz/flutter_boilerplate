import 'package:connectivity_plus/connectivity_plus.dart';

/// Internet connection checker
/// Getting current info internet connection status
abstract class NetworkInfo {
  /// Get current status internet connection.
  /// Connected on Internet or not.
  ///
  /// - Return `true` when user/device has internet connection
  /// - Return `false` when user/device has't internet connection
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this.connectivity);

  final Connectivity connectivity;

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> connectivityResult =
        await connectivity.checkConnectivity();

    return connectivityResult.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn ||
        result == ConnectivityResult.other);
  }
}
