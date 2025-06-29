abstract class INetworkConfig {
  String get baseUrl;
}

//Staging
class StagingNetworkConfig extends INetworkConfig {
  @override
  String get baseUrl => "https://jsonplaceholder.typicode.com";
}