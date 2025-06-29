import 'package:image_album/core/di/di.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/domain/image_album/repository/album_images_repository_interface.dart';

final class GetImagesUseCase {
  final IAlbumRepository _repository;

  GetImagesUseCase({IAlbumRepository? repository})
      : _repository = repository ?? di<IAlbumRepository>();

  Future<List<Images>> call(String albumId) => _repository.getImages(albumId);
}
