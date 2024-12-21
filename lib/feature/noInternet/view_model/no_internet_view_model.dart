import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:translator/configs/routes/navigation_service.dart';
import 'package:translator/configs/routes/routes_name.dart';

class NoInternetViewModel extends ChangeNotifier {
  late ConnectivityResult _connectivityResult;

  bool _isConnected = true;

  void internetConnection(BuildContext context) {
    Connectivity().onConnectivityChanged.listen(
      (result) {
        _connectivityResult = result[0];

        _isConnected = _connectivityResult != ConnectivityResult.none;

        if (_connectivityResult == ConnectivityResult.none) {
          NavigationService.navigatorKey.currentState?.pushNamed(
            RoutesName.noInternetScreen,
          );
        }
      },
    );
  }

  bool get isConnected => _isConnected;
}
