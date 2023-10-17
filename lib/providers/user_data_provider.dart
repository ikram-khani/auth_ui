import 'package:auth_ui/models/user_data_model.dart';
import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  final UserData _userData = UserData();

  UserData get userData => _userData;

  void saveBasicDetails(
      String name, DateTime dob, String address, String phoneNumber) {
    _userData.name = name;
    _userData.dob = dob;
    _userData.address = address;
    _userData.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void saveEmail(String email) {
    _userData.email = email;
    notifyListeners();
  }

  void savePassword(String password) {
    _userData.password = password;
    notifyListeners();
  }
}
