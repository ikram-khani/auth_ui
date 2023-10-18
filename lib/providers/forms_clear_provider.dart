import 'package:auth_ui/screens/sign_up.dart';
import 'package:auth_ui/screens/sign_up_2.dart';
import 'package:flutter/foundation.dart';

class FormClearProvider extends ChangeNotifier {
  void clearForm() {
    SignUpScreen().clear();
    SignUpScreen2().clear();
    notifyListeners();
  }
}
