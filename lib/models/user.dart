class User {
  static String name = '';
  static String email = '';
  static String birthdayDate = '';
  static String password = '';
  static String profilePicture = '';
  static String username = '';
  static String emailVerificationToken = '';

  static set setName(String name) {
    User.name = name;
  }

  static set setEmail(String email) {
    User.email = email;
  }

  static set setBirthdayDate(String birthdayDate) {
    User.birthdayDate = birthdayDate;
  }

  static set setPassword(String password) {
    User.password = password;
  }

  static set setProfilePicture(String profilePicture) {
    User.profilePicture = profilePicture;
  }

  static set setUsername(String username) {
    User.username = username;
  }

  static set setEmailVerificationToken(String emailVerificationToken) {
    User.emailVerificationToken = emailVerificationToken;
  }
}
