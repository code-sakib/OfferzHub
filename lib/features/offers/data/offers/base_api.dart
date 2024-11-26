import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:offerzhub/core/dataset.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';

class BaseApi {
  @protected
  Future<DataState> getStateOf({required Future Function() request}) async {
    try {
      final List<OffersModel> apiData = await request();

      return DataSucceed(data: apiData);
    } on DioException catch (e) {
      return DataFailed(error: e.message);
    }
  }
}
