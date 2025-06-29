import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_album/core/config/environment/env_config.dart';
import 'package:image_album/core/config/network_config/network_config.dart';
import 'package:image_album/core/di/di.dart';

class InitialiseApp {
  Future<void> init() async{
    //Network Configured :: Staging only
    // Default staging for test purpose we can make this robust in multiple way
    NetworkConfig.initialiseNetworkConfig(NetworkEnv.stg);
    await Hive.initFlutter();

    //Initialise dependency
    injectMainDependency();
  }
}
