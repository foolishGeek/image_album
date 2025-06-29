import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_album/domain/image_album/entity/album_image.dart';
import 'package:image_album/domain/image_album/entity/images.dart';
import 'package:image_album/presentation/helper/ui_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_bloc.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_events.dart';

class AlbumView extends StatefulWidget {
  final AlbumImages album;
  final List<Images> images;
  final Set<int> loadingImages;

  const AlbumView({
    super.key,
    required this.album,
    required this.images,
    required this.loadingImages,
  });

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<ImageAlbumBloc>().add(
              LoadImagesForAlbum(widget.album.id.toString(),
                  fetchNextPage: true),
            );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.loadingImages.contains(widget.album.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 6, left: 6),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8))),
            child: Text(
              widget.album.title.capitalizeEachWord(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (widget.images.isEmpty)
            const Text("No images available")
          else
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.images.map((image) {
                    final imageHeight =
                        MediaQuery.sizeOf(context).width - 36 - 40;
                    return Container(
                      width: imageHeight / 3,
                      height: imageHeight / 3,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: image.url,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
