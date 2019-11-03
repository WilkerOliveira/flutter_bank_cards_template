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
      height: BaseScreen.screenUtil.setHeight(AppDimen.loginHeaderHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: BaseScreen.screenUtil.setWidth(50.0),
            ),
            child: SvgPicture.asset(
              AppImages.logo,
              width: BaseScreen.screenUtil.setWidth(100),
              height: BaseScreen.screenUtil.setHeight(100),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: BaseScreen.screenUtil.setWidth(25),
              bottom: BaseScreen.screenUtil.setWidth(15),
            ),
            child: Text(
              S.of(context).app_name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: BaseScreen.screenUtil.setSp(26),
              ),
            ),
          )
        ],
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
        padding: EdgeInsets.fromLTRB(
          BaseScreen.screenUtil.setWidth(20.0),
          BaseScreen.screenUtil.setWidth(15.0),
          BaseScreen.screenUtil.setWidth(20.0),
          BaseScreen.screenUtil.setWidth(15.0),
        ),
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
        padding: EdgeInsets.only(top: BaseScreen.screenUtil.setWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: BaseScreen.screenUtil.setWidth(10),
                  left: BaseScreen.screenUtil.setWidth(32)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).email,
                  style: TextStyle(
                    fontSize: BaseScreen.screenUtil.setSp(16),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: emailField,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(10.0)),
            Padding(
              padding: EdgeInsets.only(
                  bottom: BaseScreen.screenUtil.setWidth(10),
                  left: BaseScreen.screenUtil.setWidth(32)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).password,
                  style: TextStyle(
                    fontSize: BaseScreen.screenUtil.setSp(16),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: passwordField,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(25.0)),
            model.state == ViewState.Busy
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: BaseScreen.screenUtil.setWidth(20),
                  )
                : loginButton,
            SizedBox(height: BaseScreen.screenUtil.setHeight(25.0)),
            GestureDetector(
              onTap: () {
                _forgotPassword(model);
              },
              child: new Text(
                S.of(context).forgot_password,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize:
                      BaseScreen.screenUtil.setSp(AppDimen.buttonTextSize),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(35.0),
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
