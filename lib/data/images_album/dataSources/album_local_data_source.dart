import 'package:image_album/core/di/di.dart';
import 'package:image_album/core/service/local_storage_service/local_storage_service_interface.dart';
import 'package:image_album/core/utility/constant.dart';
import 'package:image_album/data/images_album/dataSources/data_sources_interface.dart';
import 'package:image_album/data/images_album/models/album_model.dart';
import 'package:image_album/data/images_album/models/image_model.dart';

class AlbumImagesLocalService extends IAlbumImagesLocalService {
  final ILocalStorageService _localStorageService;

  AlbumImagesLocalService({ILocalStorageService? localStorageService})
      : _localStorageService =
            localStorageService ?? di<ILocalStorageService>();

  @override
  Future<void> cachedAlbums(List<AlbumDataModel> albums) async {
    final albumJson = albums.map((item) => item.toJson()).toList();
    await _localStorageService.write(
        Constant.albumBox, Constant.albumsKey, albumJson);
  }

  @override
  Future<void> cachedImages(String albumId, List<ImageDataModel> images) async {
    final key = Constant.imageKeyPrefix + albumId;
    final imageJson = images.map((item) => item.toJson()).toList();
    await _localStorageService.write(Constant.imageBox, key, imageJson);
  }

  @override
  Future<List<AlbumDataModel>> getCachedAlbums() async {
    final albumJson =
        await _localStorageService.read(Constant.albumBox, Constant.albumsKey);
    if (albumJson == null) return [];
    return ((albumJson ?? []) as List)
        .map((item) => AlbumDataModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  Future<List<ImageDataModel>> getCachedImages(String albumsId) async {
    final key = Constant.imageKeyPrefix + albumsId;
    final imageJson = await _localStorageService.read(Constant.imageBox, key);
    if (imageJson == null) return [];

    return ((imageJson ?? []) as List)
        .map((item) => ImageDataModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
