import 'package:image_album/data/images_album/models/album_model.dart';
import 'package:image_album/data/images_album/models/image_model.dart';

///Interface for the local services
abstract class IAlbumImagesLocalService {
  Future<List<AlbumDataModel>> getCachedAlbums();

  Future<void> cachedAlbums(List<AlbumDataModel> albums);

  Future<List<ImageDataModel>> getCachedImages(String albumsId);

  Future<void> cachedImages(String albumId, List<ImageDataModel> images);
}

///Interface for the Remote services
abstract class IAlbumImagesRemoteService {
  Future<List<AlbumDataModel>> getAlbums();

  Future<List<ImageDataModel>> getImages(String albumsId);
}
