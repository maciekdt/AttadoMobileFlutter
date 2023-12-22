import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:attado_mobile/src/models/auth_models/auth_user.dart';
import 'package:attado_mobile/src/models/auth_models/token.dart';
import 'package:attado_mobile/src/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepo {
  AuthRepo(this._authService);
  final AuthService _authService;
  final String _authUserKey = "authUserKey";
  final String _serverUrlKey = "serverUrlKey";
  final String _biometricAuthKey = "biometricAuthKey";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _logName = "AuthRepo";

  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;

  String? _serverUrl;
  String? get serverUrl => _serverUrl;

  Token? _token;
  Token? get token => _token;

  Future<void> login(AuthUser authUser, String serverUrl) async {
    _token = await _authService.login(authUser, serverUrl);
    _authUser = authUser;
    _serverUrl = serverUrl;
    await Future.wait([
      _saveAuthUserToSecureStorage(authUser),
      _saveServerUrlToSecureStorage(serverUrl),
    ]);
    log(
      "User login success, token saved to repo",
      name: _logName,
    );
  }

  Future<bool> loginFromStorage() async {
    try {
      AuthUser? authUser = await _getAuthUserFromSecureStorage();
      String? serverUrl = await getServerUrlFromSecureStorage();
      log(
        "User data restored from SecureStorage serverUrl=$serverUrl authUser=${jsonEncode(authUser)}",
        name: _logName,
      );
      if (authUser != null && serverUrl != null) {
        _token = await _authService.login(authUser, serverUrl);
        _authUser = authUser;
        _serverUrl = serverUrl;
        log(
          "User login from storage success, token saved to repo",
          name: _logName,
        );
        return true;
      } else if (serverUrl != null) {
        _serverUrl = serverUrl;
      }
      return false;
    } on SocketException catch (_) {
      rethrow;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _storage.delete(key: _authUserKey);
    _storage.delete(key: _biometricAuthKey);
    _authUser = null;
    _token = null;
  }

  Future<void> _saveAuthUserToSecureStorage(AuthUser authUser) async {
    await _storage.write(
      key: _authUserKey,
      value: jsonEncode(authUser),
    );
  }

  Future<void> _saveServerUrlToSecureStorage(String serverUrl) async {
    await _storage.write(
      key: _serverUrlKey,
      value: serverUrl,
    );
  }

  Future<void> saveBiometricAuthToSecureStorage(bool biometricAuth) async {
    await _storage.write(
        key: _biometricAuthKey, value: biometricAuth ? 'true' : 'false');
  }

  Future<AuthUser?> _getAuthUserFromSecureStorage() async {
    String? authUser = await _storage.read(key: _authUserKey);
    if (authUser != null) {
      return AuthUser.fromJson(json.decode(authUser));
    } else {
      return null;
    }
  }

  Future<String?> getServerUrlFromSecureStorage() async {
    return await _storage.read(key: _serverUrlKey);
  }

  Future<bool> getBiometricAuthFromSecureStorage() async {
    String? value = await _storage.read(key: _biometricAuthKey);
    log(
      "Biometric option restored from secure storage value=$value",
      name: _logName,
    );
    if (value == null) return false;
    return value == 'true';
  }
}
