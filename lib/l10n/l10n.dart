import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  CupertinoLocalizations get l10nCupertino => CupertinoLocalizations.of(this);

  MaterialLocalizations get l10nMaterial => MaterialLocalizations.of(this);
}
