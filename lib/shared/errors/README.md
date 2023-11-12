# Errors Folder README

## Purpose:

This folder contains predefined error messages used throughout the Flutter application. Centralizing error messages in one location enhances code maintainability and ensures consistency.

## Sample File Structure:

Create individual Dart files for each error type. The file should define constants for error messages as follows:

```
// File: lib/shared/errors/signup_errors.dart

class SampleErrors {
  static const String missingUserNameError = "Username is required";
  static const String missingEmailError = "Email is required";
  // Add more error constants as needed
}
```

## Usage:

Import the error constants in your code where needed:

```
import 'package:tweaxy/shared/errors/signup_errors.dart';

// ...

try {
  // ...
} catch (e) {
  print(SampleErrors.networkError);
}
```
