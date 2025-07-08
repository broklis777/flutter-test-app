import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  String username = "broklis";

  void updateUsername(String name){
    username = name;
    notifyListeners();
  }
}