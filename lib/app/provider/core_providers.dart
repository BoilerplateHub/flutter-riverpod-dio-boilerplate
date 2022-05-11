import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thrive_mobile_app/app/push_notification_service.dart';

import '../../shared/preference/preference_manager.dart';
import '../../shared/preference/preference_manager_impl.dart';

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final preferenceManagerProvider = Provider<PreferenceManager>((ref) {
  return PreferenceManagerImpl();
});

final pushNotificationProvider = Provider<PushNotificationService>((ref) {
  return PushNotificationService(ref.read);
});
