
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/widgets/billing_address_form_widget.dart';
import 'package:flutter/material.dart';

class AddBillingAddressScreen extends StatefulWidget {
  final CreditCardPayment creditCardPayment;

  AddBillingAddressScreen(this.creditCardPayment);

  @override
  _AddBillingAddressScreenState createState() =>
      _AddBillingAddressScreenState();
}

class _AddBillingAddressScreenState extends State<AddBillingAddressScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo cartão'),
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            child: BillingAddressFormWidget(
              creditCardPayment: widget.creditCardPayment,
            )),
      ),
    );
  }
}
