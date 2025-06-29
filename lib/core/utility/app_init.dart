import 'package:image_album/core/config/environment/env_config.dart';
import 'package:image_album/core/config/network_config/network_config.dart';
import 'package:image_album/core/di/di.dart';

class InitialiseApp {
  void init() {
    //Network Configured :: Staging only
    // Default staging for test purpose we can make this robust in multiple way
    NetworkConfig.initialiseNetworkConfig(NetworkEnv.stg);

    //Initialise dependency
    injectNetworkDeps();
  }
}
