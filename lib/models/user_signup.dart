import 'package:image_picker/image_picker.dart';

class UserSignup {
  static String name = '';
  static String email = '';
  static String birthdayDate = '';
  static String password = '';
  static XFile profilePicture = XFile('');
  static String username = '';
  static String emailVerificationToken = '';
  static String captcha = '';

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

  static set setProfilePicture(XFile profilePicture) {
    UserSignup.profilePicture = profilePicture;
  }

  static set setUserSignupname(String username) {
    UserSignup.username = username;
  }

  static set setEmailVerificationToken(String emailVerificationToken) {
    UserSignup.emailVerificationToken = emailVerificationToken;
  }

  static set setCaptcha(String captcha) {
    UserSignup.captcha = captcha;
  }
}
