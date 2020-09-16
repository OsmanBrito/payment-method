part of 'credit_card_payment_bloc.dart';

@immutable
abstract class CreditCardPaymentState {}

class CreditCardPaymentInitial extends CreditCardPaymentState {}

class CreditCardPaymentLoading extends CreditCardPaymentState {}

class CreditCardPaymentDone extends CreditCardPaymentState {
  final List<CreditCardPayment> cardPayment;

  CreditCardPaymentDone(this.cardPayment);

  @override
  String toString() => 'CreditCardPaymentDone: {$cardPayment}';
}

class CreditCardPaymentError extends CreditCardPaymentState {
  CreditCardPaymentError({this.errorMessage = ''});

  final String errorMessage;

  @override
  String toString() =>
      'CreditCardPaymentError: { errorMessage: $errorMessage }';
}
