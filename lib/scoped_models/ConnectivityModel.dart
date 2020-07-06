import 'package:data_connection_checker/data_connection_checker.dart';
import 'ConnectedModel.dart';

class ConnectivityModel extends ConnectedModel {
  Future<bool> checkConnection() async {
    isLoading = true;
    notifyListeners();
    bool _hasConnection = await DataConnectionChecker().hasConnection;
    isConnected = _hasConnection;
    isLoading = false;
    notifyListeners();
    return _hasConnection;
  }
}
