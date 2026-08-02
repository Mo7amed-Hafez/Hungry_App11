import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/home/data/product_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  // get products

  Future<List<ProductModel>?> getProducts() async {
    try {
      final response = await _apiService.get('/products/');
      return (response['data'] as List)
          .map((product1) => ProductModel.fromJson(product1))
          .toList();
    } catch (e) {
      print(e.toString());
      // final error = e as ApiError;
      // print(error.message.toString());
      // throw ApiError(message: e.toString());
      return [];
    }
  }

  // Search products

  // categories
}
