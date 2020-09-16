part of 'billing_address_bloc.dart';

abstract class BillingAddressState extends Equatable {
  const BillingAddressState();
}

class BillingAddressInitial extends BillingAddressState {
  @override
  List<Object> get props => [];
}

class BillingAddressLoading extends BillingAddressState {
  @override
  List<Object> get props => [];
}

class BillingAddressDone extends BillingAddressState {
  final BillingAddress billingAddress;

  BillingAddressDone(this.billingAddress);

  @override
  String toString() => 'BillingAddressDone: {$BillingAddressDone}';

  @override
  List<Object> get props => [];
}

class BillingAddressError extends BillingAddressState {
  BillingAddressError({this.errorMessage = ''});

  final String errorMessage;

  @override
  String toString() => 'BillingAddressError: { errorMessage: $errorMessage }';

  @override
  List<Object> get props => [];
}
