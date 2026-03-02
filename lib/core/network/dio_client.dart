import 'package:dio/dio.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';

class DioClient {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api",

      //   connectTimeout: const Duration(seconds: 3),
      //   receiveTimeout: const Duration(seconds: 3),
      headers: {
        // headers are map of key and value
        "content-type": "application/json",
      },
    ),
  );

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

            // get token from shared preferences
          final token = await PrefHelpers.getToken();

          // ignore: unnecessary_null_comparison
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] =
                "Bearer $token"; // bearer token نوعها و بنعلافها من postman
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dioo => dio;
}
