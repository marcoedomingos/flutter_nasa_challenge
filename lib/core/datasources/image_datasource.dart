import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_challenge/core/services/network/i_network_service.dart';
import 'package:flutter_nasa_challenge/models/image/image_model.dart';

class ImageDatasource {
  ImageDatasource({required this.networkService}) {
    apiKey = const String.fromEnvironment("APIKEY");
  }

  final INetworkService networkService;
  String apiKey = "YOUR-API-KEY-HERE";

  Future<Either<String, ImageModel>> getImage() async {
    final data = await networkService.get(
      url: "/planetary/apod",
      headers: {},
      query: {"api_key": apiKey},
    );
    return data.fold((l) => Left(l), (r) => Right(ImageModel.fromJson(r)));
  }

  Future<Either<String, ImageModel>> getFilteredImage(String date) async {
    final data = await networkService.get(
      url: "/planetary/apod",
      headers: {},
      query: {
        "date": date,
        "api_key": apiKey
      },
    );
    return data.fold((l) => Left(l), (r) => Right(ImageModel.fromJson(r)));
  }
}
