import "package:auth/auth.dart";
import "package:isolated_http_client/isolated_http_client.dart";

abstract class AuthRepository{
  Cancelable<Iterable<Country>> countries();

  Cancelable<void> auth(String username, String password);
}
