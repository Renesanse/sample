part of "../../../auth.dart";

class AuthState {
  final _countries = <Country>[];
  var _email = "";
  var _birthDate = "";
  var _residence = "";

  // selfie byte array

  Iterable<Country> get countries => _countries;

  String get email => _email;

  String get birthDate => _birthDate;

  String get residence => _residence;

  void clear() {
    _countries.clear();
    _email = "";
    _birthDate = "";
    _residence = "";
  }
}
