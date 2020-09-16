import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/card.dart';
import 'package:credit_card/model/holder.dart';

class CreditCardPayment {
  CreditCard card;
  Holder holder;
  BillingAddress billingAddress;

  CreditCardPayment({this.card, this.holder, this.billingAddress});

  CreditCardPayment.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? CreditCard.fromJson(json['card']) : null;
    holder = json['holder'] != null ? Holder.fromJson(json['holder']) : null;
    billingAddress = json['billingAddress'] != null
        ? BillingAddress.fromJson(json['billingAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card'] = this.card.toJson();
    data['holder'] = this.holder.toJson();
    data['billingAddress'] = this.billingAddress.toJson();
    return data;
  }
}
