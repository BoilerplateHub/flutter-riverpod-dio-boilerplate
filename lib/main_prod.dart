import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'app/start.dart';
import 'app/values/constants.dart';

Future<void> main() async {
  EnvConfig prodConfig = EnvConfig(
    appName: "Thrive App Prod",
    baseUrl: prodBaseUrl,
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: prodConfig,
  );

  await start();
}
