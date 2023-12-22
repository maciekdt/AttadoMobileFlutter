import 'dart:io';
import 'package:attado_mobile/src/exceptions/internal_server_exception.dart';
import 'package:attado_mobile/src/exceptions/no_mobile_license_exception.dart';
import 'package:attado_mobile/src/exceptions/unauthorized_exception.dart';
import 'package:attado_mobile/src/models/auth_models/auth_user.dart';
import 'package:attado_mobile/src/models/auth_models/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  http.Client client = IOClient(
    HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true),
  );

  Future<Token> login(AuthUser authUser, String serverUrl) async {
    Response response;
    String url = serverUrl;
    response = await client.post(
      Uri.parse("$url/api/Auth"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": authUser.username,
        "password": authUser.password,
        "isMobileLogin": true,
      }),
    );

    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw UnauthorizedException(status: response.statusCode);
    } else if (response.statusCode == 403) {
      throw NoMobileLicenseException(status: response.statusCode);
    }
    throw InternalServerException(status: response.statusCode);
  }
}
