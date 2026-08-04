import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_endpoints.dart';
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
  try {
    final response = await apiService.post(
      ApiEndpoints.login,
      {
        "email": email,
        "password": password,
      },
    );

    final token = response["access_token"];

    if (token == null) {
      throw ApiError(message: "Login failed");
    }

    await PrefHelpers.saveToken(token);

    return await getProfileData();
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  }
}

  // Signup
  Future<UserModeL?> singnup(
  String name,
  String email,
  String password,
) async {
  try {
    final response = await apiService.post(
      ApiEndpoints.register,
      {
        "name": name.trim(),
        "email": email.trim(),
        "password": password,
        "avatar": "https://i.pravatar.cc/300",
      },
    );

    return UserModeL.fromJson(response);
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  }
}

  // Get profile Data
  Future<UserModeL?> getProfileData() async {
  try {
    final token = await PrefHelpers.getToken();

    if (token == null || token == "guest") {
      return null;
    }

    final response = await apiService.get(
      ApiEndpoints.profile,
    );

    final user = UserModeL.fromJson(response);

    _currentUser = user;

    return user;
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
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
  await PrefHelpers.removeToken();
  // إذا كنت تحفظ refresh token أيضًا
  // await PrefHelpers.removeRefreshToken();

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
