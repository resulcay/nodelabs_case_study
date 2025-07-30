class UploadImageResponseModel {
  UploadImageResponseModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
  });
  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadImageResponseModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }
  String? id;
  String? name;
  String? email;
  String? photoUrl;

  UploadImageResponseModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UploadImageResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
