import 'package:credit_card/screen/credit_card/payment_methods_screen.dart';
import 'package:credit_card/util/text_style_utils.dart';
import 'package:credit_card/widgets/profile_base_widget.dart';
import 'package:flutter/material.dart';

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPersonalData(),
            _buildDigitalPartner(),
            _buildPaymentMethod(context),
            _buildGeneral(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalData() {
    return ProfileBaseWidget(
      title: "Dados pessoais",
      widget: Column(
        children: [
          ListTile(
            title: Text('Nome', style: TextStyleUtils.titleBaseProfileSection),
            subtitle: Text(
              'Osman Brito',
              style: TextStyleUtils.subTitleBaseProfileSection,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('E-mail', style: TextStyleUtils.titleBaseProfileSection),
            subtitle: Text(
              'osman.gimenes@gmail.com',
              style: TextStyleUtils.subTitleBaseProfileSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalPartner() {
    return ProfileBaseWidget(
      title: "Sócio digital",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Minha conta Sócio Digital",
                  style: TextStyleUtils.textDigitalPartnerLink)),
          Divider(),
          Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Ajuda", style: TextStyleUtils.textDigitalPartnerLink))
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return ProfileBaseWidget(
      title: "Cupons - Formas de pagamento",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodsScreen()));
            },
              title: Text("Cartões de crédito",
                  style: TextStyleUtils.textPaymentMethod),
              trailing: Icon(Icons.keyboard_arrow_right)),
          Divider(),
          ListTile(
            onTap: (){},
              title: Text("Informações sobre o comprador",
                  style: TextStyleUtils.textPaymentMethod),
              trailing: Icon(Icons.keyboard_arrow_right))
        ],
      ),
    );
  }

  Widget _buildGeneral() {
    return ProfileBaseWidget(
      title: "Geral",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Atualizar",
                  style: TextStyleUtils.textDigitalPartnerLink)),
          Divider(),
          Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Redefinir senha", style: TextStyleUtils.textDigitalPartnerLink)),
          Divider(),
          Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Fazer logout", style: TextStyleUtils.textDigitalPartnerLink))
        ],
      ),
    );
  }
}
