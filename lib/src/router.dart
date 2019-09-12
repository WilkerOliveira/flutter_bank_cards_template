import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bank_cards/src/ui/screens/card/invoice/closed_invoice_card_screen.dart';
import 'package:bank_cards/src/ui/screens/card/invoice/invoice_card_screen.dart';
import 'package:bank_cards/src/ui/screens/card/statement/statement_card_screen.dart';
import 'package:bank_cards/src/ui/screens/home/home_page.dart';

class Router {
  static const String initialRoute = HOME;
  static const String HOME = "home";
  static const CARD_STATEMENT = "card_statement";
  static const CARD_CLOSED_INVOICE = "card_closed_invoice";
  static const CARD_MONTHLY_CLOSED_INVOICE = "card_monthly_closed_invoice";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
      case CARD_STATEMENT:
        return MaterialPageRoute(
            builder: (_) => StatementCardScreen(settings.arguments));
      case CARD_CLOSED_INVOICE:
        return MaterialPageRoute(
            builder: (_) => ClosedInvoiceCardScreen(settings.arguments));
      case CARD_MONTHLY_CLOSED_INVOICE:
        return MaterialPageRoute(
            builder: (_) => InvoiceCardScreen(settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
