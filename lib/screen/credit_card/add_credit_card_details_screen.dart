import 'package:credit_card/model/card.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/model/holder.dart';
import 'package:credit_card/screen/credit_card/add_billing_address_screen.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/widgets/continue_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCreditCardDetailsScreen extends StatefulWidget {

  @override
  _AddCreditCardDetailsScreenState createState() =>
      _AddCreditCardDetailsScreenState();
}

class _AddCreditCardDetailsScreenState
    extends State<AddCreditCardDetailsScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cpf = '';
  bool isCvvFocused = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo cartão'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(16)),
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                localizedText: LocalizedText(
                    cardHolderLabel: 'Nome do titular',
                    expiryDateHint: 'MM/AA'),
              ),
              CreditCardForm(
                formKey: _formKey,
                localizedText: LocalizedText(
                    cardNumberLabel: 'Número do cartão',
                    expiryDateLabel: 'Data de validade',
                    expiryDateHint: 'MM/AA',
                    cardHolderLabel: 'Nome do titular',),
                onCreditCardModelChange: onCreditCardModelChange,
              ),
              ContinueButtonWidget(
                onPressedAction: () {
                  if (_formKey.currentState.validate()) {
                    CreditCardPayment creditCardPayment = CreditCardPayment(holder: Holder());
                    creditCardPayment.card = CreditCard();
                    creditCardPayment.card.expirationDate = expiryDate;
                    creditCardPayment.card.number = cardNumber;
                    creditCardPayment.card.securityCode = cvvCode;
                    creditCardPayment.holder.name = cardHolderName;
                    creditCardPayment.holder.cpf = cpf;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AddBillingAddressScreen(creditCardPayment)));
                  }
                },
                buttonText: "prosseguir",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
      cpf = creditCardModel.cpf;
    });
  }
}
