import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:easy_localization/easy_localization.dart';

import 'values/app_colors.dart';
import '../../flavors/env_config.dart';
import '../../flavors/environment.dart';
import '../../flavors/build_config.dart';
import '../../app/widget/text_widget.dart';
import '../../translations/locale_keys.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EnvConfig _envConfig = BuildConfig.instance.config;
    final Environment _environment = BuildConfig.instance.environment;

    if (_environment == Environment.DEVELOPMENT) {
      Upgrader().clearSavedSettings();
    }

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: _envConfig.appName,
      theme: ThemeData(
        hintColor: Colors.blue,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: colorWhite,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home.tr()),
      ),
      body: Column(
        children: [
          TextWidget(
            'You have pushed the button this many times:',
            font: "Zen Loop",
          ),
          UpgradeAlert(
           canDismissDialog: true,
           debugDisplayAlways: true,
           shouldPopScope: () => true,
           child: const Text(''),
         ),
        ],
      ),
    );
  }
}
