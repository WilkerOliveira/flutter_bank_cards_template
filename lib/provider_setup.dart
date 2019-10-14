import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/repository/card/invoice_card_repository.dart';
import 'package:bank_cards/src/repository/card/card_repository.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_service.dart';
import 'package:bank_cards/src/repository/card/service/card/card_service.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_service.dart';
import 'package:bank_cards/src/repository/card/statement_card_repository.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: CardService()),
  Provider.value(value: StatementCardService()),
  Provider.value(value: InvoiceService()),
  Provider.value(value: LoginRepository()),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<CardService, CardRepository>(
    builder: (context, service, repository) => CardRepository(service: service),
  ),
  ProxyProvider<StatementCardService, StatementCardRepository>(
    builder: (context, service, repository) =>
        StatementCardRepository(service: service),
  ),
  ProxyProvider<InvoiceService, InvoiceCardRepository>(
    builder: (context, service, repository) =>
        InvoiceCardRepository(service: service),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) =>
    Provider.of<LoginRepository>(context, listen: false).currentUser,
  ),
];
