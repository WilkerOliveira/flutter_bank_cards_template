import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/utility/screen_utility.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:bank_cards/src/ui/validation/register_form_validation.dart';
import 'package:bank_cards/src/ui/widgets/dialog/alert_dialogs.dart';
import 'package:bank_cards/src/ui/widgets/header/logo_header.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with CommonFormValidation, RegisterFormValidation {
  final _formKey = GlobalKey<FormState>();
  LoginViewModel model;

  FocusNode _emailFocus;
  FocusNode _password;

  User currentUser = User();
  Size _size;

  @override
  void initState() {
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
    this._size = MediaQuery.of(context).size;
    this.model = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Container(
        color: AppColor.darkBlue,
        width: this._size.width,
        height: this._size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Header
              LogoHeader(),

              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await model.loginWithGoogle();
                    _checkLogin(model);
                  },
                  child: new Container(
                    width: ScreenUtil.instance
                        .setWidth(AppDimen.buttonAltLoginWidth),
                    height: ScreenUtil.instance
                        .setHeight(AppDimen.buttonAltLoginHeight),
                    decoration: Decorations.buttonBoxDecoration(Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.google),
                          padding: EdgeInsets.only(
                              left: ScreenUtil.instance.setWidth(1)),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await model.loginWithFacebook();
                    _checkLogin(model);
                  },
                  child: new Container(
                    width: ScreenUtil.instance
                        .setWidth(AppDimen.buttonAltLoginWidth),
                    height: ScreenUtil.instance
                        .setHeight(AppDimen.buttonAltLoginHeight),
                    decoration: Decorations.buttonBoxDecoration(
                        AppColor.facebookLoginBackground),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.facebook),
                          padding: EdgeInsets.only(
                              left: ScreenUtil.instance.setWidth(1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.sizedBoxSpace),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, Router.SIGN_UP);
              },
              child: Container(
                width:
                    ScreenUtil.instance.setWidth(AppDimen.buttonDefaultWidth),
                height:
                    ScreenUtil.instance.setHeight(AppDimen.buttonDefaultHeight),
                decoration: Decorations.transparentButtonBoxDecoration(),
                child: Center(
                  child: RichText(
                      text: new TextSpan(children: [
                    new TextSpan(
                      text: S.of(context).dont_have_account,
                      style: AppStyles.buttonTextStyle(
                        Colors.white,
                        ScreenUtil.instance.setSp(AppDimen.buttonTextSize),
                      ),
                    ),
                    new TextSpan(
                      text: S.of(context).sign_up_now,
                      style: AppStyles.buttonTextStyle(
                        AppColor.markTextColor,
                        ScreenUtil.instance.setSp(AppDimen.buttonTextSize),
                      ),
                    ),
                  ])),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.sizedBoxSpace),
            ),
          ],
        ),
    );
  }

  void _checkLogin(LoginViewModel model) {
    if (model.isError) {
      AlertDialogs.showErrorDialog(
          context, S.of(context).error_title, model.errorMessage);
    } else if (model.errorMessage != null &&
        model.errorMessage.toString().isNotEmpty) {
      AlertDialogs.showInfoDialog(
          context, S.of(context).info_title, model.errorMessage);
    } else {
      Navigator.pushNamed(context, Router.HOME, arguments: null);
    }
  }

  Widget loginForm() {
    var model = Provider.of<LoginViewModel>(context);

    TextStyle style = AppStyles.formTextStyle(AppColor.darkBlue,
        ScreenUtil.instance.setSp(AppDimen.formTextSize));

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).email, AppColor.loginErrorColor),
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
          S.of(context).password, AppColor.loginErrorColor),
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
      elevation: ScreenUtil.instance.setWidth(5.0),
      borderRadius: BorderRadius.circular(
        ScreenUtil.instance.setWidth(AppDimen.borderButton),
      ),
      color: AppColor.loginButtonBackground,
      child: MaterialButton(
        minWidth: ScreenUtil.instance.setWidth(this._size.width),
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
        padding: EdgeInsets.only(
          top: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
          left: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
          right: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).email,
                  style: AppStyles.defaultTextStyle(),
                ),
              ),
            ),
            emailField,
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.defaultMargin),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).password,
                  style: AppStyles.defaultTextStyle(),
                ),
              ),
            ),
            passwordField,
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.extraMargin),
            ),
            Selector<LoginViewModel, ViewState>(
                builder: (context, value, child) => value == ViewState.Busy
                    ? SpinKitThreeBounce(
                  color: Colors.white,
                  size: ScreenUtil.instance.setWidth(AppDimen.loadingSize),
                )
                    : loginButton,
              selector: (buildContext, model) => model.state,
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.extraMargin),
            ),
            GestureDetector(
              onTap: () {
                _forgotPassword(model);
              },
              child: new Text(
                S.of(context).forgot_password,
                textAlign: TextAlign.center,
                style: AppStyles.defaultTextStyle().copyWith(
                  decoration: TextDecoration.underline,
                  fontSize: ScreenUtil.instance.setSp(AppDimen.buttonTextSize),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.extraMargin),
            ),
          ],
        ),
      ),
    );
  }

  _forgotPassword(LoginViewModel model) {
    AlertDialogs.showResetPassword(context, (email) async {
      await model.sendPasswordResetEmail(email);

      if (model.isError) {
        AlertDialogs.showErrorDialog(
            context, S.of(context).error_title, model.errorMessage);
      } else if (model.errorMessage != null &&
          model.errorMessage.toString().isNotEmpty) {
        AlertDialogs.showInfoDialog(
            context, S.of(context).info_title, model.errorMessage);
      } else {
        AlertDialogs.showSuccessDialog(context, S.of(context).info_title,
            S.of(context).new_password_sent, () {});
      }
    });
  }

  _signIn(LoginViewModel model) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await model.signIn(currentUser);

      _checkLogin(model);
    }
  }
}
