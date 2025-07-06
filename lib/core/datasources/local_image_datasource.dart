import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';
import 'package:flutter_nasa_challenge/models/image/image_model.dart';
import 'package:hive/hive.dart';

class LocalImageDatasource {

  Future<List<ImageEntity>> _initializeList(Box box) async {
    List<ImageEntity> imageList = [];
    if (box.containsKey("list")) {
      imageList = List.from(await box.get("list"));
    }
    return imageList;
  }

  Future<Either<String, List<ImageEntity>>> getSavedImage() async {
    final box = await Hive.openBox("images");
    List<ImageEntity> imageList = await _initializeList(box);
    imageList
        .retainWhere((element) => element.title != null && element.url != null);

    if (imageList.isNotEmpty) {
      return Right(imageList);
    }
    return const Left('Sem imagens salvas\nFaça a requisição com uma conexão a internet');
  }

  Future<Either<String, List<ImageEntity>>> getSavedFilteredImageList(String search) async {
    final box = await Hive.openBox("images");
    List<ImageEntity> imageList = await _initializeList(box);
    imageList.retainWhere((element) => element.title != null && element.url != null);

    if (DateTime.tryParse(search) != null) {
      imageList.retainWhere((element) => element.date == search);
    } else {
      imageList.retainWhere((element) {
        String title = element.title ?? "";
        return title.toUpperCase().contains(search.toUpperCase());
      });
    }
    if (imageList.isNotEmpty) {
      return Right(imageList);
    }
    return const Left('Pesquisa vazia\nFaça a requisição com uma conexão a internet');
  }

  Future<Either<String, bool>> saveImage(ImageModel image) async {
    try {
      final box = await Hive.openBox("images");
      List<ImageEntity> imageList = await _initializeList(box);

      if (imageList.where((element) => element.url == image.url).isNotEmpty) {
        return const Right(true);
      }

      imageList.add(image);
      box.put("list", imageList);
      return const Right(true);
    } catch (e) {
      return const Left('Não foi possível salvar a imagem');
    }
  }
}
