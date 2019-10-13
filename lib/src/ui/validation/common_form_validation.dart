import 'package:bank_cards/generated/i18n.dart';
import 'package:flutter/material.dart';

class CommonFormValidation {
  BuildContext commonValidationContext;

  String requiredField(String value) {
    if(value == null || value.isEmpty) {
      return S.of(commonValidationContext).required_field;
    }

    return null;
  }

  String emailValidation(String email) {

    if(email == null || email.isEmpty) {
      return S.of(commonValidationContext).required_field;
    }

    if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return S.of(commonValidationContext).invalid_email;
    }

    return null;

  }

}