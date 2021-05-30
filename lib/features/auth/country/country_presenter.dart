import "package:auth/auth.dart";
import "package:bolter_flutter/bolter_flutter.dart";
import "package:isolated_http_client/isolated_http_client.dart";

class CountryPresenter extends Presenter<void> {
  final AuthUseCase _authUseCase;

  CountryPresenter(this._authUseCase);

  Cancelable<void>? _setup;
  var _filter = "";

  Cancelable<void> setup() {
    _setup?.cancel();
    return _setup = _authUseCase.setupCountries();
  }

  ValueStream<Iterable<Country>> get countries => stream(() =>
      _authUseCase.authState.countries.where((element) => element.name.toLowerCase().contains(_filter.toLowerCase())));

  void filter(String value) {
    _filter = value;
    updateUI();
  }

  @override
  void dispose() {
    _setup?.cancel();
    super.dispose();
  }
}
