import 'package:bank_cards/generated/i18n.dart';
import 'package:flutter/material.dart';

class RegisterFormValidation {
  BuildContext registerValidationContext;

  String passwordValidation(String value) {
    if (value == null || value.isEmpty) {
      return S.of(registerValidationContext).required_field;
    }

    if (value.length < 6) return S.of(registerValidationContext).invalid_password_format;

    return null;
  }
}
