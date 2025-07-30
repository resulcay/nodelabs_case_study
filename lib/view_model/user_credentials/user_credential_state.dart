class UserCredentialState {
  const UserCredentialState({
    this.accessToken,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  final String? accessToken;
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  UserCredentialState copyWith({
    String? accessToken,
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserCredentialState(
      accessToken: accessToken ?? this.accessToken,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  bool get isAuthenticated => accessToken != null && accessToken!.isNotEmpty;
}
