import 'package:flutter/foundation.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/utils/preferences.dart';

class ApiKeyProvider extends ChangeNotifier {
  String _apiKey = "";

  String get apiKey => _apiKey;
  set apiKey(String newKey) {
    _apiKey = newKey;
    NetworkService.setAuth(newKey);
    Preferences.setApiKey(newKey);
    notifyListeners();
  }
}
