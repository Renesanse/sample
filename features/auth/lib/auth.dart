library auth;

import "package:auth/src/data/auth_repository_impl.dart";
import "package:auth/src/domain/auth_repository.dart";
import "package:isolated_http_client/isolated_http_client.dart";
import "src/data/auth_api.dart";

part "src/domain/entities/country.dart";
part "src/domain/entities/auth_state.dart";
part "src/domain/auth_use_case.dart";

AuthUseCase authUseCase(HttpClient client, String host) => AuthUseCase(AuthRepositoryImpl(AuthApiImpl(client, host)));
