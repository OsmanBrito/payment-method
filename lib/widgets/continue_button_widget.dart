import 'package:credit_card/util/size_config.dart';
import 'package:flutter/material.dart';

class ContinueButtonWidget extends StatelessWidget {
  ContinueButtonWidget({this.onPressedAction, this.buttonText});

  final Function onPressedAction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.only(
            left: SizeConfig.sizeByPixel(10.0),
            right: SizeConfig.sizeByPixel(10.0),
            top: SizeConfig.sizeByPixel(8.0),
            bottom: SizeConfig.sizeByPixel(4.0)),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: onPressedAction,
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, color: Colors.white),
            Padding(
              padding: EdgeInsets.all(SizeConfig.sizeByPixel(5.0)),
            ),
            Text(buttonText.toUpperCase(), style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
