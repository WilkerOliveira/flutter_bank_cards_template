import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatefulWidget {
  final Function onResetPassword;

  ResetPasswordDialog({Key key, @required this.onResetPassword});

  @override
  _ResetPasswordDialogState createState() =>
      _ResetPasswordDialogState(this.onResetPassword);
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog>
    with CommonFormValidation {
  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
  static const double iconSize = 32.0;
  final Function _onResetPassword;
  final _formKey = GlobalKey<FormState>();

  _ResetPasswordDialogState(this._onResetPassword);

  @override
  void initState() {
    super.initState();
    this.commonValidationContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    String email;

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      validator: emailValidation,
      style:
          AppStyles.formTextStyle(AppColor.darkBlue, AppDimen.formTextSize),
      decoration: Decorations.formInputDecoration(
          S.of(context).email, AppColor.loginErrorColor),
      onSaved: (String value) {
        email = value.trim();
      },
    );

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: AppColor.topHead,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 5),
                  child: Text(
                    S.of(context).email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                emailField,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text(S.of(context).cancel_button),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          this._onResetPassword(email);
                          Navigator.of(context).pop(); // To close the dialog
                        }
                      },
                      child: Text(S.of(context).reset_button),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            child: Icon(
              Icons.mail_outline,
              color: Colors.white,
              size: iconSize,
            ),
            backgroundColor: Colors.blue,
            radius: avatarRadius,
          ),
        ),
      ],
    );
  }
}
