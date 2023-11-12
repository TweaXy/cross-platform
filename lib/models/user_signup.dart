class UserSignup {
  static String name = '';
  static String email = '';
  static String birthdayDate = '';
  static String password = '';
  static String profilePicture = '';
  static String username = '';
  static String emailVerificationToken = '';

  static set setName(String name) {
    UserSignup.name = name;
  }

  static set setEmail(String email) {
    UserSignup.email = email;
  }

  static set setBirthdayDate(String birthdayDate) {
    UserSignup.birthdayDate = birthdayDate;
  }

  static set setPassword(String password) {
    UserSignup.password = password;
  }

  static set setProfilePicture(String profilePicture) {
    UserSignup.profilePicture = profilePicture;
  }

  static set setUserSignupname(String username) {
    UserSignup.username = username;
  }

  static set setEmailVerificationToken(String emailVerificationToken) {
    UserSignup.emailVerificationToken = emailVerificationToken;
  }
}
