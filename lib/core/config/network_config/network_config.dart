import 'package:image_album/core/config/environment/env_config.dart';
import 'package:image_album/core/config/network_config/network_values.dart';

class NetworkConfig {
  static late final INetworkConfig networkConfig;

  static void initialiseNetworkConfig(NetworkEnv env) {
    networkConfig = switch (env) { NetworkEnv.stg => StagingNetworkConfig() };
  }
}
