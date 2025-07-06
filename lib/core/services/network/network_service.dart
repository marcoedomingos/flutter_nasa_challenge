import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nasa_challenge/core/services/network/i_network_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService extends INetworkService {
  final _dio = Dio(BaseOptions(baseUrl: "https://api.nasa.gov"));

  @override
  Future<Either<String, Map<String, dynamic>>> get({
    required String url,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> query,
  }) async {
    _dio.options.headers = headers;
    _dio.options.queryParameters = query;
    _dio.interceptors.add(PrettyDioLogger());
    try{
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return const Left('Falha na requisição');
      }
    }catch(e){
      return Left('Erro durante a requisição');
    }
  }
}
