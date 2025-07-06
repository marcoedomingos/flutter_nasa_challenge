import 'image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    required super.url,
    required super.hdUrl,
    required super.title,
    required super.date,
    required super.explanation,
  });

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      url: map['url'],
      hdUrl: map['hdurl'],
      title: map['title'],
      date: map['date'],
      explanation: map['explanation'],
    );
  }
}
