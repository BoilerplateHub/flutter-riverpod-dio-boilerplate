import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'values/constants.dart';
import '../shared/utils/extensions.dart';
import '../app/provider/core_providers.dart';
import 'exports/generated_values_export.dart';

class PushNotificationService {
  // static final PushNotificationService _pushNotificationService = PushNotificationService._internal();
  // PushNotificationService._internal();

  // factory PushNotificationService() {
  //   return _pushNotificationService;
  // }

  final Reader _reader;
  late final BuildContext context;

  PushNotificationService(this._reader);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _notificationController = null;
  // final _notificationController = Get.put(NotificationController());

  Future<void> initialise(BuildContext context) async {
    this.context = context;
    if (Platform.isIOS) {
      try {
        var settings = await _firebaseMessaging.getNotificationSettings();

        if (settings.authorizationStatus != AuthorizationStatus.authorized) {
          await _firebaseMessaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
        }
      } catch (e) {
        e.toString().errorToast();
        // EasyLoading.showError(e.toString());
      }
    }

    //onLaunch(completely closed - not in background)
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      _sendFromNotificationClick(message);
    });

    //onMessage(app in open)
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      _sendFromNotificationClick(message, isNavigate: false);
    });

    //onResume(app in background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      _sendFromNotificationClick(message);
    });
  }

  void _sendFromNotificationClick(
    RemoteMessage? message, {
    bool isNavigate = true,
  }) {
    var data = message?.data;

    if (data != null) {
      var body = data['body'];
      var title = data['title'];
      var unreadCounterData = data['unreadCount'];

      if (unreadCounterData != null && unreadCounterData != "") {
        var unreadCounter = int.parse(unreadCounterData);
        var preferenceManager = _reader(preferenceManagerProvider);

        preferenceManager.getString(keyJwtToken).then((jwt) {
          if (jwt != null) {
            if (unreadCounter > 0) {
              _notificationController.unreadCounter.value = unreadCounter;
            }

            if (isNavigate) {
              // context.push(routeError);

              // Get.to(() => StockDetailsScreen(
              //           tradeCode: tradeCode,
              //           companyName: companyName,
              //         ),
              //     transition: sendTransition);
            } else if (title != null && body != null) {
              body.toString().successToast();

              // Get.snackbar(
              //   title,
              //   body,
              //   isDismissible: true,
              //   backgroundColor: fadeAshColor,
              //   snackPosition: SnackPosition.BOTTOM,
              //   icon: const Icon(
              //     Icons.notifications,
              //     color: colorPrimary,
              //   ),
              // );
            }
          } else {
            LocaleKeys.somethingWentWrong.tr().errorToast();
            // EasyLoading.showError("Something went wrong!");
          }
        }).catchError((onError) {
          onError.toString().errorToast();
          // EasyLoading.showError(onError.toString());
        });

        // SharedPref.read(keyJwtToken).then((jwt) {
        //   if(jwt != null) {
        //     if(unreadCounter > 0) {
        //       _notificationController.unreadCounter.value = unreadCounter;
        //     }

        //     if(isNavigate) {
        //       Get.to(() => StockDetailsScreen(tradeCode: tradeCode, companyName: companyName,), transition: sendTransition);
        //     } else if(title != null && body != null) {
        //       Get.snackbar(
        //         title,
        //         body,
        //         isDismissible: true,
        //         backgroundColor: fadeAshColor,
        //         snackPosition: SnackPosition.BOTTOM,
        //         icon: const Icon(
        //           Icons.notifications,
        //           color: colorPrimary,
        //         ),
        //       );
        //     }
        //   } else {
        //     EasyLoading.showError("Something went wrong!");
        //   }
        // }).catchError((onError) {
        //   EasyLoading.showError(onError.toString());
        // });
      }
    }
  }
}
