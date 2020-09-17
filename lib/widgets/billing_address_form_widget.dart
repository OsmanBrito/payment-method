import 'package:credit_card/bloc/billing_address_bloc.dart';
import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/billing_address.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/util/strings.dart';
import 'package:credit_card/util/text_style_utils.dart';
import 'package:credit_card/util/alert_dialog_util.dart';
import 'package:credit_card/widgets/continue_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  BillingAddressBloc _bloc;

  @override
  void dispose() {
    _bloc.close();
    _disposeControllers();
    super.dispose();
  }

  @override
  void initState() {
    _initTextEditingControllers(widget.creditCardPayment.billingAddress);
    _bloc = BillingAddressBloc();
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
              onFieldSubmitted: (value) {
                _bloc.add(VerifyCEP(value));
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.send,
            ),
          ),
          BlocProvider(
              create: (_) => _bloc,
              child: Column(children: [
                BlocBuilder<BillingAddressBloc, BillingAddressState>(
                    builder: (BuildContext context, state) {
                  if (state is BillingAddressLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BillingAddressDone) {
                    _initTextEditingControllers(state.billingAddress);
                    return _buildForm();
                  } else if (state is BillingAddressError) {
                    return Center(child: Text('Erro, ${state.errorMessage}'));
                  } else {
                    return Container();
                  }
                })
              ]))
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
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
                if (formKey.currentState.validate()) {
                  AlertDialogUtil.showLoadingDialog(
                      context, 'Salvo com sucesso!');
                  sl<CreditCardPaymentBloc>().saveCreditCardPayment(
                      widget.creditCardPayment,
                      context,
                      _controllers,
                      widget.creditCardPayment.billingAddress != null);
                }
              },
              buttonText: 'Salvar',
            )),
      ],
    );
  }

  void _initTextEditingControllers(BillingAddress billingAddress) {
    _controllers[mapAddress] =
        TextEditingController(text: billingAddress?.address ?? '');
    _controllers[mapNumber] =
        TextEditingController(text: billingAddress?.number ?? '');
    _controllers[mapNeighborhood] =
        TextEditingController(text: billingAddress?.neighborhood ?? '');
    _controllers[mapComplement] =
        TextEditingController(text: billingAddress?.complement ?? '');
    _controllers[mapCity] =
        TextEditingController(text: billingAddress?.city ?? '');
    _controllers[mapState] =
        TextEditingController(text: billingAddress?.state ?? '');
    _controllers[mapCEP] = MaskedTextController(
        mask: '00000-000', text: billingAddress?.cep ?? '');
    _controllers[mapCountry] =
        TextEditingController(text: billingAddress?.country ?? '');
  }

  void _disposeControllers() {
    _controllers.forEach((key, value) {
      value.clear();
    });
  }
}
