import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:primal_the_awakening/home/home_view.dart';
import 'package:primal_the_awakening/home/home_view_model.dart';
import 'package:primal_the_awakening/services/settings.dart';
import 'package:valuable/valuable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ValuableWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ValuableWatcher watch) {
    final settings = watch(settingsService.settings) ?? const SettingsModel();

    return MaterialApp(
      title: 'Primal: The Awakening',
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: settings.supportedLocales,
      locale: settings.locale,
      home: const HomeView(
        viewModel: HomeViewModelImpl(),
      ),
    );
  }
}
