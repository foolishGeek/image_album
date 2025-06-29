
///Data layer model for the Album Data
///API Ref: ```https://jsonplaceholder.typicode.com/albums```
class AlbumDataModel {
  final int userId;
  final int id;
  final String title;

  const AlbumDataModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumDataModel.fromJson(Map<String, dynamic> json) {
    return AlbumDataModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}
