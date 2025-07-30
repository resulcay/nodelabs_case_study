import 'package:dio/dio.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/network/base_config/api_call_mixin.dart';
import 'package:nodelabs_case_study/product/network/base_config/base_repository.dart';
import 'package:nodelabs_case_study/product/network/model/base_response_model.dart';
import 'package:nodelabs_case_study/product/network/model/login_user_response_model.dart';
import 'package:nodelabs_case_study/product/network/model/register_user_response_model.dart';
import 'package:nodelabs_case_study/product/network/model/upload_image_response_model.dart';

class AuthManager {
  AuthManager({required AuthRepository authRepository})
      : _authRepository = authRepository;
  final AuthRepository _authRepository;

  Future<BaseResponse<RegisterUserResponseModel>?> registerUser({
    required String name,
    required String email,
    required String password,
  }) {
    return _authRepository.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<BaseResponse<LoginUserResponseModel>?> loginUser({
    required String email,
    required String password,
  }) {
    return _authRepository.loginUser(
      email: email,
      password: password,
    );
  }

  Future<BaseResponse<UploadImageResponseModel>?> uploadPhoto({
    required FormData formData,
  }) {
    return _authRepository.uploadPhoto(formData: formData);
  }
}

class AuthRepository extends BaseRepository
    with ApiCallMixin
    implements IAuthRepository {
  AuthRepository(this.dioClient);

  @override
  final Dio dioClient;

  @override
  Future<BaseResponse<RegisterUserResponseModel>?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };
    return wrapExecuteApiCall(
      () async => dioClient.post(
        TextConstants.registerUser,
        data: data,
      ),
      (data) => BaseResponse<RegisterUserResponseModel>.fromJson(
        data as Map<String, dynamic>,
        RegisterUserResponseModel.fromJson,
      ),
    );
  }

  @override
  Future<BaseResponse<LoginUserResponseModel>?> loginUser({
    required String email,
    required String password,
  }) async {
    final data = {
      'email': email,
      'password': password,
    };
    return wrapExecuteApiCall(
      () async => dioClient.post(
        TextConstants.loginUser,
        data: data,
      ),
      (data) => BaseResponse<LoginUserResponseModel>.fromJson(
        data as Map<String, dynamic>,
        LoginUserResponseModel.fromJson,
      ),
    );
  }

  @override
  Future<BaseResponse<UploadImageResponseModel>?> uploadPhoto({
    required FormData formData,
  }) async {
    return wrapExecuteApiCall(
      () async => dioClient.post(
        TextConstants.uploadPhoto,
        data: formData,
      ),
      (data) => BaseResponse<UploadImageResponseModel>.fromJson(
        data as Map<String, dynamic>,
        UploadImageResponseModel.fromJson,
      ),
    );
  }
}

abstract class IAuthRepository {
  Future<BaseResponse<RegisterUserResponseModel>?> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<BaseResponse<LoginUserResponseModel>?> loginUser({
    required String email,
    required String password,
  });

  Future<BaseResponse<UploadImageResponseModel>?> uploadPhoto({
    required FormData formData,
  });
}
