// lib/product/network/model/register_user_response_model.dart
class RegisterUserResponseModel {
  RegisterUserResponseModel({
    this.mongoId,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
  });

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponseModel(
      mongoId: json['_id'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      token: json['token'] as String?,
    );
  }

  String? mongoId;
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? token;

  RegisterUserResponseModel copyWith({
    String? mongoId,
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return RegisterUserResponseModel(
      mongoId: mongoId ?? this.mongoId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': mongoId,
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'token': token,
    };
  }

  @override
  String toString() =>
      '''RegisterUserResponseModel(mongoId: $mongoId, id: $id, name: $name, email: $email, photoUrl: $photoUrl, token: $token)''';
}

class AccessTokenModel {
  AccessTokenModel({
    this.token,
    this.expirationDate,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) {
    return AccessTokenModel(
      token: json['token'] as String?,
      expirationDate: json['expirationDate'] as String?,
    );
  }
  String? token;
  String? expirationDate;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expirationDate': expirationDate,
    };
  }

  @override
  String toString() =>
      'AccessTokenModel(token: $token, expirationDate: $expirationDate)';
}
