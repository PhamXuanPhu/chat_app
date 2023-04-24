extension Validator on String {
  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

//ít nhất 8 kí tự, có 1 kí tự đặc biệt và 1 kí tự in hoa
  bool get isValidPassword {
    return RegExp(r'^(?=.*[A-Za-z]).{8,}$').hasMatch(this);
  }
}
