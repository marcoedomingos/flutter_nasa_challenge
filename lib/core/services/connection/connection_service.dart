import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_nasa_challenge/core/services/connection/i_connection_service.dart';

class ConnectionService extends IConnectionService {
  @override
  Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi);
  }
}