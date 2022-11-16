import 'package:flutter/material.dart';
import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class CityRepo {
  final DioClient dioClient;
  CityRepo({@required this.dioClient});

  Future<ApiResponse> getCityList() async {
    try {
      final response = await dioClient.get(
          AppConstants.ADDRESS_CITY_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}