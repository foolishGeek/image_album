import 'package:get_it/get_it.dart';
import 'package:image_album/core/service/local_storage_service/hive_service/hive_local_storage.dart';
import 'package:image_album/core/service/remote_service/api_service/api_service.dart';

final di = GetIt.instance;

void injectNetworkDeps() {
  di.registerLazySingleton(<IApiService>() => ApiService());
  di.registerLazySingleton(
      <ILocalStorageService>() => const HiveLocalStorageService());
}
