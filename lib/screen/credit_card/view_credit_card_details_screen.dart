import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/credit_cards_utils.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/util/strings.dart';
import 'package:credit_card/util/text_style_utils.dart';
import 'package:credit_card/util/alert_dialog_util.dart';
import 'package:credit_card/widgets/continue_button_widget.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  void initState() {
    _cardCPFController.text = CreditCardsUtils.hideCreditCardNumber(
        widget.cardPayment.holder.cpf,
        isCpf: true);
    _initTextEditingControllers(widget.cardPayment.billingAddress);
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
              _buildBillingAddressForm(creditCardPayment: widget.cardPayment),
              Container(
                padding: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(16.0)),
                child: FlatButton(
                  child: Text(
                    "REMOVER",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => AlertDialogUtil.showWarningDialog(
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

  Widget _buildBillingAddressForm({CreditCardPayment creditCardPayment}) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
              child: Text("Endereço de cobrança",
                  style: TextStyleUtils.titleProfileSection)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapCEP],
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'CEP',
                  hintText: '00000-000'),
              validator: (value) {
                return value.isNotEmpty ? null : 'CEP invalido';
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.send,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapAddress],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Endereço',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'Endereço inválido';
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapNumber],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Número',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'Número inválido';
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapNeighborhood],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Bairro',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'Bairro inválido';
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapComplement],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Complemento',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapCity],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Cidade',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'Cidade inválida';
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapState],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Estado',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'Estado inválido';
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            child: TextFormField(
              controller: _controllers[mapCountry],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'País',
              ),
              validator: (value) {
                return value.isNotEmpty ? null : 'País invalido';
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(16)),
              child: ContinueButtonWidget(
                onPressedAction: () {
                  if (_formKey.currentState.validate()) {
                    AlertDialogUtil.showLoadingDialog(context, 'Processando');
                    sl<CreditCardPaymentBloc>().saveCreditCardPayment(
                        widget.cardPayment,
                        context,
                        _controllers,
                        widget.cardPayment.billingAddress != null);
                  }
                },
                buttonText: 'Salvar',
              )),
        ],
      ),
    );
  }

  void _initTextEditingControllers(BillingAddress billingAddress) {
    _controllers[mapAddress] =
        TextEditingController(text: billingAddress.address);
    _controllers[mapNumber] =
        TextEditingController(text: billingAddress.number);
    _controllers[mapNeighborhood] =
        TextEditingController(text: billingAddress.neighborhood);
    _controllers[mapComplement] =
        TextEditingController(text: billingAddress.complement ?? '');
    _controllers[mapCity] = TextEditingController(text: billingAddress.city);
    _controllers[mapState] = TextEditingController(text: billingAddress.state);
    _controllers[mapCEP] =
        MaskedTextController(mask: '00000-000', text: billingAddress.cep);
    _controllers[mapCountry] =
        TextEditingController(text: billingAddress.country ?? '');
  }

  void _disposeControllers() {
    _controllers.forEach((key, value) {
      value.clear();
    });
  }
}
