import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal() {
    _dio = Dio();
    // Configure Dio with interceptors for logging
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ));
    }
    // Configure default options
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
  }

  late final Dio _dio;

  /// Generic GET request
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('Network GET Error: ${e.message}');
      debugPrint('URL: $url');
      debugPrint('Query Parameters: $queryParameters');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error in GET request: $e');
      rethrow;
    }
  }

  /// Generic POST request
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('Network POST Error: ${e.message}');
      debugPrint('URL: $url');
      debugPrint('Data: $data');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error in POST request: $e');
      rethrow;
    }
  }

  /// Generic PUT request
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('Network PUT Error: ${e.message}');
      debugPrint('URL: $url');
      debugPrint('Data: $data');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error in PUT request: $e');
      rethrow;
    }
  }

  /// Generic DELETE request
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('Network DELETE Error: ${e.message}');
      debugPrint('URL: $url');
      debugPrint('Query Parameters: $queryParameters');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error in DELETE request: $e');
      rethrow;
    }
  }

  /// Handle common response processing
  Map<String, dynamic> processResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Map<String, dynamic>.from(response.data);
    } else {
      throw Exception('HTTP Error: ${response.statusCode} - ${response.statusMessage}');
    }
  }

  /// Handle common error processing
  Exception handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout. Please check your internet connection.');
        case DioExceptionType.badResponse:
          return Exception('Server error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled');
        case DioExceptionType.connectionError:
          return Exception('No internet connection');
        default:
          return Exception('Network error: ${error.message}');
      }
    }
    return Exception('Unexpected error: $error');
  }
} 