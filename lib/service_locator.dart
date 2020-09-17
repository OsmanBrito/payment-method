import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<CreditCardPaymentBloc>(() => CreditCardPaymentBloc());
  // sl.registerLazySingleton<BillingAddressBloc>(() => BillingAddressBloc());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}