
import "package:isolated_http_client/isolated_http_client.dart";

import "models/auth_models.dart";

abstract class AuthApi {
  Cancelable<Iterable<CountryModel>> countries();

  Cancelable<void> auth(String username, String password);
}

class AuthApiImpl implements AuthApi {
  final HttpClient _client;
  final String host;

  AuthApiImpl(
    this._client,
    this.host,
  );

  @override
  Cancelable<void> auth(String username, String password) {
    throw UnimplementedError();
  }

  @override
  Cancelable<Iterable<CountryModel>> countries() {
    //hardcoded here for countries api
    const host = "https://api.printful.com";
    const path = "/countries";
    return _client.get(host: host, path: path).next(onValue: (value) {
      return (value.body["result"] as List<dynamic>).map((e) => CountryModel.fromJson(e as Map<String, dynamic>));
    });
  }
}
