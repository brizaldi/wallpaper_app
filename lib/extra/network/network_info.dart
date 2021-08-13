import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class INetworkInfo {
  Future<bool> isConnected();
}

@LazySingleton(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await connectionChecker.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
