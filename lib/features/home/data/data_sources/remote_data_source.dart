import 'package:cars/core/consts/api.dart';
import 'package:cars/core/consts/methods.dart';
import 'package:cars/core/services/api_service.dart';
import 'package:dio/dio.dart';

import '../../../../core/consts/strings.dart';
import '../../domain/entities/previous_car_entity.dart';

abstract class HomeRemoteDataSource {
  Future<Response> getTopBrands({required int page});

  Future<Response> getRecommendedForYou({required int page});

  Future<Response> getBestOffers({required int page});

  Future<String> userInfo({
    required String income,
  });

  Future<String> previousCar({
    required PreviousCarEntity previousCar,
  });

  Future<PreviousCarEntity> getModelBrand({
    required String brand,
  });
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Response> getTopBrands({required int page}) async {
    // String? token = await readFromCache(
    //   StringsEn.token,
    // );

    Response response = await _apiService.get(
      endPoint: "${ApiConsts.topBrandsEndpoint}?page=${page + 1}",
      //token: token,
    );

    return response;
  }

  @override
  Future<Response> getBestOffers({required int page}) async {
    // String? token = await readFromCache(
    //   StringsEn.token,
    // );

    Response response = await _apiService.get(
      endPoint: "${ApiConsts.bestOffersEndpoint}?page=$page",
      //token: token,
    );
    return response;
  }

  @override
  Future<Response> getRecommendedForYou({required int page}) async {
    // String? token = await readFromCache(
    //   StringsEn.token,
    // );

    Response response = await _apiService.get(
      endPoint: "${ApiConsts.recommendedForYouEndPoint}?page=$page",
      //token: token,
    );
    return response;
  }

  @override
  Future<PreviousCarEntity> getModelBrand({required String brand}) async {
    FormData data = convertMapToFormData(
      {'brand': brand},
    );
    String? token = await readFromCache(
      StringsEn.token,
    );

    Response response = await _apiService.post(
      endPoint: ApiConsts.getModelTypeEndPoint,
      token: token,
      data: data,
    );
    PreviousCarEntity model = PreviousCarEntity.fromMap(
      response.data['data'],
    );
    return model;
  }

  @override
  Future<String> previousCar({
    required PreviousCarEntity previousCar,
  }) async {
    FormData data = convertMapToFormData(
      previousCar.toMap(),
    );
    String? token = await readFromCache(
      StringsEn.token,
    );

    Response response = await _apiService.post(
      endPoint: ApiConsts.previousCarEndpoint,
      token: token,
      data: data,
    );
    Map<String, dynamic> dataMap = response.data;
    return dataMap['Message'];
  }

  @override
  Future<String> userInfo({required String income}) async {
    FormData data = convertMapToFormData(
      {'income': income},
    );
    String? token = await readFromCache(
      StringsEn.token,
    );

    Response response = await _apiService.post(
      endPoint: ApiConsts.userInfoEndpoint,
      token: token,
      data: data,
    );
    Map<String, dynamic> dataMap = response.data;
    return dataMap['Message'];
  }
}
