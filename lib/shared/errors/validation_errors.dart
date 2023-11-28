class ValidationErrors {
  static const String emptyEmailError = 'Email is required';
  static const String invalidEmailError = 'Email is invalid';
  static const String emptyPasswordError = 'Password is required';
  static const String passwordLengthError =
      'Password must be at least 8 characters';
  static const String passwordSmallLetterError =
      'Password should contain at least one small letter';
  static const String passwordCapitalLetterError =
      'Password should contain at least one capital letter';
  static const String passwordNumberError = 'Password should contain a number';
  static const String passwordSpecialCharacterError =
      'Password should contain at least one special character';
  static const String emptyNameError = 'Name is required';
  static const String emptyCodeError = 'Code is required';
  static const String codeLengthError = 'Code must be exactly 8 characters';
  static const String emptyUsernameError = 'Username is required';
  static const String usernameLengthError =
      'Username must be at least 4 characters';
  static const String usernameSpaceError = 'Username cannot contain spaces';
}
