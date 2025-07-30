import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nodelabs_case_study/product/network/base_config/base_repository.dart';
import 'package:nodelabs_case_study/product/network/model/error_response_model.dart';

mixin ApiCallMixin<T extends BaseRepository> on BaseRepository {
  Future<R> wrapExecuteApiCall<R>(
    Future<Response<Map<String, dynamic>>> Function() apiCall,
    R Function(dynamic data) parseResponse,
  ) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return parseResponse(response.data);
      }

      throw Exception('Unexpected status code: ${response.statusCode}');
    } on DioException catch (dioError) {
      final response = dioError.response;

      if (response != null && response.data != null) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          final errorModel = ErrorResponseModel.fromJson(data);
          throw ErrorResponseException(errorModel);
        }

        if (data is String) {
          final decoded = jsonDecode(data);
          if (decoded is Map<String, dynamic>) {
            final errorModel = ErrorResponseModel.fromJson(decoded);
            throw ErrorResponseException(errorModel);
          }
        }
      }

      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection Timeout. Please try again later.');
      }

      if (dioError.type == DioExceptionType.unknown &&
          dioError.error is SocketException) {
        throw Exception(
          'Network Error. Please check your internet connection.',
        );
      }

      throw Exception('Unexpected DioError: ${dioError.message}');
    } catch (e) {
      throw Exception('Unexpected Error: $e');
    }
  }
}

class ErrorResponseException implements Exception {
  ErrorResponseException(this.error);
  final ErrorResponseModel error;

  @override
  String toString() => 'ErrorResponseException: ${error.detail}';
}
