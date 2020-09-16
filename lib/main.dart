import 'package:credit_card/screen/configuration_screen.dart';
import 'package:credit_card/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  setupLocator();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConfigurationScreen(),
    );
  }
}
