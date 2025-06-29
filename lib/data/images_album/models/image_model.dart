
///Image model in data layer
///API Ref: ```https://jsonplaceholder.typicode.com/photos```
class ImageDataModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const ImageDataModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory ImageDataModel.fromJson(Map<String, dynamic> json) {
    return ImageDataModel(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: "https://picsum.photos/200", //Hardcoded as existing image is not working
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
