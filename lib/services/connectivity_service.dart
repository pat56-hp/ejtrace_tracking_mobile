import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      bool isConnected = results.any((result) => _isConnected(result));
      _connectionController.add(isConnected);
    });
  }

  Stream<bool> get connectionStream => _connectionController.stream;

  bool _isConnected(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _connectionController.close();
  }
}
