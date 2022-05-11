import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/base/base_state.dart';
import '../../../app/provider/core_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseConsumerState<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ref.read(pushNotificationProvider).initialise(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("fdfdjfdl");
  }
}
