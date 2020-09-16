import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/screen/credit_card/add_billing_address_screen.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/credit_cards_utils.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/widgets/billing_address_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class ViewCreditCardDetails extends StatefulWidget {
  ViewCreditCardDetails({this.cardPayment});

  CreditCardPayment cardPayment;

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
              FlatButton(
                child: Text("REMOVER"),
                onPressed: () => sl<CreditCardPaymentBloc>().removeCreditCardPayment(widget.cardPayment, context),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// GestureDetector(
// onTap: () {},
// child: Card(
// margin: EdgeInsets.only(left: 16, top: 8, right: 16),
// child: Container(
// child: ListTile(
// title: Text("Endereço de cobrança"),
// leading: Icon(Icons.home),
// trailing: Icon(Icons.arrow_forward_ios),
// )
// // Row(
// //   crossAxisAlignment: CrossAxisAlignment.center,
// //   children: [
// //     Icon(Icons.home),
// //     Expanded(
// //       child: Text("Endereço de cobrança")
// //     ),
// //     Icon(Icons.arrow_forward_ios)
// //   ],
// // )
// ,
// ),
// ),
// ),
