import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  AppLocalizations get langauage => AppLocalizations.of(this)!;

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
}
