import "package:auth/auth.dart";
import "package:bolter_flutter/bolter_flutter.dart";

class RegisterPresenter extends Presenter<void> {
  final AuthUseCase _authUseCase;

  RegisterPresenter(this._authUseCase);

  void setupRegisterData({
    required String email,
    required String birthDate,
    required String residence,
  }) {
    _authUseCase.setupAuthData(email: email, birthDate: birthDate, residence: residence);
  }

}
