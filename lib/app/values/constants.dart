import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/provider/core_providers.dart';

const String keyUserId = "keyUserId";
const String keySortBy = "keySortBy";
const String keyUserName = "keyUserName";
const String keyUserType = "keyUserType";
const String keyJwtToken = "keyJwtToken";
const String keyRefreshToken = "keyRefreshToken";

const String devBaseUrl = "";
const String prodBaseUrl = "";

const emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> logout(Reader reader) async {
  final preferenceManager = reader(preferenceManagerProvider);

  try {
    int userId = await preferenceManager.getInt(keyUserId);
    if (userId > 0) {
      await subscribeUnSubscribeTopicToFirebase(userId, isUnSubscribe: true);
    }
  } catch (_) {}

  await preferenceManager.clear();
  // Get.offAll(() => const LoginScreen(), transition: sendTransition);
}

Future<void> subscribeUnSubscribeTopicToFirebase(
  var userId, {
  bool isUnSubscribe = false,
}) async {
  try {
    if (isUnSubscribe) {
      await FirebaseMessaging.instance.unsubscribeFromTopic("$userId");
    } else {
      await FirebaseMessaging.instance.subscribeToTopic("$userId");
    }
  } catch (e) {
    //EasyLoading.showError(e.toString());
  }
}
