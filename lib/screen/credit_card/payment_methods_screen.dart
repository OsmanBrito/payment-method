import 'package:credit_card/bloc/credit_card_payment_bloc.dart';
import 'package:credit_card/model/credit_card_payment.dart';
import 'package:credit_card/screen/credit_card/add_credit_card_details_screen.dart';
import 'package:credit_card/screen/credit_card/view_credit_card_details_screen.dart';
import 'package:credit_card/service_locator.dart';
import 'package:credit_card/util/credit_cards_utils.dart';
import 'package:credit_card/util/size_config.dart';
import 'package:credit_card/widgets/continue_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {

  CreditCardPaymentBloc _bloc;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _bloc = sl<CreditCardPaymentBloc>();
    _bloc.add(GetCreditCardPayment());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cartões")),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => _bloc,
          child: Column(
            children: [
              BlocBuilder<CreditCardPaymentBloc, CreditCardPaymentState>(
                builder: (BuildContext context, state) {
                  if (state is CreditCardPaymentLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CreditCardPaymentDone) {
                    if (state.cardPayment.isEmpty) {
                      return _buildEmptyCards();
                    } else {
                      return _buildCreditCardsList(state.cardPayment);
                    }
                  } else if (state is CreditCardPaymentError) {
                    return Center(child: Text("Error!"));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              ContinueButtonWidget(
                onPressedAction: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCreditCardDetailsScreen())),
                buttonText: "Adicionar cartão",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardsList(List<CreditCardPayment> creditCards) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: creditCards.length,
      itemBuilder: (context, index) {
        return _buildItemCreditCards(creditCards[index]);
      },
    );
  }

  Widget _buildItemCreditCards(CreditCardPayment creditCard) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.sizeByPixel(8.0),
          right: SizeConfig.sizeByPixel(8.0),
          top: SizeConfig.sizeByPixel(8.0),
          bottom: SizeConfig.sizeByPixel(4.0)),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ViewCreditCardDetails(cardPayment: creditCard))),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(SizeConfig.sizeByPixel(16)),
            child: Row(
              children: [
                // Icon(Icons.credit_card),
                CreditCardsUtils.getCardTypeIcon(creditCard.card.number),
                Expanded(
                  child: Column(
                    children: [
                      Text(CreditCardsUtils.getCardTypeBrand(
                              creditCard.card.number)
                          .toString()),
                      Text(creditCard.card.number)
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCards() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.sizeByPixel(16.0)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(SizeConfig.sizeByPixel(16.0)),
                child: Text("Você ainda não possui nenhum cartão cadastrado.")
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.sizeByPixel(16.0)),
              child: SvgPicture.asset(
                "assets/svg/undraw_credit_card_payment_yb88.svg",
                height: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
