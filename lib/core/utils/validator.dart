abstract class Validator {
  Validator._();

  static bool validateEmail(String email) {
    if (email.isEmpty) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validatePassword(String password) {
    return password.isNotEmpty && password.length >= 8;
  }
}
