# Keys Folder README

## Purpose:

This folder contains predefined widget keys used for testing purposes within the Flutter application. Centralizing keys in one location enhances code maintainability and ensures consistency in testing scenarios.

## Sample File Structure:

Create individual Dart files for each key type. The file should define constants for widget keys as follows:

```
// File: lib/shared/keys/signin_keys.dart

class SampleWidgetKeys {
  static const String loginButtonKey = 'login_button';
  static const String usernameFieldKey = 'username_field';
  static const String passwordFieldKey = 'password_field';
  // Add more widget keys as needed
}
```

## Usage:

Assign these keys to the corresponding widgets in your code:

```
import 'package:tweaxy/shared/keys/signin_keys.dart';

// Example usage of widget keys
Button(
  key: Key(SampleWidgetKeys.loginButtonKey),
  onPressed: () {
    // Your login button logic
  },
  child: Text('Login'),
),
```

## Testing Usage:

Use these keys in your widget tests to interact with specific widgets:

```
import 'package:tweaxy/shared/keys/signin_keys.dart';

testWidgets('Tapping the login button triggers the login process', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());

  // Find the login button using the predefined key
  final loginButton = find.byKey(Key(SampleWidgetKeys.loginButtonKey));

  // Tap the login button
  await tester.tap(loginButton);

  // Wait for the UI to rebuild
  await tester.pump();

  // Add your assertions here
});
```
