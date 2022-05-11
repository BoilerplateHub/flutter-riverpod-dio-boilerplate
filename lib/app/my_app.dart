import 'package:flutter/material.dart';
import 'package:thrive_mobile_app/app/routes/routes.dart';
import 'package:upgrader/upgrader.dart';

import 'widget/text_widget.dart';
import 'exports/flavor_export.dart';
import 'exports/generated_values_export.dart';
import 'exports/app_values_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EnvConfig _envConfig = BuildConfig.instance.config;
    final Environment _environment = BuildConfig.instance.environment;

    if (_environment == Environment.development) {
      Upgrader().clearSavedSettings();
    }

    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
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
      // home: const SplashScreenPage(),
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
            LocaleKeys.breaker.tr(),
            font: "Zen Loop",
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          // UpgradeAlert(
          //   canDismissDialog: true,
          //   debugDisplayAlways: true,
          //   shouldPopScope: () => true,
          //   child: const Text(''),
          // ),
        ],
      ),
    );
  }
}
