class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  static String? emailError(String email, {bool touched = false}) {
    if (!touched) return null;
    if (!isValidEmail(email)) return 'Enter a valid email address';
    return null;
  }

  static String? passwordError(String password, {bool touched = false}) {
    if (!touched) return null;
    if (!isValidPassword(password)) return 'Password must be at least 6 characters';
    return null;
  }

  static String? nameError(String name, {bool touched = false}) {
    if (!touched) return null;
    if (!isValidName(name)) return 'Enter your full name';
    return null;
  }

  static bool canSubmitLogin(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }

  static bool canSubmitSignUp(String name, String email, String password) {
    return isValidName(name) && isValidEmail(email) && isValidPassword(password);
  }
}
