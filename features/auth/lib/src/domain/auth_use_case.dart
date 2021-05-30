part of "../../auth.dart";

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  final authState = AuthState();

  Cancelable<void> setupCountries() {
    return repository.countries().next(onValue: (value) {
      authState._countries
        ..clear()
        ..addAll(value);
    });
  }

  void setupAuthData({
    required String email,
    required String birthDate,
    required String residence,
  }) {
    authState
      .._email = email
      .._birthDate = birthDate
      .._residence = residence;
  }

  Cancelable<void> register() {
    throw UnimplementedError();
  }

  void exit() => authState.clear();
}
