import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  bool emailVerified = false;

  changeEmailVerifiedStatus({@required bool status}) {
    this.emailVerified = status;
    notifyListeners();
  }
}
