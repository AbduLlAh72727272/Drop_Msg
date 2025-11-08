import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

enum ConnectionStatus {
  online,
  offline,
  poor,
}

class ConnectivityProvider extends ChangeNotifier {
  ConnectionStatus _connectionStatus = ConnectionStatus.offline;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  
  ConnectionStatus get connectionStatus => _connectionStatus;
  
  bool get isOnline => _connectionStatus == ConnectionStatus.online;
  bool get isOffline => _connectionStatus == ConnectionStatus.offline;
  bool get isPoorConnection => _connectionStatus == ConnectionStatus.poor;
  
  String get statusMessage {
    switch (_connectionStatus) {
      case ConnectionStatus.online:
        return 'Connected';
      case ConnectionStatus.poor:
        return 'Poor Connection';
      case ConnectionStatus.offline:
        return 'No Internet Connection';
    }
  }
  
  Color get statusColor {
    switch (_connectionStatus) {
      case ConnectionStatus.online:
        return Colors.green;
      case ConnectionStatus.poor:
        return Colors.orange;
      case ConnectionStatus.offline:
        return Colors.red;
    }
  }
  
  IconData get statusIcon {
    switch (_connectionStatus) {
      case ConnectionStatus.online:
        return Icons.wifi;
      case ConnectionStatus.poor:
        return Icons.wifi_1_bar;
      case ConnectionStatus.offline:
        return Icons.wifi_off;
    }
  }
  
  ConnectivityProvider() {
    _initializeConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }
  
  Future<void> _initializeConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Failed to get connectivity: $e');
      _connectionStatus = ConnectionStatus.offline;
      notifyListeners();
    }
  }
  
  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus = ConnectionStatus.online;
        break;
      case ConnectivityResult.mobile:
        _connectionStatus = ConnectionStatus.online;
        break;
      case ConnectivityResult.ethernet:
        _connectionStatus = ConnectionStatus.online;
        break;
      case ConnectivityResult.vpn:
        _connectionStatus = ConnectionStatus.online;
        break;
      case ConnectivityResult.bluetooth:
        _connectionStatus = ConnectionStatus.poor;
        break;
      case ConnectivityResult.other:
        _connectionStatus = ConnectionStatus.poor;
        break;
      case ConnectivityResult.none:
      default:
        _connectionStatus = ConnectionStatus.offline;
        break;
    }
    notifyListeners();
  }
  
  Future<void> checkConnection() async {
    await _initializeConnectivity();
  }
  
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}