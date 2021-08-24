import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

mixin ValidationMixin {
  String? validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else if (!GetUtils.isPhoneNumber(value))
      return 'Provide valid phone number';
    else
      return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter email";
    } else if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    } else {
      return null;
    }
  }
  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please enter name";
    } else {
      return null;
    }
  }
  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp _regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Please enter password";
    } else if (value.length < 8) {
      return "Password must be of 8 characters";
    } else if (!_regExp.hasMatch(value))
      return "Password should be like this Santosh@1234";
    else
      return null;
  }
}
enum FieldError { Empty, Invalid }
