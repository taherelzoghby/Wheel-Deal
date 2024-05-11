import 'package:cars/core/consts/api.dart';
import 'package:dio/dio.dart';

class ApiService {
  static late Dio dio;
  static const String baseUrl = ApiConsts.baseUrl;

  static initDio() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (int? status) {
          return (status ?? 0) < 500;
        },
      ),
    );
  }

  Future<Response> get({
    required String endPoint,
    String? token,
  }) async {
    dio.options.headers = token == null
        ? {}
        : {
            'Authorization': 'Bearer $token',
          };
    Response response = await dio.get(
      '$baseUrl$endPoint',
    );
    return response;
  }

  Future<Response> post({
    required String endPoint,
    Object? data,
    String? token,
  }) async {
    dio.options.headers = token == null
        ? {}
        : {
            'Authorization': 'Bearer $token',
          };
    Response response = await dio.post(
      '$baseUrl$endPoint',
      data: data,
    );
    return response;
  }

  Future<Response> put({
    required String endPoint,
    String? token,
  }) async {
    dio.options.headers = token == null
        ? {}
        : {
            'Authorization': 'Bearer $token',
          };

    Response response = await dio.put(
      '$baseUrl$endPoint',
    );
    return response;
  }

  Future<Response> delete({
    required String endPoint,
    String? token,
  }) async {
    dio.options.headers = token == null
        ? {}
        : {
            'Authorization': 'Bearer $token',
          };
    Response response = await dio.delete(
      '$baseUrl$endPoint',
    );
    return response;
  }
}
