import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/utility/screen_utility.dart';
import 'package:bank_cards/src/ui/validation/common_form_validation.dart';
import 'package:bank_cards/src/ui/validation/register_form_validation.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/ui/widgets/dialog/alert_dialogs.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with CommonFormValidation, RegisterFormValidation {
  final _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  User newUser = User();
  final RegisterViewModel model = RegisterViewModel();

  FocusNode _nameFocus;
  FocusNode _nicknameFocus;
  FocusNode _emailFocus;
  FocusNode _password;
  FocusNode _confPassword;

  Size _size;

  @override
  void initState() {
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
    this._size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: AppColor.darkBlue,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomAppBar(
                      appBarType: AppBarType.silverAppBar,
                      title: S.of(context).app_name)
                  .build(context),
            ];
          },
          body: SingleChildScrollView(child: _body()),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
        right: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
      ),
      color: AppColor.darkBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          registerForm(),
          StreamProvider<ViewState>.value(
            updateShouldNotify: (p, n) => true,
            value: model.viewStateStream,
            initialData: ViewState.Idle,
            child: Consumer<ViewState>(
              builder: (context, viewState, widget) =>
                  viewState == ViewState.Busy
                      ? CustomCircularProgressIndicator()
                      : submitButton(),
            ),
          ),
          SizedBox(
            height: ScreenUtil.instance.setHeight(
              AppDimen.sizedBoxSpace,
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Material(
      elevation: ScreenUtil.instance.setWidth(5.0),
      borderRadius: BorderRadius.circular(
        ScreenUtil.instance.setWidth(AppDimen.borderButton),
      ),
      color: AppColor.loginButtonBackground,
      child: MaterialButton(
        minWidth: ScreenUtil.instance.setWidth(this._size.width),
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.instance.setWidth(0.0),
          ScreenUtil.instance.setWidth(20.0),
          ScreenUtil.instance.setWidth(0.0),
          ScreenUtil.instance.setWidth(20.0),
        ),
        onPressed: () async {
          _doRegister();
        },
        child: Text(
          S.of(context).btn_register,
          textAlign: TextAlign.center,
          style: AppStyles.formTextStyle(AppColor.darkBlue,
                  ScreenUtil.instance.setSp(AppDimen.formTextSize))
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _doRegister() async {
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

  Widget registerForm() {
    TextStyle style = AppStyles.formTextStyle(
        AppColor.darkBlue, ScreenUtil.instance.setSp(AppDimen.formTextSize));

    final nameField = TextFormField(
      obscureText: false,
      maxLength: 50,
      style: style,
      decoration: Decorations.formInputDecoration(
          S.of(context).name, AppColor.loginErrorColor),
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
          S.of(context).nick_name, AppColor.loginErrorColor),
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
          S.of(context).email, AppColor.loginErrorColor),
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
          S.of(context).password, AppColor.loginErrorColor),
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
          S.of(context).confirm_password, AppColor.loginErrorColor),
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
        _doRegister();
      },
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil.instance.setWidth(10),
                  left: ScreenUtil.instance.setWidth(5)),
              child: Text(
                S.of(context).name,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: nameField,
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(10),
                left: ScreenUtil.instance.setWidth(5),
              ),
              child: Text(
                S.of(context).nick_name,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: nickName,
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(10),
                left: ScreenUtil.instance.setWidth(5),
              ),
              child: Text(
                S.of(context).email,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: emailField,
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(10),
                left: ScreenUtil.instance.setWidth(5),
              ),
              child: Text(
                S.of(context).password,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: passwordField,
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil.instance.setWidth(10),
                left: ScreenUtil.instance.setWidth(5),
              ),
              child: Text(
                S.of(context).confirm_password,
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: confirmPassword,
            ),
            SizedBox(
              height: ScreenUtil.instance.setHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}
