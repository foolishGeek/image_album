import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_bloc.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_events.dart';
import 'package:image_album/presentation/image_album/bloc/image_albums_states.dart';
import 'package:image_album/presentation/image_album/screens/widgets/album_view.dart';

class AlbumImagesScreen extends StatefulWidget {
  const AlbumImagesScreen({super.key});

  @override
  State<AlbumImagesScreen> createState() => _AlbumImagesScreenState();
}

class _AlbumImagesScreenState extends State<AlbumImagesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listenScroll();
    context.read<ImageAlbumBloc>().add(const FetchAlbums());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _listenScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context
            .read<ImageAlbumBloc>()
            .add(const FetchAlbums(fetchNextPage: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Album'),
      ),
      body: BlocBuilder<ImageAlbumBloc, ImageAlbumState>(
          builder: (context, state) {
        switch (state) {
          case AlbumLoadedState(
              :final albums,
              :final albumImages,
              :final loadingImages
            ):
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.position.maxScrollExtent == 0) {
                context
                    .read<ImageAlbumBloc>()
                    .add(const FetchAlbums(fetchNextPage: true));
              }
            });

            return ListView.separated(
              controller: _scrollController,
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return AlbumView(
                  album: album,
                  images: albumImages[album.id] ?? [],
                  loadingImages: loadingImages,
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            );

          case AlbumLoadingState():
            return const Center(child: CircularProgressIndicator());

          case AlbumLoadingErrorState(:final errorMessage):
            return Center(child: Text("Error: $errorMessage"));

          case ImageAlbumInitialState():
          default:
            return const Center(child: Text("Initializing..."));
        }
      }),
    );
  }
}
