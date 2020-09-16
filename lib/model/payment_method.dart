import 'package:credit_card/model/credit_card_payment.dart';

class PaymentMethod {
  List<CreditCardPayment> creditCards;

  PaymentMethod(this.creditCards);

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    if (json['creditCards'] != null) {
      creditCards = new List<CreditCardPayment>();
      json['creditCards'].forEach((v) {
        creditCards.add(new CreditCardPayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creditCards'] = this.creditCards.map((v) => v.toJson()).toList();
    return data;
  }
}
