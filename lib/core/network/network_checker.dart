import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkChecker {
  Future<bool> get isConnected;
}

@Injectable(as:NetworkChecker)
class NetworkCheckerImp implements NetworkChecker {
  final InternetConnectionChecker check;

  NetworkCheckerImp(this.check);

  @override
  Future<bool> get isConnected => check.hasConnection;
}
