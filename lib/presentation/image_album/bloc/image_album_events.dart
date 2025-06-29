sealed class ImageAlbumEvent {
  const ImageAlbumEvent();
}

/// Fetch all albums from API (or local if cached)
final class FetchAlbums extends ImageAlbumEvent {
  final bool fetchNextPage;

  const FetchAlbums({this.fetchNextPage = false});
}

/// Load images for a specific album ID
final class LoadImagesForAlbum extends ImageAlbumEvent {
  final String albumId;
  final bool fetchNextPage;

  const LoadImagesForAlbum(this.albumId, {this.fetchNextPage = false});
}
