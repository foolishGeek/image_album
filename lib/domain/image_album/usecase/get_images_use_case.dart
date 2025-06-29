import 'package:image_album/core/di/di.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/domain/image_album/repository/album_images_repository_interface.dart';

abstract class IGetImagesUseCase {
  Future<List<Images>> call(String albumId);
}

final class GetImagesUseCase extends IGetImagesUseCase {
  final IAlbumRepository _repository;

  GetImagesUseCase({IAlbumRepository? repository})
      : _repository = repository ?? di<IAlbumRepository>();

  @override
  Future<List<Images>> call(String albumId) => _repository.getImages(albumId);
}
