import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/model/payment_method.dart';
import 'package:credit_card/screen/credit_card/payment_methods_screen.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/strings.dart';
import 'package:credit_card/util/alert_dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'credit_card_payment_event.dart';

part 'credit_card_payment_state.dart';

class CreditCardPaymentBloc
    extends Bloc<CreditCardPaymentEvent, CreditCardPaymentState> {
  CreditCardPaymentBloc() : super(CreditCardPaymentInitial());

  @override
  CreditCardPaymentState get initialState => CreditCardPaymentInitial();

  @override
  Stream<CreditCardPaymentState> mapEventToState(
    CreditCardPaymentEvent event,
  ) async* {
    if (event is GetCreditCardPayment) {
      yield* _mapGetCreditCardPaymentToState();
    }
  }

  Stream<CreditCardPaymentState> _mapGetCreditCardPaymentToState() async* {
    yield CreditCardPaymentLoading();
    try {
      SharedPreferences sharedPreferences = sl<SharedPreferences>();
      String result = sharedPreferences.getString("paymentMethod");
      if (result == null) {
        yield CreditCardPaymentDone(<CreditCardPayment>[]);
      } else {
        PaymentMethod paymentMethod =
            PaymentMethod.fromJson(json.decode(result));
        yield CreditCardPaymentDone(paymentMethod.creditCards);
      }
    } catch (e) {
      print(e);
      yield CreditCardPaymentError(
          errorMessage: "Erro ao buscar os dados de pagamento");
    }
  }

  void saveCreditCardPayment(
      CreditCardPayment creditCardPayment,
      BuildContext context,
      Map<String, TextEditingController> controllers,
      bool isUpdate) {
    try {
      if (creditCardPayment.billingAddress == null) {
        BillingAddress billingAddress = BillingAddress(
            address: controllers[mapAddress].text,
            number: controllers[mapNumber].text,
            neighborhood: controllers[mapNeighborhood].text,
            complement: controllers[mapComplement].text ?? '',
            city: controllers[mapCity].text,
            state: controllers[mapState].text,
            cep: controllers[mapCEP].text,
            country: controllers[mapCountry].text);
        creditCardPayment.billingAddress = billingAddress;
      } else {
        creditCardPayment.billingAddress.address = controllers[mapAddress].text;
        creditCardPayment.billingAddress.number = controllers[mapNumber].text;
        creditCardPayment.billingAddress.neighborhood =
            controllers[mapNeighborhood].text;
        creditCardPayment.billingAddress.complement =
            controllers[mapComplement].text ?? '';
        creditCardPayment.billingAddress.city = controllers[mapCity].text;
        creditCardPayment.billingAddress.state = controllers[mapState].text;
        creditCardPayment.billingAddress.cep = controllers[mapCEP].text;
        creditCardPayment.billingAddress.country = controllers[mapCountry].text;
      }
      _insertOrUpdate(creditCardPayment);
      // Close loadingDialog
      Navigator.of(context).pop();
      AlertDialogUtil.showDoneDialog(
          context,
          'Salvo com sucesso!',
          () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PaymentMethodsScreen())));
    } catch (e) {
      AlertDialogUtil.showErrorDialog(context);
    }
  }

  void removeCreditCardPayment(
      CreditCardPayment creditCardPayment, BuildContext context) {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    String result = sharedPreferences.getString("paymentMethod");
    PaymentMethod paymentMethod = PaymentMethod.fromJson(json.decode(result));
    paymentMethod.creditCards.removeWhere(
        (value) => value.card.number == creditCardPayment.card.number);
    paymentMethod.creditCards.isEmpty
        ? sharedPreferences.remove('paymentMethod')
        : sharedPreferences.setString(
            'paymentMethod', json.encode(paymentMethod.toJson()));
    this.add(GetCreditCardPayment());
    // Pop on dialog
    Navigator.of(context).pop();
    // Pop to PaymentMethodScreen
    Navigator.of(context).pop();
  }

  void _insertOrUpdate(CreditCardPayment creditCardPayment) {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    PaymentMethod paymentMethod;
    int indexToUpdate = -1;
    if (sharedPreferences.getString("paymentMethod") != null) {
      String result = sharedPreferences.getString("paymentMethod");
      paymentMethod = PaymentMethod.fromJson(json.decode(result));
      paymentMethod.creditCards.asMap().forEach((index, element) {
        if (element.card.number == creditCardPayment.card.number) {
          indexToUpdate = index;
        }
      });
    } else {
      paymentMethod = PaymentMethod(<CreditCardPayment>[]);
    }
    if (indexToUpdate == -1) {
      paymentMethod.creditCards.add(creditCardPayment);
    } else {
      paymentMethod.creditCards.insert(indexToUpdate, creditCardPayment);
      paymentMethod.creditCards.removeAt(indexToUpdate + 1);
    }
    sharedPreferences.setString(
        'paymentMethod', json.encode(paymentMethod.toJson()));
    this.add(GetCreditCardPayment());
  }
}
