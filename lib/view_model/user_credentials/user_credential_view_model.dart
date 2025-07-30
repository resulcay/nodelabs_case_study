import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodelabs_case_study/product/base/base_cubit.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_state.dart';

class UserCredentialViewModel extends BaseCubit<UserCredentialState> {
  UserCredentialViewModel() : super(const UserCredentialState());

  bool get isAuthenticated => state.isAuthenticated;
  String? get userId => state.id;
  String? get userName => state.name;
  String? get userEmail => state.email;
  String? get userPhotoUrl => state.photoUrl;

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _accessTokenKey = 'access_token';
  static const String _expiryKey = 'user_expiry';
  static const String _idKey = 'user_id';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _photoUrlKey = 'photo_url';

  String get accessTokenKey => _accessTokenKey;

  Future<String?> get userIdToFirebase async {
    return _storage.read(key: _idKey);
  }

  Future<void> loadCredentials() async {
    try {
      final results = await Future.wait([
        _storage.read(key: _accessTokenKey),
        _storage.read(key: _expiryKey),
        _storage.read(key: _idKey),
        _storage.read(key: _nameKey),
        _storage.read(key: _emailKey),
        _storage.read(key: _photoUrlKey),
      ]);

      final accessToken = results[0];
      final expiryString = results[1];
      final id = results[2];
      final name = results[3];
      final email = results[4];
      final photoUrl = results[5];

      if (accessToken != null &&
          expiryString != null &&
          accessToken.isNotEmpty) {
        final expiry = int.tryParse(expiryString) ?? 0;

        if (DateTime.now().millisecondsSinceEpoch < expiry) {
          emit(
            state.copyWith(
              accessToken: accessToken,
              id: id,
              name: name,
              email: email,
              photoUrl: photoUrl,
            ),
          );
          return;
        }
      }

      await clearCredentials();
    } on PlatformException catch (_) {
      await clearCredentials();
    }
  }

  Future<void> saveCredentials({
    required String accessToken,
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) async {
    try {
      final expiry =
          DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch;

      await Future.wait([
        _storage.write(key: _accessTokenKey, value: accessToken),
        _storage.write(key: _expiryKey, value: expiry.toString()),
        if (id != null) _storage.write(key: _idKey, value: id),
        if (name != null) _storage.write(key: _nameKey, value: name),
        if (email != null) _storage.write(key: _emailKey, value: email),
        if (photoUrl != null)
          _storage.write(key: _photoUrlKey, value: photoUrl),
      ]);

      emit(
        state.copyWith(
          accessToken: accessToken,
          id: id ?? state.id,
          name: name ?? state.name,
          email: email ?? state.email,
          photoUrl: photoUrl ?? state.photoUrl,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserProfile({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) async {
    try {
      await Future.wait([
        if (id != null) _storage.write(key: _idKey, value: id),
        if (name != null) _storage.write(key: _nameKey, value: name),
        if (email != null) _storage.write(key: _emailKey, value: email),
        if (photoUrl != null)
          _storage.write(key: _photoUrlKey, value: photoUrl),
      ]);

      emit(
        state.copyWith(
          id: id ?? state.id,
          name: name ?? state.name,
          email: email ?? state.email,
          photoUrl: photoUrl ?? state.photoUrl,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearCredentials() async {
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _expiryKey),
        _storage.delete(key: _idKey),
        _storage.delete(key: _nameKey),
        _storage.delete(key: _emailKey),
        _storage.delete(key: _photoUrlKey),
      ]);

      emit(const UserCredentialState());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final expiryString = await _storage.read(key: _expiryKey);
      final accessToken = await _storage.read(key: _accessTokenKey);

      if (expiryString == null || accessToken == null || accessToken.isEmpty) {
        await clearCredentials();
        return false;
      }

      final expiry = int.tryParse(expiryString) ?? 0;

      if (DateTime.now().millisecondsSinceEpoch > expiry) {
        await clearCredentials();
        return false;
      }

      return true;
    } on Exception catch (_) {
      await clearCredentials();
      return false;
    }
  }
}
