import 'package:credit_card/util/text_style_utils.dart';
import 'package:flutter/material.dart';

class ProfileBaseWidget extends StatelessWidget {
  final String title;
  final Widget widget;

  const ProfileBaseWidget({this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 8.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(title, style: TextStyleUtils.titleProfileSection)),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: widget)
        ],
      ),
    );
  }
}
