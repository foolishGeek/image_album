import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/domain/image_album/usecase/get_album_use_case.dart';
import 'package:image_album/domain/image_album/usecase/get_images_use_case.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_events.dart';
import 'package:image_album/presentation/image_album/bloc/image_albums_states.dart';

final class ImageAlbumBloc extends Bloc<ImageAlbumEvent, ImageAlbumState> {
  final GetAlbumUseCase _getAlbums;
  final GetImagesUseCase _getImages;

  ImageAlbumBloc({
    required GetAlbumUseCase getAlbums,
    required GetImagesUseCase getImages,
  })  : _getAlbums = getAlbums,
        _getImages = getImages,
        super(ImageAlbumInitialState()) {
    on<FetchAlbums>(_onFetchAlbums);
    on<LoadImagesForAlbum>(_onLoadImagesForAlbum);
  }

  Future<void> _onFetchAlbums(
      FetchAlbums event, Emitter<ImageAlbumState> emit) async {
    if (!event.fetchNextPage) {
      emit(AlbumLoadingState());
    }

    try {
      var albums = await _getAlbums();
      if (event.fetchNextPage) {
        final albumState = state as AlbumLoadedState;
        albumState.albums.addAll(albums);
        albums = albumState.albums;
      }

      emit(AlbumLoadedState(
        albums: albums,
        albumImages: {},
        loadingImages: albums.map((item) => item.id).toSet(),
      ));

      for (final album in albums) {
        add(LoadImagesForAlbum(album.id.toString()));
      }
    } catch (e) {
      emit(AlbumLoadingErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadImagesForAlbum(
      LoadImagesForAlbum event, Emitter<ImageAlbumState> emit) async {
    if (state is! AlbumLoadedState) return;

    final currentState = state as AlbumLoadedState;
    final albumId = int.tryParse(event.albumId);

    if (albumId == null ||
        (!currentState.loadingImages.contains(albumId) &&
            !event.fetchNextPage)) {
      return;
    }

    try {
      final newImages = await _getImages(event.albumId);

      // Get existing images if any
      final existingImages = currentState.albumImages[albumId] ?? [];

      // Combine old and new only if it's a pagination request
      final combinedImages =
          event.fetchNextPage ? [...existingImages, ...newImages] : newImages;

      final updatedAlbumImages =
          Map<int, List<Images>>.from(currentState.albumImages)
            ..[albumId] = combinedImages;

      final updatedLoadingSet = Set<int>.from(currentState.loadingImages)
        ..remove(albumId);

      emit(AlbumLoadedState(
        albums: currentState.albums,
        albumImages: updatedAlbumImages,
        loadingImages: updatedLoadingSet,
      ));
    } catch (e) {
      emit(AlbumLoadingErrorState(
          errorMessage: "Failed to load images for album ${event.albumId}"));
    }
  }
}
