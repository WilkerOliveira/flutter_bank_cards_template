import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/utility/screen_utility.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:bank_cards/src/ui/validation/register_form_validation.dart';
import 'package:bank_cards/src/ui/widgets/dialog/alert_dialogs.dart';
import 'package:bank_cards/src/ui/widgets/header/logo_header.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    BaseScreen.initScreenUtil(context: context);

    return Scaffold(
      body: Container(
        color: CustomColors.darkBlue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(Provider.of(context)),
      onModelReady: (model) async {},
      builder: (mainContext, model, child) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loginForm(model),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await model.loginWithGoogle();
                    _checkLogin(model);
                  },
                  child: new Container(
                    width: BaseScreen.screenUtil
                        .setWidth(AppDimen.buttonAltLoginWidth),
                    height: BaseScreen.screenUtil
                        .setHeight(AppDimen.buttonAltLoginHeight),
                    decoration: Decorations.buttonBoxDecoration(Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.google),
                          padding: EdgeInsets.only(
                              left: BaseScreen.screenUtil.setWidth(1)),
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
                    width: BaseScreen.screenUtil
                        .setWidth(AppDimen.buttonAltLoginWidth),
                    height: BaseScreen.screenUtil
                        .setHeight(AppDimen.buttonAltLoginHeight),
                    decoration: Decorations.buttonBoxDecoration(
                        CustomColors.facebookLoginBackground),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(AppImages.facebook),
                          padding: EdgeInsets.only(
                              left: BaseScreen.screenUtil.setWidth(1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.sizedBoxSpace),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, Router.SIGN_UP);
              },
              child: Container(
                width:
                    BaseScreen.screenUtil.setWidth(AppDimen.buttonDefaultWidth),
                height: BaseScreen.screenUtil
                    .setHeight(AppDimen.buttonDefaultHeight),
                decoration: Decorations.transparentButtonBoxDecoration(),
                child: Center(
                  child: RichText(
                      text: new TextSpan(children: [
                    new TextSpan(
                      text: S.of(context).dont_have_account,
                      style: buttonTextStyle(
                        Colors.white,
                        BaseScreen.screenUtil.setSp(AppDimen.buttonTextSize),
                      ),
                    ),
                    new TextSpan(
                      text: S.of(context).sign_up_now,
                      style: buttonTextStyle(
                        CustomColors.markTextColor,
                        BaseScreen.screenUtil.setSp(AppDimen.buttonTextSize),
                      ),
                    ),
                  ])),
                ),
              ),
            ),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.sizedBoxSpace),
            ),
          ],
        ),
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

  Widget loginForm(LoginViewModel model) {
    TextStyle style = formTextStyle(CustomColors.darkBlue,
        BaseScreen.screenUtil.setSp(AppDimen.formTextSize));

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 100,
      obscureText: false,
      style: style,
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).email, CustomColors.loginErrorColor),
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
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).password, CustomColors.loginErrorColor),
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
      elevation: BaseScreen.screenUtil.setWidth(5.0),
      borderRadius: BorderRadius.circular(
        BaseScreen.screenUtil.setWidth(AppDimen.borderButton),
      ),
      color: CustomColors.loginButtonBackground,
      child: MaterialButton(
        minWidth: BaseScreen.screenUtil.setWidth(AppDimen.buttonDefaultWidth),
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
          top: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
          left: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
          right: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).email,
                  style: defaultTextStyle(BaseScreen.screenUtil),
                ),
              ),
            ),
            emailField,
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.defaultMargin),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).password,
                  style: defaultTextStyle(BaseScreen.screenUtil),
                ),
              ),
            ),
            passwordField,
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.extraMargin),
            ),
            model.state == ViewState.Busy
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: BaseScreen.screenUtil.setWidth(AppDimen.loadingSize),
                  )
                : loginButton,
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.extraMargin),
            ),
            GestureDetector(
              onTap: () {
                _forgotPassword(model);
              },
              child: new Text(
                S.of(context).forgot_password,
                textAlign: TextAlign.center,
                style: defaultTextStyle(BaseScreen.screenUtil).copyWith(
                  decoration: TextDecoration.underline,
                  fontSize:
                      BaseScreen.screenUtil.setSp(AppDimen.buttonTextSize),
                ),
              ),
            ),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(AppDimen.extraMargin),
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
