class LoginUserResponseModel {
  LoginUserResponseModel({
    this.mongoId,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
  });

  factory LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginUserResponseModel(
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

  LoginUserResponseModel copyWith({
    String? mongoId,
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return LoginUserResponseModel(
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
      '''LoginUserResponseModel(mongoId: $mongoId, id: $id, name: $name, email: $email, photoUrl: $photoUrl, token: $token)''';
}

class AccessToken {
  AccessToken({
    this.token,
    this.expirationDate,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      token: json['token'] as String?,
      expirationDate: json['expirationDate'] as String?,
    );
  }
  String? token;
  String? expirationDate;

  AccessToken copyWith({
    String? token,
    String? expirationDate,
  }) {
    return AccessToken(
      token: token ?? this.token,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expirationDate': expirationDate,
    };
  }

  @override
  String toString() =>
      'AccessToken(token: $token, expirationDate: $expirationDate)';
}

class LoggedUserDetail {
  LoggedUserDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.phoneNumber,
    this.email,
  });

  factory LoggedUserDetail.fromJson(Map<String, dynamic> json) {
    return LoggedUserDetail(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileImage: json['profileImage'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );
  }

  String? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? phoneNumber;
  String? email;

  LoggedUserDetail copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? phoneNumber,
    String? email,
  }) {
    return LoggedUserDetail(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  @override
  String toString() =>
      '''LoggedUserDetail(id: $id, firstName: $firstName, lastName: $lastName, profileImage: $profileImage, phoneNumber: $phoneNumber, email: $email)''';
}
