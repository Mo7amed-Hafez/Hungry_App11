import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/auth_model.dart';

class AuthRepo {
  // object of api service class for api calls
  ApiService apiService = ApiService();

  // As a Guest
  bool isGuest = false;
  UserModeL? _currentUser;

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
        // handle success from server to get updateUser data and token
        final updateUser = UserModeL.fromJson(response["data"]);
        if (updateUser.token != null) {
          await PrefHelpers.saveToken(updateUser.token!);
        }
        isGuest = false;
        _currentUser =
            updateUser; // علشان نخزن معلومات اليوزر محليا في الهاتف قبل تسجيل الدخول
        return updateUser;
      } else {
        throw ApiError(message: "Unexpected error from server");
      }
      // return updateUser data for use it in the app
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

        final updateUser = UserModeL.fromJson(response["data"]);
        if (updateUser.token != null) {
          await PrefHelpers.saveToken(updateUser.token!);
        }
        isGuest = false;
        _currentUser = updateUser;
        // return updateUser data after register and save token if not error
        return updateUser;
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
      final token = await PrefHelpers.getToken();
      if (token == null || token == 'guest') {
        // isGuest = true;
        return null;
      }
      final response = await apiService.get('/profile');
      final updateUser = UserModeL.fromJson(response["data"]);
      _currentUser = updateUser;
      return updateUser;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Update profile data
  Future<UserModeL?> updateProfileData({
    required String name,
    required String email,
    String? address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'visa': visa,
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: "profile.jpg",
          ),
        // 'image': imagePath ,
      });
      final response = await apiService.post('/update-profile', formData);
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

        final updateUser = UserModeL.fromJson(response["data"]);
        if (updateUser.token != null) {
          await PrefHelpers.saveToken(updateUser.token!);
        }
        _currentUser = updateUser;
        // return updateUser data after register and save token if not error
        return updateUser;
      } else {
        throw ApiError(message: "Unexpected error from server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response is ApiError) {
      throw response;
    }
    if (response["data"] != null) {
      throw ApiError(message: "Unexpected error from server");
    }
    await PrefHelpers.removeToken(); // علشان احذف التوكن بعد تسجيل الخروج من التطبيق
    _currentUser = null;
    isGuest = true;
  }

  // Auto login 
  // use in Splash Screen
 Future<UserModeL?> autoLogin() async {
  final token = await PrefHelpers.getToken();

  if (token == null || token == 'guest') {
    isGuest = true;
    _currentUser = null;
    return null;
  }

  try {
    final user = await getProfileData();
    _currentUser = user;

    // ✅ أهم سطر
    isGuest = false;

    return user;
  } catch (_) {
    await PrefHelpers.removeToken();
    isGuest = true;
    _currentUser = null;
    return null;
  }
}

  // Continue as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelpers.saveToken('guest');
  }

  UserModeL ? get currentUser => _currentUser;
  bool get isLogedIn => !isGuest && _currentUser != null;
}
