import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatelessWidget {
  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
  static const double iconSize = 32.0;

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
    String _email;

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      style: formTextStyle(
          CustomColors.DARK_BLUE, Dimens.form_text_size),
      decoration: Decorations.formInputDecoration(
          S.of(context).email, CustomColors.login_error_color),
      onSaved: (String value) {
        _email = value.trim();
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
            color: CustomColors.TOP_HEAD,
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
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(S.of(context).reset_button),
                ),
              ),
            ],
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
