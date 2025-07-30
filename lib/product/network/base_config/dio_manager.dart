import 'package:dio/dio.dart';

import 'package:nodelabs_case_study/product/env/env_manager.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_view_model.dart';

class DioManager {
  factory DioManager() => _instance;
  DioManager._internal() {
    _dio.options = _baseOptions;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_currentLanguageCode != null) {
            options.headers['Accept-Language'] = _currentLanguageCode;
          }

          final token = _userCredentialViewModel?.state.accessToken;

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            await _userCredentialViewModel?.clearCredentials();
          }
          return handler.next(error);
        },
      ),
    );
  }

  static final DioManager _instance = DioManager._internal();

  final Dio _dio = Dio();
  static final String _baseUrl = EnvManager.baseUrl;

  UserCredentialViewModel? _userCredentialViewModel;

  static final BaseOptions _baseOptions = BaseOptions(baseUrl: _baseUrl);

  Dio get client => _dio;

  String? _currentLanguageCode;

  void setLanguage(String languageCode) {
    _currentLanguageCode = languageCode;
    logger.info('Language set to: $_currentLanguageCode for DioManager');
  }

  void setUserCredentialViewModel(UserCredentialViewModel viewModel) {
    _userCredentialViewModel = viewModel;
    logger.info('UserCredentialViewModel set for DioManager');
  }
}
