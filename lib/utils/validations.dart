String? cannotBeEmpty({String? value, required String name}) {
  if (value?.isEmpty ?? true) {
    return '$name can not be empty';
  }
  return null;
}

String? validatePhoneNumber({String? value, required String name}) {
  if (value?.isEmpty ?? true) {
    return '$name can not be empty';
  }
  if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value!)) {
    return 'Please enter a valid $name';
  }
  return null;
}

String? onlySimpleString({String? value, required String name}) {
  if (value?.isEmpty ?? true) {
    return '$name can not be empty';
  }
  if (!RegExp(r"^[a-zA-Z]$").hasMatch(value!)) {
    return 'Only characters are allowed for $name';
  }
  return null;
}

String? validatePIN(String? value) {
  if (value?.isEmpty ?? true) {
    return 'PIN can not be empty';
  }
  if (!RegExp(r"^[1-9]{1}[0-9]{5}$").hasMatch(value!)) {
    return 'Please enter a valid PIN';
  }
  return null;
}
