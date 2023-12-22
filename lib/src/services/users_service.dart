import 'dart:convert';
import 'package:attado_mobile/src/models/data_models/users/user.dart';
import 'package:attado_mobile/src/models/data_models/users/user_details.dart';
import 'package:attado_mobile/src/services/api_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersService {
  UsersService(this._api);
  final ApiService _api;

  Future<List<User>> getUsers() async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/User/all'),
      headers: _api.getHeaders(),
    );
    return List<User>.from(
      (json.decode(response.body)).map(
        (model) => User.fromJson(model),
      ),
    );
  }

  Future<UserDetails> getUser(String username) async {
    Response response;
    response = await _api.client.get(
      Uri.parse('${_api.getBaseUrl()}/api/User/$username'),
      headers: _api.getHeaders(),
    );
    return UserDetails.fromJson(json.decode(response.body));
  }
}
