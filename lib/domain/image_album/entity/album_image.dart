import 'package:image_album/domain/image_album/entity/images.dart';

class AlbumImages {
  final int id;
  final String title;
  final List<Images>? images;

  const AlbumImages({
    required this.id,
    required this.title,
    this.images,
  });
}
