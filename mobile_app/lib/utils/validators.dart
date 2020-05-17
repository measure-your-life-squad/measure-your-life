class Validators {
  static String validateEmail(String email, String fieldName) {
    String result = validateField(email, 'Email');
    if (result != null) {
      return result;
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email)) {
      return fieldName + ' is invalid';
    }

    return null;
  }

  static String validateField(String value, String fieldName) {
    if (value.isEmpty) {
      return fieldName + ' cannot be empty';
    }

    return null;
  }

  static String validateConfirmedPassword(
      String repeatedPassword, String password) {
    if (repeatedPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    if (password != repeatedPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static Map<String, RegExp> getHourValidator() {
    return {
      "#": RegExp(r'[0-2]'),
      "@": RegExp(r'[0-9]'),
      "&": RegExp(r'[0-5]')
    };
  }
}
