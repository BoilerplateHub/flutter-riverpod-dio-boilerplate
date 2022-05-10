import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'app/start.dart';
import 'app/values/constants.dart';

Future<void> main() async {
  EnvConfig devConfig = EnvConfig(
    appName: "Thrive App Dev",
    baseUrl: devBaseUrl,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  await start();
}
