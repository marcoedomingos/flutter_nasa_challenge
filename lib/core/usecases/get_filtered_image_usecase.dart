import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_challenge/core/datasources/image_datasource.dart';
import 'package:flutter_nasa_challenge/core/datasources/local_image_datasource.dart';
import 'package:flutter_nasa_challenge/core/services/connection/i_connection_service.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';

class GetFilteredImageUseCase {
  GetFilteredImageUseCase({
    required this.connectionService,
    required this.localImageDatasource,
    required this.datasource,
  });

  final IConnectionService connectionService;
  final LocalImageDatasource localImageDatasource;
  final ImageDatasource datasource;

  Future<Either<String, List<ImageEntity>>> call(String date) async {
    if (!(await connectionService.isConnected())) {
      return await localImageDatasource.getSavedFilteredImageList(date);
    }
    final image = await datasource.getFilteredImage(date);
    if (image.isRight()) image.fold((_) => _, (r) async => await localImageDatasource.saveImage(r));
    return image.fold((l) => Left(l), (r) => Right([r]));
  }
}