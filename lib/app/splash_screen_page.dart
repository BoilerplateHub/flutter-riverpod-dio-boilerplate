import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thrive_mobile_app/app/routes/route_paths.dart';

import 'values/app_colors.dart';
import 'values/constants.dart';
import '../shared/utils/extensions.dart';
import '../app/provider/core_providers.dart';
import '../app/base/base_stateless.dart';
import '../app/exports/generated_values_export.dart';

class SplashScreenPage extends ConsumerWidget with BaseStateless {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Reader reader = ref.read;

    isInternetConnected(reader, context).then((internet) {
      if (internet) {
        // Internet Present Case
        startTime(reader, context);
      } else {
        // No-Internet Case
        showWarningDialog(context, reader);
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: colorWhite,
        ),
        child: Center(
          child: Image.asset(
            Assets.logos.splashScreenLogo.path,
            height: 154,
            width: 264,
          ),
        ),
      ),
    );
  }

  startTime(Reader reader, BuildContext context) async {
    try {
      var preferenceManager = reader(preferenceManagerProvider);
      var userId = await preferenceManager.getInt(keyUserId);

      if (userId > 0) {
        await subscribeUnSubscribeTopicToFirebase(userId);
        // Get.offAll(() => const HomeScreen(), transition: sendTransition);

        log("111111111");
      } else {
        await subscribeUnSubscribeTopicToFirebase(userId, isUnSubscribe: true);
        // Get.offAll(() => const LoginScreen(), transition: sendTransition);

        log("22222222");
        context.go(routeHome);
      }
    } catch (e) {
      e.toString().errorToast();

      log("33333333 " + e.toString());
      // EasyLoading.showError(e.toString());
      // Get.offAll(() => const LoginScreen(), transition: sendTransition);
    }

    // context.go(routeHome);
  }

  showWarningDialog(BuildContext context, Reader reader) {
    Widget continueButton = TextButton(
      child: const Text(
        "Retry",
      ),
      onPressed: () {
        Navigator.pop(context);
        LocaleKeys.pleaseWait.tr().successToast();
        // EasyLoading.showToast("Please wait...");

        isInternetConnected(reader, context).then((internet) {
          if (internet) {
            startTime(reader, context);
          } else {
            // No-Internet Case
            showWarningDialog(context, reader);
          }
        });
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        LocaleKeys.exit.tr(),
      ),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    Widget alertDialog;

    if (Platform.isIOS) {
      alertDialog = CupertinoAlertDialog(
        title: Text(
          LocaleKeys.internetConnectivityProblem.tr(),
        ),
        content: Text(
          LocaleKeys.checkInternetConnectionFirst.tr(),
        ),
        actions: [cancelButton, continueButton],
      );
    } else {
      alertDialog = AlertDialog(
        elevation: 2,
        title: Text(LocaleKeys.internetConnectivityProblem.tr()),
        content: Text(
          LocaleKeys.checkInternetConnectionFirst.tr(),
        ),
        actions: [cancelButton, continueButton],
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
