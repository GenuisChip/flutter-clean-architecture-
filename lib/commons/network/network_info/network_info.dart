import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoIF {
  Future<bool> get isConnected;
}

class NetworkInfo implements NetworkInfoIF {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
