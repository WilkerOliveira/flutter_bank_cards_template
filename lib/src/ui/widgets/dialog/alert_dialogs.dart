import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/exceptions/exception_messages.dart';
import 'package:bank_cards/src/ui/widgets/dialog/custom_dialog.dart';
import 'package:bank_cards/src/ui/widgets/dialog/reset_password_dialog.dart';
import 'package:flutter/material.dart';

class AlertDialogs {
  static String _getMessage(
      BuildContext context, ExceptionMessages exceptionMessage) {
    switch (exceptionMessage) {
      case ExceptionMessages.userNotRegistered:
        return S.of(context).user_not_registered;
      case ExceptionMessages.cancelledByUser:
        return S.of(context).login_cancelled_by_user;
      case ExceptionMessages.error:
        return S.of(context).default_error;
      case ExceptionMessages.userEmailAlreadyExists:
        return S.of(context).user_email_already_exist;
      case ExceptionMessages.userNickNameAlreadyExists:
        return S.of(context).user_nickname_already_exist;
      case ExceptionMessages.passwordNotMatch:
        return S.of(context).password_not_match;
      case ExceptionMessages.noInternetConnection:
        return S.of(context).no_internet_connection;
      case ExceptionMessages.invalidEmailOrPassword:
        return S.of(context).invalid_email_or_password;
      default:
        return S.of(context).default_error;
    }
  }

  static void showErrorDialog(
      BuildContext context, String title, ExceptionMessages exceptionMessages) {

    String errorMessage = exceptionMessages == null
        ? S.of(context).default_error
        : _getMessage(context, exceptionMessages);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: errorMessage,
        buttonText: S.of(context).close_button.toUpperCase(),
        color: Colors.red,
        dialogType: DialogType.error,
      ),
    );
  }

  static void showInfoDialog(
      BuildContext context, String title, ExceptionMessages exceptionMessages) {

    String message = exceptionMessages == null
        ? S.of(context).default_error
        : _getMessage(context, exceptionMessages);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: message,
        buttonText: S.of(context).close_button.toUpperCase(),
        color: Colors.amber,
        dialogType: DialogType.info,
      ),
    );
  }

  static void showSuccessDialog(
      BuildContext context, String title, String message, callbackFunction) {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: message,
        buttonText: S.of(context).close_button.toUpperCase(),
        color: Colors.green,
        dialogType: DialogType.success,
      ),
    ).then((val){
      if(callbackFunction != null) callbackFunction();
    });
  }

  static void showResetPassword(
      BuildContext context, callbackFunction) {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ResetPasswordDialog(),
    ).then((val){
      if(callbackFunction != null) callbackFunction();
    });
  }
}
