import 'dart:io';
import 'package:attado_mobile/src/exceptions/unauthorized_exception.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

@injectable
class ApiService {
  ApiService(this._authRepo);
  final AuthRepo _authRepo;

  http.Client client = IOClient(
    HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true),
  );

  String getBaseUrl() {
    if (_authRepo.serverUrl != null) {
      return _authRepo.serverUrl!;
    } else {
      throw UnauthorizedException();
    }
  }

  Map<String, String> getHeaders() {
    if (_authRepo.token != null) {
      return {
        HttpHeaders.authorizationHeader: 'Bearer ${_authRepo.token!.value}',
        'Content-Type': 'application/json; charset=UTF-8',
      };
    } else {
      throw UnauthorizedException();
    }
  }

  String getPagingParameters(int page, int pageSize) {
    return '?pageSize=$pageSize&page=$page';
  }
}
