class BaseResponse<T> {
  BaseResponse({
    required this.response,
    this.data,
  });
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return BaseResponse<T>(
      response:
          ResponseStatus.fromJson(json['response'] as Map<String, dynamic>),
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
  final ResponseStatus response;
  final T? data;

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT) {
    return {
      'response': response.toJson(),
      'data': data != null && toJsonT != null ? toJsonT(data as T) : null,
    };
  }

  bool get isSuccess => response.code == 200 || response.code == 201;
}

class ResponseStatus {
  ResponseStatus({
    required this.code,
    required this.message,
  });
  factory ResponseStatus.fromJson(Map<String, dynamic> json) {
    return ResponseStatus(
      code: json['code'] as int,
      message: json['message'] as String? ?? '',
    );
  }
  final int code;
  final String message;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
