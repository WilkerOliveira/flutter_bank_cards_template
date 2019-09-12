import 'package:get_it/get_it.dart';
import 'package:bank_cards/src/repository/local/database/bank_cards_db.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => BankCardsDatabase());
}
