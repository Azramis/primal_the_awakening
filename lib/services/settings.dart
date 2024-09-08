import 'dart:async';
import 'dart:ui';

import 'package:primal_the_awakening/common/utils/utils.dart';
import 'package:scope/scope.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/extension.dart';
import 'package:valuable/valuable.dart';

const _settingsServiceKey = ScopeKey<SettingsService>('settingsService');
SettingsService get settingsService => use(
      _settingsServiceKey,
      withDefault: _SettingsServiceDefault.new,
    );

final class SettingsModel {
  const SettingsModel({
    this.locale = const Locale('en'),
    this.supportedLocales = const [
      Locale('en'), // English
      Locale('fr'),
    ],
  });

  final Locale locale;
  final Iterable<Locale> supportedLocales;

  SettingsModel copyWith({
    Locale? locale,
    Iterable<Locale>? supportedLocales,
  }) {
    return SettingsModel(
      locale: locale ?? this.locale,
      supportedLocales: supportedLocales ?? this.supportedLocales,
    );
  }
}

abstract interface class SettingsService {
  Valuable<SettingsModel?> get settings;
  void setLocale(Locale locale);
}

final class _SettingsServiceDefault implements SettingsService {
  _SettingsServiceDefault() {
    _loadSettings().then((value) {
      _settings.setValue(value);
      _settings.addListener(_saveSettings);
    });
  }

  static const _currentLocaleKey = 'currentLocale';

  final StatefulValuable<SettingsModel?> _settings = StatefulValuable(null);
  @override
  Valuable<SettingsModel?> get settings => _settings;

  Future<SettingsModel> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_currentLocaleKey);

    return SettingsModel(
      locale: Locale(languageCode ?? 'en'),
    );
  }

  Future<void> _saveSettings() async => letSync(
        _settings.getValue(),
        (settings) async => synchronized(
          () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                _currentLocaleKey, settings.locale.languageCode);
          },
        ),
      );

  @override
  void setLocale(Locale locale) async {
    letSync(settings.getValue(), (settings) {
      final newSettings = settings.copyWith(locale: locale);
      _settings.setValue(newSettings);

      return newSettings;
    });
  }
}
