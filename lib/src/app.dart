import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/card/card_repository.dart';
import 'package:bank_cards/src/repository/card/invoice_card_repository.dart';
import 'package:bank_cards/src/repository/card/service/card/card_service.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_service.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_service.dart';
import 'package:bank_cards/src/repository/card/statement_card_repository.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/screens/splash_screen.dart';
import 'package:bank_cards/src/viewmodel/card/card_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider.value(value: CardService()),
        Provider.value(value: StatementCardService()),
        Provider.value(value: InvoiceService()),
        Provider.value(value: LoginRepository()),
        ProxyProvider<CardService, CardRepository>(
          update: (context, service, repository) =>
              CardRepository(service: service),
        ),
        ProxyProvider<StatementCardService, StatementCardRepository>(
          update: (context, service, repository) =>
              StatementCardRepository(service: service),
        ),
        ProxyProvider<InvoiceService, InvoiceCardRepository>(
          update: (context, service, repository) =>
              InvoiceCardRepository(service: service),
        ),
        StreamProvider<User>(
          create: (context) =>
              Provider.of<LoginRepository>(context, listen: false).currentUser,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              LoginViewModel(Provider.of(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CardViewModel(repository: Provider.of(context, listen: false)),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: "Bank Cards",
        theme: AppStyles.defaultThemeData(),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: SplashScreen(),
        initialRoute: Router.SPLASH,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
