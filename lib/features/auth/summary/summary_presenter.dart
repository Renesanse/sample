import "package:auth/auth.dart";
import "package:bolter_flutter/bolter_flutter.dart";

class SummaryPresenter extends Presenter<void>{
  final AuthUseCase _authUseCase;

  SummaryPresenter(this._authUseCase);

  AuthState get authState  => _authUseCase.authState;

  void register() {
    // _authUseCase.register();
  }
}
