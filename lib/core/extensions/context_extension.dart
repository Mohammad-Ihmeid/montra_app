import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:montra_app/core/common/app/providers/user_info_provider.dart';
import 'package:montra_app/core/common/app/providers/user_provider.dart';
import 'package:montra_app/src/auth/domain/enities/user.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppLocalizations get langauage => AppLocalizations.of(this)!;

  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();
  UserInfoProvider get userInfoProvider => read<UserInfoProvider>();

  LocalUser? get currentUser => userProvider.user;
  UserInformation? get currentUserInfo => userInfoProvider.userInfo;
}
