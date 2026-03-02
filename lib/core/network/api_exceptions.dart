import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

// class ApiExceptions for handling api errors in the app with status code and message as 200 , 400 ,500
class ApiExceptions {

  // class ApiError for handling api errors in the app 
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      return ApiError(message: "Connection timeout");
      case DioExceptionType.badResponse:
      return ApiError(message: error.toString());
      case DioExceptionType.sendTimeout:
      return ApiError(message: "Send timeout");
      case DioExceptionType.receiveTimeout:
      return ApiError(message: "Receive timeout");
      
      default:
      return ApiError(message: "Something went wrong");
      
    }
  }
}