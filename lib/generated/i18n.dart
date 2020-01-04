// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get btn_continue {
    return Intl.message("CONTINUAR", name: 'btn_continue');
  }

  String get cpf_not_found {
    return Intl.message("CPF não encontrado!", name: 'cpf_not_found');
  }

  String get login_success {
    return Intl.message("Login realizado com sucesso!", name: 'login_success');
  }

  String get login_failed {
    return Intl.message("Login não realizado!", name: 'login_failed');
  }

  String get help {
    return Intl.message("Ajuda", name: 'help');
  }

  String get close_button {
    return Intl.message("Fechar", name: 'close_button');
  }

  String get current_balance {
    return Intl.message("Saldo Atual", name: 'current_balance');
  }

  String get statement {
    return Intl.message("Extrato", name: 'statement');
  }

  String get payments {
    return Intl.message("Pagamentos", name: 'payments');
  }

  String get invoices {
    return Intl.message("Faturas", name: 'invoices');
  }

  String get more {
    return Intl.message("Mais", name: 'more');
  }

  String get app_name {
    return Intl.message("Mobile Bank", name: 'app_name');
  }

  String get cvv {
    return Intl.message("CVV", name: 'cvv');
  }

  String get password {
    return Intl.message("Senha", name: 'password');
  }

  String get due_date {
    return Intl.message("Vencimento", name: 'due_date');
  }

  String get limit {
    return Intl.message("Limite", name: 'limit');
  }

  String get available {
    return Intl.message("Disponível", name: 'available');
  }

  String get investments {
    return Intl.message("Investimentos", name: 'investments');
  }

  String get login_with_google {
    return Intl.message("Google", name: 'login_with_google');
  }

  String get login_with_facebook {
    return Intl.message("Facebook", name: 'login_with_facebook');
  }

  String get dont_have_account {
    return Intl.message("Não tem conta?", name: 'dont_have_account');
  }

  String get sign_up_now {
    return Intl.message(" Cadastra-se agora!", name: 'sign_up_now');
  }

  String get email {
    return Intl.message("E-mail", name: 'email');
  }

  String get confirm_password {
    return Intl.message("Confirmar Senha", name: 'confirm_password');
  }

  String get btn_login {
    return Intl.message("ENTRAR", name: 'btn_login');
  }

  String get forgot_password {
    return Intl.message("Esqueceu a senha?", name: 'forgot_password');
  }

  String get name {
    return Intl.message("Nome", name: 'name');
  }

  String get nick_name {
    return Intl.message("Apelido", name: 'nick_name');
  }

  String get register_with_google {
    return Intl.message("Registrar com o Google", name: 'register_with_google');
  }

  String get register_with_facebook {
    return Intl.message("Registrar com Facebook", name: 'register_with_facebook');
  }

  String get btn_register {
    return Intl.message("Registrar", name: 'btn_register');
  }

  String get required_field {
    return Intl.message("Campo obrigatório", name: 'required_field');
  }

  String get invalid_email {
    return Intl.message("E-mail inválido", name: 'invalid_email');
  }

  String get invalid_password_format {
    return Intl.message("Deve conter pelo menos 6 caracteres.", name: 'invalid_password_format');
  }

  String get error_title {
    return Intl.message("Erro", name: 'error_title');
  }

  String get user_email_already_exist {
    return Intl.message("Já existe um usuário com este e-mail!", name: 'user_email_already_exist');
  }

  String get user_nickname_already_exist {
    return Intl.message("Já existe um usuário com este apelido!", name: 'user_nickname_already_exist');
  }

  String get password_not_match {
    return Intl.message("Senhas não conferem!", name: 'password_not_match');
  }

  String get no_internet_connection {
    return Intl.message("Sem conexão com a Internet!", name: 'no_internet_connection');
  }

  String get info_title {
    return Intl.message("Informação", name: 'info_title');
  }

  String get success_title {
    return Intl.message("Sucesso", name: 'success_title');
  }

  String get saved_successfully {
    return Intl.message("Salvo com sucesso", name: 'saved_successfully');
  }

  String get invalid_email_or_password {
    return Intl.message("E-mail ou senha inválidos!", name: 'invalid_email_or_password');
  }

  String get reset_button {
    return Intl.message("ENVIAR SENHA", name: 'reset_button');
  }

  String get default_error {
    return Intl.message("Desculpe, algo deu errado!", name: 'default_error');
  }

  String get user_not_registered {
    return Intl.message("Usuário não cadastrado! Registre-se primeiro.", name: 'user_not_registered');
  }

  String get login_cancelled_by_user {
    return Intl.message("Login cancelado pelo usuário!", name: 'login_cancelled_by_user');
  }

  String get login_title {
    return Intl.message("Login", name: 'login_title');
  }

  String get cards {
    return Intl.message("Cartões", name: 'cards');
  }

  String get account {
    return Intl.message("Conta", name: 'account');
  }

  String get user {
    return Intl.message("Usuário", name: 'user');
  }

  String get logout {
    return Intl.message("Sair", name: 'logout');
  }

  String get userRegisteredWithDiffCredential {
    return Intl.message("Você já está registrado com uma credencial diferente!", name: 'userRegisteredWithDiffCredential');
  }

  String get cancel_button {
    return Intl.message("CANCELAR", name: 'cancel_button');
  }

  String get new_password_sent {
    return Intl.message("Uma nova senha foi enviado para seu e-mail!", name: 'new_password_sent');
  }

  String get emailNotFound {
    return Intl.message("E-mail não encontrado!", name: 'emailNotFound');
  }

  String get my_cards_title {
    return Intl.message("Meus Cartões", name: 'my_cards_title');
  }

  String get valid_thru {
    return Intl.message("VÁLIDO ATÉ", name: 'valid_thru');
  }

  String get statement_date {
    return Intl.message("Data do Extrato:", name: 'statement_date');
  }

  String get bank {
    return Intl.message("Banco", name: 'bank');
  }

  String get agency {
    return Intl.message("Agência", name: 'agency');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("pt", "BR"),
			Locale("en", "US"),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}
