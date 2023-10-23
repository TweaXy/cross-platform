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
