String? emailValidation({required String? inputValue}) {
  //initial validation function
  if (inputValue == null || inputValue.isEmpty) {
    return "Email is required";
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
  return null;
}

String? nameValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "Name is required";
  }
  if (inputValue.length > 50) {
    return "Name must be less than 50 character";
  }
  return null;
}

String? codeValidation({required String? inputValue}) {
  if (inputValue == null || inputValue.isEmpty) {
    return "Code is required";
  }
  return null;
}
