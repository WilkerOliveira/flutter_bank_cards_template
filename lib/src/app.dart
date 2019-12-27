import 'package:bank_cards/provider_setup.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/router.dart' ;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: providers,
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
