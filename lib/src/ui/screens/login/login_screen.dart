import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/utility/screen_utility.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:bank_cards/src/ui/validation/register_form_validation.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/ui/widgets/dialog/alert_dialogs.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with CommonFormValidation, RegisterFormValidation {
  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFocus;
  FocusNode _password;

  User currentUser = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailFocus = FocusNode();
    _password = FocusNode();

    this.commonValidationContext = context;
    this.registerValidationContext = context;
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocus.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.DARK_BLUE,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Header
              _header(),

              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: Decorations.headerDecoration(),
      width: MediaQuery.of(context).size.width,
      height: Dimens.login_header_height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: SvgPicture.asset(
              AppImages.LOGO,
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 15),
            child: Text(
              S.of(context).app_name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26),
            ),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(),
      onModelReady: (model) async {},
      builder: (mainContext, model, child) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loginForm(model),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    _checkLogin(model, await model.loginWithGoogle());
                  },
                  child: new Container(
                    width: Dimens.button_alt_login_width,
                    height: Dimens.button_alt_login_height,
                    decoration: Decorations.buttonBoxDecoration(Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.GOOGLE),
                          padding: EdgeInsets.only(left: 1),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    _checkLogin(model, await model.loginWithFacebook());
                  },
                  child: new Container(
                    width: Dimens.button_alt_login_width,
                    height: Dimens.button_alt_login_height,
                    decoration: Decorations.buttonBoxDecoration(
                        CustomColors.facebook_login_background),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.FACEBOOK),
                          padding: EdgeInsets.only(left: 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimens.sized_box_space,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, Router.SIGN_UP);
              },
              child: Container(
                width: Dimens.button_default_width,
                height: Dimens.button_default_height,
                decoration: Decorations.transparentButtonBoxDecoration(),
                child: Center(
                  child: RichText(
                      text: new TextSpan(children: [
                    new TextSpan(
                      text: S.of(context).dont_have_account,
                      style: buttonTextStyle(
                          Colors.white, Dimens.button_text_size),
                    ),
                    new TextSpan(
                      text: S.of(context).sign_up_now,
                      style: buttonTextStyle(CustomColors.mark_text_color,
                          Dimens.button_text_size),
                    ),
                  ])),
                ),
              ),
            ),
            SizedBox(
              height: Dimens.sized_box_space,
            ),
          ],
        ),
      ),
    );
  }

  void _checkLogin(LoginViewModel model, User user) {
    if (model.isError) {
      AlertDialogs.showErrorDialog(
          context, S.of(context).login_title, model.errorMessage);
    }
  }

  Widget loginForm(LoginViewModel model) {
    TextStyle style =
        formTextStyle(CustomColors.DARK_BLUE, Dimens.form_text_size);

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).email, CustomColors.login_error_color),
      onSaved: (String value) {
        currentUser.email = value.trim();
      },
      validator: emailValidation,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        ScreenUtility.fieldFocusChange(context, _emailFocus, _password);
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      maxLength: 8,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).password, CustomColors.login_error_color),
      onSaved: (String value) {
        currentUser.password = value.trim();
      },
      validator: passwordValidation,
      textInputAction: TextInputAction.done,
      focusNode: _password,
      onFieldSubmitted: (term) {
        _signIn(model);
      },
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(Dimens.border_button),
      color: CustomColors.login_button_background,
      child: MaterialButton(
        minWidth: Dimens.button_default_width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _signIn(model);
        },
        child: Text(
          S.of(context).btn_login,
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: Dimens.form_field_width,
              child: emailField,
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: Dimens.form_field_width,
              child: passwordField,
            ),
            SizedBox(height: 25.0),
            model.state == ViewState.Busy
                ? CustomCircularProgressIndicator()
                : loginButton,
            SizedBox(height: 25.0),
            GestureDetector(
              onTap: () {
                _forgotPassword();
              },
              child: new Text(
                S.of(context).forgot_password,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: Dimens.button_text_size,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.15000000596046448,
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
          ],
        ),
      ),
    );
  }

  _forgotPassword() {
    AlertDialogs.showResetPassword(context, () {});
  }

  _signIn(LoginViewModel model) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      User user = await model.signIn(currentUser);

      if (model.isError) {
        AlertDialogs.showErrorDialog(
            context, S.of(context).error_title, model.errorMessage);
      } else if (model.errorMessage != null &&
          model.errorMessage.toString().isNotEmpty) {
        AlertDialogs.showInfoDialog(
            context, S.of(context).info_title, model.errorMessage);
      } else {
        AlertDialogs.showSuccessDialog(
            context, S.of(context).success_title, user.nickName, () {});
      }
    }
  }
}
