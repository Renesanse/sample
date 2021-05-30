import "package:auth/auth.dart";
import "package:auth/src/data/auth_api.dart";
import "package:auth/src/domain/auth_repository.dart";
import "package:isolated_http_client/isolated_http_client.dart";

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl(this.api);

  @override
  Cancelable<Iterable<Country>> countries() => api
      .countries()
      .next(onValue: (v) => v.where((element) => element.name != null).map((e) => Country(name: e.name!)));

  @override
  Cancelable<void> auth(String username, String password) {
    throw UnimplementedError();
  }
}
