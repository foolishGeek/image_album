import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:image_album/domain/image_album/entity/album_image.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/domain/image_album/usecase/get_album_use_case.dart';
import 'package:image_album/domain/image_album/usecase/get_images_use_case.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_bloc.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_events.dart';
import 'package:image_album/presentation/image_album/bloc/image_albums_states.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAlbumUseCase extends Mock implements IGetAlbumUseCase {}

class MockGetImagesUseCase extends Mock implements IGetImagesUseCase {}

void main() {
  late MockGetAlbumUseCase mockGetAlbums;
  late MockGetImagesUseCase mockGetImages;

  setUp(() {
    mockGetAlbums = MockGetAlbumUseCase();
    mockGetImages = MockGetImagesUseCase();
  });

  final mockAlbums = List.generate(
    2,
    (index) => AlbumImages(id: index, title: 'Album $index'),
  );

  final mockImages = List.generate(
    3,
    (index) => Images(
      id: index,
      url: 'https://image/$index.jpg',
    ),
  );

  blocTest<ImageAlbumBloc, ImageAlbumState>(
    'emits [AlbumLoadingState, AlbumLoadedState, AlbumLoadedState x2] when FetchAlbums is added',
    build: () {
      when(() => mockGetAlbums()).thenAnswer((_) async => mockAlbums);
      when(() => mockGetImages(any())).thenAnswer((_) async => mockImages);
      return ImageAlbumBloc(getAlbums: mockGetAlbums, getImages: mockGetImages);
    },
    act: (bloc) => bloc.add(const FetchAlbums()),
    expect: () => [
      isA<AlbumLoadingState>(),
      isA<AlbumLoadedState>(),
      isA<AlbumLoadedState>(),
      isA<AlbumLoadedState>(),
    ],
    verify: (_) {
      verify(() => mockGetAlbums()).called(1);
      verify(() => mockGetImages(any())).called(mockAlbums.length);
    },
  );

  blocTest<ImageAlbumBloc, ImageAlbumState>(
    'emits AlbumLoadedState with images after FetchAlbums',
    build: () {
      when(() => mockGetAlbums()).thenAnswer(
        (_) async => [const AlbumImages(id: 0, title: 'Album')],
      );

      when(() => mockGetAlbums()).thenAnswer(
        (_) async => [
          const AlbumImages(title: "titl", id: 1),
          const AlbumImages(title: "titl-1", id: 2),
          const AlbumImages(title: "title-2", id: 3),
        ],
      );

      return ImageAlbumBloc(
        getAlbums: mockGetAlbums,
        getImages: mockGetImages,
      );
    },
    act: (bloc) => bloc.add(const FetchAlbums()),
    wait: const Duration(milliseconds: 100), // allows async map work
    expect: () => [
      isA<AlbumLoadingState>(),
      isA<AlbumLoadedState>(),
      isA<AlbumLoadingErrorState>(),
    ],
  );
}
