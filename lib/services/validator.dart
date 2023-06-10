extension Validator on String {
  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

//ít nhất 8 kí tự
  bool get isValidPassword {
    return RegExp(r'^(?=.*[A-Za-z]).{8,}$').hasMatch(this);
  }

  bool get isValidPhoneNumber {
    return RegExp(r'^0[^0146]\d{8}$').hasMatch(this);
  }
}
