class User {
  User({
    required this.mongoId,
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      mongoId: json['_id'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      token: json['token'] as String,
    );
  }
  final String mongoId;
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

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

  User copyWith({
    String? mongoId,
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return User(
      mongoId: mongoId ?? this.mongoId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }
}
