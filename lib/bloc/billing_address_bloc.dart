import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cep_future/cep_future.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:equatable/equatable.dart';

part 'billing_address_event.dart';

part 'billing_address_state.dart';

class BillingAddressBloc
    extends Bloc<BillingAddressEvent, BillingAddressState> {
  BillingAddressBloc() : super(BillingAddressInitial());

  @override
  Stream<BillingAddressState> mapEventToState(
    BillingAddressEvent event,
  ) async* {
    if (event is VerifyCEP) {
      yield* _mapVerifyCEPToState(event.cep);
    }
  }

  Stream<BillingAddressState> _mapVerifyCEPToState(String cep) async* {
    yield BillingAddressLoading();
    try {
      final result = await cepFuture(cep);
      // var result = await CEP.searchCEP(cep.trim(), 'json', '');
      if (result != null) {
        BillingAddress billingAddress = BillingAddress(
            address: result.street,
            cep: result.cep,
            state: result.state,
            city: result.city,
            complement: '',
            neighborhood: result.neighborhood,
            country: 'Brasil');
        yield BillingAddressDone(billingAddress);
      } else {
        yield BillingAddressError(errorMessage: 'CEP não encontrado :c');
      }
    } catch (e) {
      yield BillingAddressError(
          errorMessage: 'Ops, ocorreu um erro, tente novamente mais tarde');
    }
  }
}
