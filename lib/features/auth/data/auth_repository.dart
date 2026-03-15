import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/auth_model.dart';

class AuthRepo {
  // object of api service class for api calls
  ApiService apiService = ApiService();

  // Login
  Future<UserModeL?> login(String email, String password) async {
    // email , password from login screen Controllers
    try {
      final response = await apiService.post("/login", {
        "email": email,
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        // handle errors from server
        final masg = response["message"];
        final code = response["code"];
        final data = response["data"];

        if (code != 200 || data == null) {
          throw ApiError(message: masg);
        }
        // handle success from server to get user data and token
        final user = UserModeL.fromJson(response["data"]);
        if (user.token != null) {
          await PrefHelpers.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: "Unexpected error from server");
      }
      // return user data for use it in the app
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // Signup

  Future<UserModeL?> singnup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        "name": name.trim(),
        "email": email.trim(),
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final masg = response["message"];
        final code = response["code"];
        final codestate = int.tryParse(
          code,
        ); // علشان نحوله الكود الى عدد ليتعرف عليه في الشرط
        final data = response["data"];

        if (codestate != 200 && codestate != 201 || data == null) {
          throw ApiError(message: masg ?? "Unexpected error from server");
        }

        final user = UserModeL.fromJson(response["data"]);
        if (user.token != null) {
          await PrefHelpers.saveToken(user.token!);
        }

        // return user data after register and save token if not error
        return user;
      } else {
        throw ApiError(message: "Unexpected error from server");
      }
    }
    // handle errors from server
    on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // Get profile Data

  Future<UserModeL?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      return UserModeL.fromJson(response["data"]);
    } 
    on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
     catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Update profile data

  // Logout
}
