

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../Api/urls.dart';
import 'base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  static Future<BaseOptions> getBaseOptions() async {



    BaseOptions options = BaseOptions(
       connectTimeout: const Duration(seconds: 10000),
       receiveTimeout: const Duration(seconds: 5000),
      followRedirects: false,
      validateStatus: (status) {
        return status! < 550;
      },

      baseUrl: Urls.baseURL,
      contentType: Headers.jsonContentType,
      headers: {
        "Accept": "application/json",
      },
    );

    return options;
  }

  @override
  Future<dynamic> getApi(url) async {
    if (kDebugMode) {
      print(url);
    }
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;
    try {
      Response response = await dio.get(url
      );

      responseJson = returnResponse(response);


    } catch (e) {

      return e;
    }

    return responseJson;
  }

  @override
  Future<dynamic> getApiWithParams(url,parameters) async {
    if (kDebugMode) {
      print(url);
    }
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;
    try {
      Response response = await dio.get(url,queryParameters: parameters
      );

      responseJson = returnResponse(response);


    } catch (e) {

      return e;
    }

    return responseJson;
  }

  @override
  Future<dynamic> getApiData(url,payload) async {
    if (kDebugMode) {
      print(url);
    }
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;
    try {
      Response response = await dio.get(url, data: payload
      );

      responseJson = returnResponse(response);


    } catch (e) {

      return e;
    }

    return responseJson;
  }
  @override
  Future<dynamic> postApi(payload, url) async {
    if (kDebugMode) {
      print(url);
      print(payload);
    }
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;
    try {
      final response = await dio.post(url, data: payload);

      responseJson = returnResponse(response);


    } catch (e) {
       return e;

    }


    return responseJson;
  }


  @override
  Future<dynamic> putApi(payload, url) async {
    if (kDebugMode) {
      print(url);
      print(payload);
    }
    Dio dio = Dio(await getBaseOptions());

    dynamic responseJson;
    try {
      final response = await dio.put(url, data: payload);

      responseJson = returnResponse(response);


    } catch (e) {
      return e;

    }


    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response;

        return responseJson;
      case 201:
        dynamic responseJson = response;
        return responseJson;
      case 400:
        dynamic responseJson = response;
        return responseJson;
      case 401:
        dynamic responseJson = response;
        return responseJson;
      case 500:
        dynamic responseJson = response;
        return responseJson;
      case 422:
        dynamic responseJson = response;
        return responseJson;
      default:
      // throw FetchDataException('Error ccoured while communicating with server '+response.statusCode.toString()) ;
    }
  }
}
