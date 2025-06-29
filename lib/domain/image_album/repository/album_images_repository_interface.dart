import 'package:image_album/domain/image_album/entity/album_image.dart';
import '../entity/images.dart';

abstract class IAlbumRepository {
  Future<List<AlbumImages>> getAlbums();
  Future<List<Images>> getImages(String albumId);
}

