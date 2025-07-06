import 'package:dartz/dartz.dart';

abstract class INetworkService {
  Future<Either<String, Map<String, dynamic>>> get({
    required String url,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> query,
  });
}
