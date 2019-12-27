/*

This class was based on the Flutter Provider v3 Architecture using ProxyProvider for Injection

https://medium.com/flutter-community/flutter-provider-v3-architecture-using-proxyprovider-for-injection-62cf5c58ea52

 */

import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/card/card_repository.dart';
import 'package:bank_cards/src/repository/card/invoice_card_repository.dart';
import 'package:bank_cards/src/repository/card/service/card/card_service.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_service.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_service.dart';
import 'package:bank_cards/src/repository/card/statement_card_repository.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: CardService()),
  Provider.value(value: StatementCardService()),
  Provider.value(value: InvoiceService()),
  Provider.value(value: LoginRepository()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<CardService, CardRepository>(
    update: (context, service, repository) => CardRepository(service: service),
  ),
  ProxyProvider<StatementCardService, StatementCardRepository>(
    update: (context, service, repository) =>
        StatementCardRepository(service: service),
  ),
  ProxyProvider<InvoiceService, InvoiceCardRepository>(
    update: (context, service, repository) =>
        InvoiceCardRepository(service: service),
  )
];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) =>
        Provider.of<LoginRepository>(context, listen: false).currentUser,
  ),
];
