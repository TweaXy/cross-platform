String? emailValidation({required String? inputValue}) {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return "Email is required";
  }
  if (!inputValue.contains('@') || inputValue.length < 4) {
    return "Email is invalid";
  }

  return null;
}

String? passwordValidation({required String? inputValue}) {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return "Password is required";
  }
  if (inputValue.length < 8) {
    return "Password must be at least 8 characters";
  }
  // if (!(inputValue.startsWith(RegExp(r'[A-Z][a-z]')))) {
  //   return 'Password should start with a letters';
  // }
    if (!(inputValue.contains(RegExp(r'[0-9]')))) {
    return 'Password should contain a number';
  }

  return null;
}

String? nameValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "Name is required";
  }
  return null;
}

String? codeValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "Code is required";
  }
  return null;
}

String? usernameValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "username is required";
  }
  return null;
}
