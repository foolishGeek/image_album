import 'package:image_album/core/di/di.dart';
import 'package:image_album/domain/image_album/entity/album_image.dart';
import 'package:image_album/domain/image_album/repository/album_images_repository_interface.dart';

abstract class IGetAlbumUseCase {
  Future<List<AlbumImages>> call();
}

final class GetAlbumUseCase extends IGetAlbumUseCase {
  final IAlbumRepository _repository;

  GetAlbumUseCase({IAlbumRepository? repository})
      : _repository = repository ?? di<IAlbumRepository>();

  @override
  Future<List<AlbumImages>> call () => _repository.getAlbums();
}
