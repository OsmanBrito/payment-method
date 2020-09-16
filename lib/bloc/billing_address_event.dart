part of 'billing_address_bloc.dart';

abstract class BillingAddressEvent extends Equatable {
  const BillingAddressEvent();
}

class VerifyCEP extends BillingAddressEvent {
  VerifyCEP(this.cep);

  final String cep;

  @override
  List<Object> get props => [];
}
