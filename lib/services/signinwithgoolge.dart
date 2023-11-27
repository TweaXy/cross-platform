import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    if (googleSignInAccount == null) {
      // Handle user cancellation
      return;
    }
    // Send the token to your server for validation
    // You'd typically send this token to your backend and perform validation there
    // For instance, using this token in your API request to validate on your server

    print('Access Token: ${googleSignInAuthentication.accessToken}');
    print('Id Token: ${googleSignInAuthentication.idToken}');

    // Send the Id Token to your backend
    // Make an API call to your server with this token
    // Your server would then validate this token using Google's API

    // Call your backend API to authenticate the user with this token
    // await authenticateUserWithBackend(googleSignInAuthentication.idToken);

    // Now you can use the information from the account for your app
    // For example:
    // String userEmail = googleSignInAccount.email;
    // String userName = googleSignInAccount.displayName;
    // String userPhotoUrl = googleSignInAccount.photoUrl;
    // ...
  } catch (error) {
    print('Google Sign-In error: $error'
      );
    // Handle the sign-in error
  }
}
