import 'package:get_it/get_it.dart';
import 'package:simple/services/accounts_service.dart';
import 'package:simple/services/transactions_service.dart';

final GetIt locator = GetIt.instance;
void setUp() {
  locator
      .registerLazySingleton<TransactionsService>(() => TransactionsService());
  locator.registerLazySingleton<AccountService>(() => AccountService());
}
