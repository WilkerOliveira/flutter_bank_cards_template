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
  
  String get welcome {
    return Intl.message("\nOlá, nós somos o Tribanco Digital, seu banco digital.\n", name: 'welcome');
  }

  String get explanation {
    return Intl.message("Vamos começar?\nPara acessar ou se é sua primeira vez insira seu CPF/CNPJ abaixo:", name: 'explanation');
  }

  String get CPF_CNPJ {
    return Intl.message("CPF ou CNPJ", name: 'CPF_CNPJ');
  }

  String get cpf_required {
    return Intl.message("Informe o CPF/CNPJ", name: 'cpf_required');
  }

  String get btn_continue {
    return Intl.message("CONTINUAR", name: 'btn_continue');
  }

  String get triconta {
    return Intl.message("Triconta", name: 'triconta');
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

  String get app_name {
    return Intl.message("Triconta", name: 'app_name');
  }

  String get cvv {
    return Intl.message("CVV", name: 'cvv');
  }

  String get password {
    return Intl.message("Senha", name: 'password');
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
