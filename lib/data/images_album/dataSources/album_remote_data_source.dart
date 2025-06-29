import 'dart:convert';

import 'package:image_album/core/di/di.dart';
import 'package:image_album/core/service/remote_service/api_request/api_request_interface.dart';
import 'package:image_album/core/service/remote_service/api_service/api_service_interface.dart';
import 'package:image_album/data/images_album/dataSources/data_sources_interface.dart';
import 'package:image_album/data/images_album/models/album_model.dart';
import 'package:image_album/data/images_album/models/image_model.dart';

class AlbumImagesRemoteService extends IAlbumImagesRemoteService {
  final IApiService _apiService;

  AlbumImagesRemoteService({IApiService? apiService})
      : _apiService = apiService ?? di<IApiService>();

  @override
  Future<List<AlbumDataModel>> getAlbums() async {
    final ApiRequest request =
        GetRequest('/albums', query: {"_page": "1", "_limit": "4"});
    final response = await _apiService.execute(request);
    List<AlbumDataModel> albums = [];
    if (response.statusCode != null && response.statusCode == 200) {
      albums = ((response.data ?? []) as List)
          .map((json) => AlbumDataModel.fromJson(json))
          .toList();
    }
    return albums;
  }

  @override
  Future<List<ImageDataModel>> getImages(String albumsId) async {
    final ApiRequest request = GetRequest('/photos',
        query: {"albumId": albumsId, "_page": "1", "_limit": "3"});
    final response = await _apiService.execute(request);
    List<ImageDataModel> images = <ImageDataModel>[];
    if (response.statusCode != null && response.statusCode == 200) {
      images = ((response.data ?? []) as List)
          .map((json) => ImageDataModel.fromJson(json))
          .toList();
    }
    return images;
  }
}
