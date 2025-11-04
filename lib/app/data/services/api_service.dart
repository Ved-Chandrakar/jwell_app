import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Fetch jewellery products from the API
  Future<List<Product>> fetchJewelleryProducts() async {
    try {
      final response = await _dio.get('/products/category/jewelery');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle different types of Dio exceptions
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout. Server is taking too long to respond.');
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 404) {
          throw Exception('Products not found (404).');
        } else {
          throw Exception('Server error: ${e.response?.statusCode}');
        }
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Fetch all products
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await _dio.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
