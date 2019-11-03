import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
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
    BaseScreen.initScreenUtil(context: context);
    this.commonValidationContext = context;
    this.registerValidationContext = context;

    return Scaffold(
      body: Container(
        color: CustomColors.darkBlue,
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
    return BaseWidget<RegisterViewModel>(
      model: RegisterViewModel(),
      onModelReady: (model) async {},
      builder: (mainContext, model, child) => Container(
        color: CustomColors.darkBlue,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            registerForm(model),
            model.state == ViewState.Busy
                ? CustomCircularProgressIndicator()
                : submitButton(model),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(
                AppDimen.sizedBoxSpace,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton(RegisterViewModel model) {
    return Material(
      elevation: BaseScreen.screenUtil.setWidth(5.0),
      borderRadius: BorderRadius.circular(
        BaseScreen.screenUtil.setWidth(AppDimen.borderButton),
      ),
      color: CustomColors.loginButtonBackground,
      child: MaterialButton(
        minWidth: BaseScreen.screenUtil.setWidth(AppDimen.buttonDefaultWidth),
        padding: EdgeInsets.fromLTRB(
          BaseScreen.screenUtil.setWidth(20.0),
          BaseScreen.screenUtil.setWidth(20.0),
          BaseScreen.screenUtil.setWidth(20.0),
          BaseScreen.screenUtil.setWidth(20.0),
        ),
        onPressed: () async {
          _doRegister(model);
        },
        child: Text(
          S.of(context).btn_register,
          textAlign: TextAlign.center,
          style: formTextStyle(CustomColors.darkBlue, BaseScreen.screenUtil.setSp(AppDimen.formTextSize))
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
        formTextStyle(CustomColors.darkBlue, BaseScreen.screenUtil.setSp(AppDimen.formTextSize));

    final nameField = TextFormField(
      obscureText: false,
      maxLength: 50,
      style: style,
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).name, CustomColors.loginErrorColor),
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
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).nick_name, CustomColors.loginErrorColor),
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
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).email, CustomColors.loginErrorColor),
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
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).password, CustomColors.loginErrorColor),
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
      decoration: Decorations.formInputDecoration(BaseScreen.screenUtil,
          S.of(context).confirm_password, CustomColors.loginErrorColor),
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
        padding: EdgeInsets.only(top: BaseScreen.screenUtil.setWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: BaseScreen.screenUtil.setWidth(10), left: BaseScreen.screenUtil.setWidth(5)),
              child: Text(
                S.of(context).name,
                style: TextStyle(
                  fontSize: BaseScreen.screenUtil.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: nameField,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(bottom: BaseScreen.screenUtil.setWidth(10), left:
    BaseScreen.screenUtil.setWidth(5),),
              child: Text(
                S.of(context).nick_name,
                style: TextStyle(
                  fontSize: BaseScreen.screenUtil.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: nickName,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(bottom: BaseScreen.screenUtil.setWidth(10), left: BaseScreen.screenUtil.setWidth(5),),
              child: Text(
                S.of(context).email,
                style: TextStyle(
                  fontSize: BaseScreen.screenUtil.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: emailField,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(bottom: BaseScreen.screenUtil.setWidth(10), left: BaseScreen.screenUtil.setWidth(5),),
              child: Text(
                S.of(context).password,
                style: TextStyle(
                  fontSize: BaseScreen.screenUtil.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: passwordField,
            ),
            SizedBox(height: BaseScreen.screenUtil.setHeight(5.0)),
            Padding(
              padding: EdgeInsets.only(bottom: BaseScreen.screenUtil.setWidth(10), left: BaseScreen.screenUtil.setWidth(5),),
              child: Text(
                S.of(context).confirm_password,
                style: TextStyle(
                  fontSize: BaseScreen.screenUtil.setSp(16),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: BaseScreen.screenUtil.setWidth(AppDimen.formFieldWidth),
              child: confirmPassword,
            ),
            SizedBox(
              height: BaseScreen.screenUtil.setHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}
