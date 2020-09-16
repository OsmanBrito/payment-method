import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/credit_cards_utils.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/widgets/alert_dialog_widget.dart';
import 'package:credit_card/widgets/billing_address_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class ViewCreditCardDetails extends StatefulWidget {
  ViewCreditCardDetails({this.cardPayment});

  final CreditCardPayment cardPayment;

  @override
  _ViewCreditCardDetailsState createState() => _ViewCreditCardDetailsState();
}

class _ViewCreditCardDetailsState extends State<ViewCreditCardDetails> {
  final TextEditingController _cardCPFController =
      MaskedTextController(mask: '***.***.***-**');

  @override
  void initState() {
    _cardCPFController.text = CreditCardsUtils.hideCreditCardNumber(
        widget.cardPayment.holder.cpf,
        isCpf: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Dados do cartão"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: widget.cardPayment.card.number,
                expiryDate: widget.cardPayment.card.expirationDate,
                cardHolderName: widget.cardPayment.holder.name,
                cvvCode: widget.cardPayment.card.securityCode,
                showBackView: false,
                isToView: true,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                child: TextFormField(
                  controller: _cardCPFController,
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CPF do titular',
                    hintText: 'xxx.xxx.xxx-xx',
                  ),
                  validator: (value) {
                    return CPF.isValid(value) ? null : 'CPF invalido';
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              BillingAddressFormWidget(creditCardPayment: widget.cardPayment),
              Container(
                padding: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(16.0)),
                child: FlatButton(
                  child: Text(
                    "REMOVER",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => AlertDialogWidget.showWarningDialog(
                      context,
                      'Deseja remover este cartão?',
                      () => sl<CreditCardPaymentBloc>().removeCreditCardPayment(
                          widget.cardPayment, context)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
