import 'package:hive/hive.dart';

part 'image.g.dart';

@HiveType(typeId: 0)
class ImageEntity extends HiveObject {
  @HiveField(0)
  String? url;

  @HiveField(1)
  String? hdUrl;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? date;

  @HiveField(4)
  String? explanation;

  ImageEntity({
    this.url,
    this.hdUrl,
    this.title,
    this.date,
    this.explanation,
  });
}
