import 'package:employee_management_ad/model/userdata.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserData userInformation;
  void setUser(UserData userdata) {
    userInformation = userdata;
    notifyListeners();
  }
}
