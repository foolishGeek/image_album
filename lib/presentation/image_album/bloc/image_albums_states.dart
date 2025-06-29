import 'package:image_album/domain/image_album/entity/album_image.dart';
import 'package:image_album/domain/image_album/entity/images.dart';

sealed class ImageAlbumState {}

class ImageAlbumInitialState extends ImageAlbumState {}

class AlbumLoadingState extends ImageAlbumState {}

class AlbumLoadedState extends ImageAlbumState {
  final List<AlbumImages> albums;
  final Map<int, List<Images>> albumImages;
  final Set<int> loadingImages;

  AlbumLoadedState(
      {required this.albums,
      required this.albumImages,
      required this.loadingImages});
}

final class AlbumLoadingErrorState extends ImageAlbumState {
  final String errorMessage;

  AlbumLoadingErrorState({required this.errorMessage});
}
