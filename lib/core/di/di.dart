import 'package:get_it/get_it.dart';
import 'package:image_album/core/service/local_storage_service/hive_service/hive_local_storage.dart';
import 'package:image_album/core/service/local_storage_service/local_storage_service_interface.dart';
import 'package:image_album/core/service/remote_service/api_service/api_service.dart';
import 'package:image_album/core/service/remote_service/api_service/api_service_interface.dart';
import 'package:image_album/data/images_album/dataSources/album_local_data_source.dart';
import 'package:image_album/data/images_album/dataSources/album_remote_data_source.dart';
import 'package:image_album/data/images_album/dataSources/data_sources_interface.dart';
import 'package:image_album/data/images_album/repository/image_album_repository.dart';
import 'package:image_album/domain/image_album/repository/album_images_repository_interface.dart';
import 'package:image_album/domain/image_album/usecase/get_album_use_case.dart';
import 'package:image_album/domain/image_album/usecase/get_images_use_case.dart';

final di = GetIt.instance;

void injectMainDependency() {
  di.registerLazySingleton<IApiService>(() => ApiService());
  di.registerLazySingleton<ILocalStorageService>(
      () => const HiveLocalStorageService());
}

//TODO - this can be moved to separate files as per the feature
//For Image Album
void injectImageAlbumsDependency() {
  di.registerFactory<IAlbumImagesLocalService>(() => AlbumImagesLocalService());
  di.registerFactory<IAlbumImagesRemoteService>(
      () => AlbumImagesRemoteService());
  di.registerFactory<IAlbumRepository>(() => AlbumRepository());
  di.registerFactory<GetAlbumUseCase>(() => GetAlbumUseCase());
  di.registerFactory<GetImagesUseCase>(() => GetImagesUseCase());
}

void deregisterImageAlbumsDependency() {
  if (di.isRegistered<IAlbumRepository>()) {
    di.unregister<IAlbumRepository>();
  }

  if (di.isRegistered<IAlbumImagesRemoteService>()) {
    di.unregister<IAlbumImagesRemoteService>();
  }

  if (di.isRegistered<IAlbumImagesLocalService>()) {
    di.unregister<IAlbumImagesLocalService>();
  }

  if (di.isRegistered<GetAlbumUseCase>()) {
    di.unregister<GetAlbumUseCase>();
  }

  if (di.isRegistered<GetImagesUseCase>()) {
    di.unregister<GetImagesUseCase>();
  }
}
