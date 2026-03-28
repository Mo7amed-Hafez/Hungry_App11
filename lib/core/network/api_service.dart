import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';

/// class ApiService for api calls in the app get , post , put , delete
class ApiService {

  // object of DioClient class for api calls from the app
  final DioClient _dioClient = DioClient();

  // 4 methods for api calls
  // get
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // post or simple update
  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // put // update

  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // delete
  Future<dynamic> delete(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}


// هنا عملنها علشان نستخدمه كتير منغير اعاده كل مره 