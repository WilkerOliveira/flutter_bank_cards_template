import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/utility/screen_utility.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:bank_cards/src/ui/validation/register_form_validation.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/ui/widgets/dialog/alert_dialogs.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with CommonFormValidation, RegisterFormValidation {
  final _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  User newUser = User();

  FocusNode _nameFocus;
  FocusNode _nicknameFocus;
  FocusNode _emailFocus;
  FocusNode _password;
  FocusNode _confPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameFocus = FocusNode();
    _nicknameFocus = FocusNode();
    _emailFocus = FocusNode();
    _password = FocusNode();
    _confPassword = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _nameFocus.dispose();
    _nicknameFocus.dispose();
    _emailFocus.dispose();
    _password.dispose();
    _confPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.commonValidationContext = context;
    this.registerValidationContext = context;

    return Scaffold(
      body: Container(
        color: CustomColors.DARK_BLUE,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomAppBar(appBarType: AppBarType.silverAppBar , title: S.of(context).app_name).build(context),
            ];
          },
          body: SingleChildScrollView(child: _body()),
        ),
      ),
    );
  }

  Widget _body() {
    return BaseWidget<RegisterViewModel>(
      model: RegisterViewModel(),
      onModelReady: (model) async {},
      builder: (mainContext, model, child) => Container(
        color: CustomColors.DARK_BLUE,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            registerForm(model),
            model.state == ViewState.Busy
                ? CustomCircularProgressIndicator()
                : submitButton(model),
            SizedBox(
              height: Dimens.sized_box_space,
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton(RegisterViewModel model) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(Dimens.border_button),
      color: CustomColors.login_button_background,
      child: MaterialButton(
        minWidth: Dimens.button_default_width,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        onPressed: () async {
          _doRegister(model);
        },
        child: Text(
          S.of(context).btn_register,
          textAlign: TextAlign.center,
          style: formTextStyle(CustomColors.DARK_BLUE, Dimens.form_text_size)
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _doRegister(RegisterViewModel model) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await model.registerNewUser(newUser);

      if (model.isError) {
        AlertDialogs.showErrorDialog(
            context, S.of(context).error_title, model.errorMessage);
      } else if (model.errorMessage != null &&
          model.errorMessage.toString().isNotEmpty) {
        AlertDialogs.showInfoDialog(
            context, S.of(context).info_title, model.errorMessage);
      } else {
        AlertDialogs.showSuccessDialog(context, S.of(context).success_title,
            S.of(context).saved_successfully, () => Navigator.pop(context));
      }
    }
  }

  Widget registerForm(RegisterViewModel model) {
    TextStyle style =
        formTextStyle(CustomColors.DARK_BLUE, Dimens.form_text_size);

    final nameField = TextFormField(
      obscureText: false,
      maxLength: 50,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).name, CustomColors.login_error_color),
      onSaved: (String value) {
        newUser.firstName = value.trim();
      },
      validator: requiredField,
      textInputAction: TextInputAction.next,
      focusNode: _nameFocus,
      onFieldSubmitted: (term) {
        ScreenUtility.fieldFocusChange(context, _nameFocus, _nicknameFocus);
      },
    );

    final nickName = TextFormField(
      obscureText: false,
      maxLength: 20,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).nick_name, CustomColors.login_error_color),
      onSaved: (String value) {
        newUser.nickName = value.trim();
      },
      validator: requiredField,
      textInputAction: TextInputAction.next,
      focusNode: _nicknameFocus,
      onFieldSubmitted: (term) {
        ScreenUtility.fieldFocusChange(context, _nicknameFocus, _emailFocus);
      },
    );

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).email, CustomColors.login_error_color),
      onSaved: (String value) {
        newUser.email = value.trim();
      },
      validator: emailValidation,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        ScreenUtility.fieldFocusChange(context, _emailFocus, _password);
      },
    );

    final passwordField = TextFormField(
      key: passKey,
      obscureText: true,
      maxLength: 8,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).password, CustomColors.login_error_color),
      onSaved: (String value) {
        newUser.password = value.trim();
      },
      validator: passwordValidation,
      textInputAction: TextInputAction.next,
      focusNode: _password,
      onFieldSubmitted: (term) {
        ScreenUtility.fieldFocusChange(context, _password, _confPassword);
      },
    );

    final confirmPassword = TextFormField(
      obscureText: true,
      maxLength: 8,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).confirm_password, CustomColors.login_error_color),
      onSaved: (String value) {
        newUser.confirmPassword = value.trim();
      },
      validator: (confirmation) {
        String password = passKey.currentState.value;
        return confirmation.trim() == password.trim()
            ? null
            : S.of(context).password_not_match;
      },
      textInputAction: TextInputAction.done,
      focusNode: _confPassword,
      onFieldSubmitted: (term) {
        _doRegister(model);
      },
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5),
              child: Text(
                S.of(context).name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.form_field_width,
              child: nameField,
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5),
              child: Text(
                S.of(context).nick_name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.form_field_width,
              child: nickName,
            ),
            SizedBox(height: 5.0),
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
            SizedBox(
              width: Dimens.form_field_width,
              child: emailField,
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5),
              child: Text(
                S.of(context).password,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.form_field_width,
              child: passwordField,
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5),
              child: Text(
                S.of(context).confirm_password,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.form_field_width,
              child: confirmPassword,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
