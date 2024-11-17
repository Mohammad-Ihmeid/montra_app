import 'package:flutter/material.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInformation? _userInfo;

  UserInformation? get userInfo => _userInfo;

  void initUserInfo(UserInformation? userInfo) {
    //if (_userInfo != null)
    _userInfo = userInfo;
  }

  set userInfo(UserInformation? userInfo) {
    if (_userInfo != userInfo) {
      _userInfo = userInfo;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
