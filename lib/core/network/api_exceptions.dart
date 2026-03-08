import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

// class ApiExceptions for handling api errors in the app with status code and message as 200 , 400 ,500
class ApiExceptions {
  // class ApiError for handling api errors in the app
  static ApiError handleError(DioException error) {
    // format error message

    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data["message"] != null) {
      return ApiError(message: data["message"], statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout, please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout, please try again");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout, please try again");

      default:
        return ApiError(message: "Something went wrong, please try again");
    }
  }
}
