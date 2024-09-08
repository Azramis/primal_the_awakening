import 'package:flutter/material.dart';

class _GlossaryLocalizationsDelegate
    extends LocalizationsDelegate<GlossaryLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<GlossaryLocalizations> load(Locale locale) {
    assert(isSupported(locale));

    throw UnimplementedError();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<GlossaryLocalizations> old) =>
      false;
}

abstract interface class GlossaryLocalizations {}
