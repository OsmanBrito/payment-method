import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/util/strings.dart';
import 'package:credit_card/util/text_style_utils.dart';
import 'package:credit_card/widgets/continue_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class BillingAddressFormWidget extends StatefulWidget {
  CreditCardPayment creditCardPayment;

  BillingAddressFormWidget({this.creditCardPayment});

  @override
  _BillingAddressFormWidgetState createState() =>
      _BillingAddressFormWidgetState();
}

class _BillingAddressFormWidgetState extends State<BillingAddressFormWidget> {
  Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initTextEditingControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
              child: Text("Endereço de cobrança",
                  style: TextStyleUtils.textPaymentMethod)),
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
            ),
          ),
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
              textInputAction: TextInputAction.next,
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
                  if (formKey.currentState.validate()) {
                    sl<CreditCardPaymentBloc>().saveCreditCardPayment(
                        widget.creditCardPayment, context, _controllers);
                  }
                },
                buttonText: 'Salvar',
              )),
        ],
      ),
    );
  }

  void _initTextEditingControllers() {
    _controllers[mapAddress] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.address ?? '');
    _controllers[mapNumber] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.number ?? '');
    _controllers[mapNeighborhood] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.neighborhood ?? '');
    _controllers[mapComplement] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.complement ?? '');
    _controllers[mapCity] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.city ?? '');
    _controllers[mapState] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.state ?? '');
    _controllers[mapCEP] = MaskedTextController(
        mask: '00000-000',
        text: widget.creditCardPayment.billingAddress?.cep ?? '');
    _controllers[mapCountry] = TextEditingController(
        text: widget.creditCardPayment.billingAddress?.country ?? '');
  }
}

// if (widget.creditCardPayment.billingAddress != null) {
// _controllers[mapAddress] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.address ?? '');
// _controllers[mapNumber] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.number ?? '');
// _controllers[mapNeighborhood] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.neighborhood ?? '');
// _controllers[mapComplement] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.complement ?? '');
// _controllers[mapCity] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.city ?? '');
// _controllers[mapState] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.state ?? '');
// _controllers[mapCEP] = MaskedTextController(
// mask: '00000-000',
// text: widget.creditCardPayment.billingAddress.cep ?? '');
// _controllers[mapCountry] = TextEditingController(
// text: widget.creditCardPayment.billingAddress.country ?? '');
// } else {
// _controllers[mapAddress] = TextEditingController();
// _controllers[mapNumber] = TextEditingController();
// _controllers[mapNeighborhood] = TextEditingController();
// _controllers[mapComplement] = TextEditingController();
// _controllers[mapCity] = TextEditingController();
// _controllers[mapState] = TextEditingController();
// _controllers[mapCEP] = MaskedTextController(mask: '00000-000');
// _controllers[mapCountry] = TextEditingController();
// }
