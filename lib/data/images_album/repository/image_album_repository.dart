import 'package:image_album/core/di/di.dart';
import 'package:image_album/data/images_album/dataSources/data_sources_interface.dart';
import 'package:image_album/domain/image_album/entity/album_image.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/domain/image_album/repository/album_images_repository_interface.dart';

class AlbumRepository extends IAlbumRepository {
  final IAlbumImagesLocalService _albumImagesLocalService;
  final IAlbumImagesRemoteService _albumImagesRemoteService;

  AlbumRepository(
      {IAlbumImagesRemoteService? albumImagesRemoteService,
      IAlbumImagesLocalService? albumImagesLocalService})
      : _albumImagesRemoteService =
            albumImagesRemoteService ?? di<IAlbumImagesRemoteService>(),
        _albumImagesLocalService =
            albumImagesLocalService ?? di<IAlbumImagesLocalService>();

  @override
  Future<List<AlbumImages>> getAlbums() async {
    //Fetch From Local Data
    final localAlbumData = await _albumImagesLocalService.getCachedAlbums();
    if (localAlbumData.isNotEmpty) {
      return localAlbumData
          .map((item) => AlbumImages(id: item.id, title: item.title))
          .toList();
    }

    // Fallback To Remote Data
    final albums = await _albumImagesRemoteService.getAlbums();
    List<AlbumImages> albumsEntity = <AlbumImages>[];

    //Cache The Data
    await _albumImagesLocalService.cachedAlbums(albums);

    //Return the entity
    for (var item in albums) {
      albumsEntity.add(AlbumImages(id: item.id, title: item.title));
    }
    return albumsEntity;
  }

  @override
  Future<List<Images>> getImages(String albumId) async {
    //Fetch the local data
    final localImages = await _albumImagesLocalService.getCachedImages(albumId);

    if (localImages.isNotEmpty) {
      return localImages
          .map((item) => Images(id: item.id, url: item.url))
          .toList();
    }

    //Fallback to remote data
    final images = await _albumImagesRemoteService.getImages(albumId);
    List<Images> imagesEntity = [];

    //Cache the remote data
    await _albumImagesLocalService.cachedImages(albumId, images);

    //Convert into entity
    for (var item in images) {
      imagesEntity.add(Images(id: item.id, url: item.url));
    }
    return imagesEntity;
  }
}
