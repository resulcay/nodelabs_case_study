class ErrorResponseModel {
  ErrorResponseModel({
    this.type,
    this.title,
    this.status,
    this.detail,
    this.baseMessage,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: json['status'] as int?,
      detail: json['detail'] as String?,
      baseMessage:
          json['response'] != null && json['response'] is Map<String, dynamic>
              ? (json['response'] as Map<String, dynamic>)['message'] as String?
              : null,
    );
  }

  String? type;
  String? title;
  int? status;
  String? detail;
  String? baseMessage;

  ErrorResponseModel copyWith({
    String? type,
    String? title,
    int? status,
    String? detail,
    String? baseMessage,
  }) {
    return ErrorResponseModel(
      type: type ?? this.type,
      title: title ?? this.title,
      status: status ?? this.status,
      detail: detail ?? this.detail,
      baseMessage: baseMessage ?? this.baseMessage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'status': status,
      'detail': detail,
      'response': {
        'message': baseMessage,
      },
    };
  }

  String get displayMessage => detail ?? baseMessage ?? '';
}
