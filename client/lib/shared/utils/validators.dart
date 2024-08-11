import 'package:client/shared/constants/regex.dart';

String? requiredFieldValidator(String? value,
    {String? message = "This field is required"}) {
  if (value == null || value.isEmpty) {
    return message;
  }

  return null;
}

String? emailFieldValidator(String? value,
    {String? message = "Enter a valid email", bool? isRequired = true}) {
  if (isRequired == true) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
  }

  if (value == null || !DefaultMatchers.email.hasMatch(value)) {
    return message;
  }

  return null;
}

String? phoneNumberFieldValidator(String? value,
    {String? message = "Enter a valid phone number", bool? isRequired = true}) {
  if (isRequired == true) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
  }

  if (value == null || !DefaultMatchers.phoneNumber.hasMatch(value)) {
    return message;
  }

  return null;
}

String? passwordFieldValidator(String? value,
    {String? message = "Password must not be less than 8 characters",
    bool? isRequired = true}) {
  if (isRequired == true) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
  }

  if (value == null || value.length < 8) {
    return message;
  }

  return null;
}
